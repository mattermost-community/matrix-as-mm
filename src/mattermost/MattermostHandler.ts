import * as log4js from 'log4js';
import * as mxClient from '../matrix/MatrixClient';
import Channel from '../Channel';
import { Post } from '../entities/Post';
import { User } from '../entities/User';
import { Mapping } from '../entities/Mapping';
import Main from '../Main';
import { getLogger } from '../Logging';
import {
    MattermostMessage,
    MattermostPost,
    MatrixMessage,
    MatrixEvent,
    MattermostFileInfo,
} from '../Interfaces';
import { config } from '../Config';
//import { joinMatrixRoom } from '../matrix/Utils';
import { handlePostError, none } from '../utils/Functions';
import { mattermostToMatrix, constructMatrixReply } from '../utils/Formatting';
import * as emoji from 'node-emoji';

const myLogger: log4js.Logger = getLogger('MattermostHandler');

interface Metadata {
    replyTo?: {
        matrix: string;
        mattermost: string;
    };
}

const matrixUsersInRoom: Map<string, string> = new Map<string, string>();

async function joinUserToMatrixRoom(
    client: mxClient.MatrixClient,
    roomId: string,
    ownerClient: mxClient.MatrixClient,
) {
    const userId = client.getUserId() || '';
    const roomKey: string = `${userId}:${roomId}`;
    if (userId) {
        if (matrixUsersInRoom.get(roomKey) === undefined) {
            const rooms = await client.getJoinedRooms();
            const foundRoom = rooms.joined_rooms.find(room => {
                return room === roomId;
            });
            if (!foundRoom) {
                const inv = await ownerClient.invite(roomId, userId);
                const join = await client.joinRoom(roomId);
            }
            matrixUsersInRoom.set(roomKey, userId);
        }
    }
}

async function sendMatrixMessage(
    client: mxClient.MatrixClient,
    room: string,
    postid: string,
    message: MatrixMessage,
    metadata: Metadata,
) {
    let rootid = postid;
    let original: MatrixEvent = {} as any;
    if (metadata.replyTo !== undefined) {
        const replyTo = metadata.replyTo;
        rootid = replyTo.mattermost;

        try {
            original = await client.getRoomEvent(room, replyTo.matrix);
        } catch (e) { }
        if (original !== undefined) {
            constructMatrixReply(original, message);
        }
    }

    const event = await client.sendMessage(room, 'm.room.message', message);

    await Post.create({
        postid,
        rootid,
        eventid: event.event_id,
    }).save();
    return event.event_id;
}

export const MattermostUnbridgedHandlers = {
    posted: async function (this: Main, m: MattermostMessage): Promise<void> {
        if (m.data?.post) {
            const post: MattermostPost = JSON.parse(
                m.data.post,
            ) as MattermostPost;
            if (
                (post.type || '') === 'system_add_to_channel' &&
                (post.props?.addedUserId || '') ===
                config().mattermost_bot_userid
            ) {
                switch (m.data.channel_type) {
                    case 'O':
                        await this.onChannelCreated(m.broadcast.channel_id);
                        break;
                    case 'P':
                        await mapPrivateChannel(this, m);
                        break;
                }
            } else if (m.data.channel_type === 'G') {
                await mapGroupChannel(this, m);
            }
        }
    },
    group_added: async function (
        this: Main,
        m: MattermostMessage,
    ): Promise<void> {
        myLogger.info('Event group_added ignored.');
    },
};

const groupChannelMap = new Map<string, string>();

async function mapPrivateChannel(main: Main, m: MattermostMessage) {
    const channelId = m.broadcast.channel_id;
    const channel = await main.client.get(`/channels/${channelId}`);
    const members = await main.client.get(`/channels/${channelId}/members`);
    const invite: string[] = [];

    for (const member of members) {
        const mmUser = await User.findOne({
            where: { mattermost_userid: member.user_id, is_matrix_user: true },
        });
        if (mmUser) {
            invite.push(mmUser.matrix_userid);
        } else {
        }
    }

    const client: mxClient.MatrixClient =
        await main.mattermostUserStore.getOrCreateClient(channel.creator_id);

    const info = await client.createRoom({
        preset: 'private_chat',
        is_direct: false,
        name: channel.display_name,
        visibility: 'private',

        room_alias_name: channel.name,
        invite: invite,
    });
    main.doOneMapping(channel.id, info.room_id);
    const botClientUserId = main.botClient.getUserId();
    await client.invite(info.room_id, botClientUserId, 'Needed for federation');
    await main.botClient.joinRoom(info.room_id);
    const mapping = new Mapping();
    mapping.matrix_room_id = info.room_id;
    mapping.mattermost_channel_id = channel.id;
    mapping.info = `Channel display name: ${channel.display_name}`;
    mapping.from_mattermost = false;
    mapping.is_direct = false;
    await mapping.save();

    const post: MattermostPost = JSON.parse(m.data.post) as MattermostPost;
    const postMessage = await mattermostToMatrix(post.message);
    await sendMatrixMessage(
        client,
        info.room_id,
        post.id,

        postMessage,
        {},
    );
}

async function mapGroupChannel(main: Main, m: MattermostMessage) {
    const channelId = m.broadcast.channel_id;
    const channel = await main.client.get(`/channels/${channelId}`);

    const invite: string[] = [main.botClient.getUserId()];
    const joiners: User[] = [];

    const senderName: string = m.data.sender_name.slice(1);
    const sender = await User.findOne({
        where: { mattermost_username: senderName },
    });
    if (!sender) return;

    const client: mxClient.MatrixClient =
        await main.mattermostUserStore.getOrCreateClient(
            sender.mattermost_userid,
        );

    const members = channel.display_name.split(', ');

    for (const member of members) {
        const mmUser = await User.findOne({
            where: { mattermost_username: member, is_matrix_user: true },
        });
        if (mmUser) {
            invite.push(mmUser.matrix_userid);
        } else {
        }
    }
    if (invite.length === 1) {
        return;
    }
    for (const member of members) {
        const mmUser = await User.findOne({
            where: { mattermost_username: member, is_matrix_user: false },
        });
        if (mmUser) {
            if (mmUser.mattermost_userid != sender.mattermost_userid) {
                invite.push(mmUser.matrix_userid);
                joiners.push(mmUser);
            }
        }
    }

    let room_id = groupChannelMap.get(channel.display_name);
    if (room_id === undefined) {
        const info = await client.createRoom({
            preset: 'private_chat',
            is_direct: true,
            //name: channel.channel_display_name,
            visibility: 'private',
            //room_alias_name: channel.name,
            invite: invite,
        });
        groupChannelMap.set(channel.display_name, info.room_id);
        main.doOneMapping(channel.id, info.room_id);
        await main.botClient.joinRoom(info.room_id);
        const mapping = new Mapping();
        mapping.matrix_room_id = info.room_id;
        mapping.mattermost_channel_id = channel.id;
        mapping.info = `Channel display name: ${channel.display_name}`;
        mapping.from_mattermost = false;
        await mapping.save();
        room_id = info.room_id;
    }
    if (room_id) {
        const post: MattermostPost = JSON.parse(m.data.post) as MattermostPost;
        const postMessage = await mattermostToMatrix(post.message);
        await sendMatrixMessage(
            client,
            room_id,
            post.id,

            postMessage,
            {},
        );
        for (const joiner of joiners) {
            const roomClient: mxClient.MatrixClient =
                await main.mattermostUserStore.getOrCreateClient(
                    joiner.mattermost_userid,
                );
            await roomClient.joinRoom(
                room_id,
                'Room for direct messaging joined',
            );
            myLogger.info(
                `User ${joiner.matrix_userid} joining room ${room_id} for direct messaging`,
            );
        }
    }
}

const MattermostPostHandlers = {
    '': async function (
        this: Channel,
        client: mxClient.MatrixClient,
        post: MattermostPost,
        metadata: Metadata,
    ) {
        const postMessage = await mattermostToMatrix(post.message);
        await sendMatrixMessage(
            client,
            this.matrixRoom,
            post.id,
            //await mattermostToMatrix(post.message),
            postMessage,
            metadata,
        );

        if (post.metadata.files !== undefined) {
            for (const file of post.metadata.files) {
                // Read everything into memory to compute content-length
                const body: Buffer = await this.main.client.getFile(file.id);
                let mimetype = file.mime_type;
                const fileName = `${file.name}`;

                let msgtype = 'm.file';

                if (mimetype.startsWith('image/')) {
                    msgtype = 'm.image';
                } else if (mimetype.startsWith('audio/')) {
                    msgtype = 'm.audio';
                } else if (mimetype.startsWith('video/')) {
                    msgtype = 'm.video';
                } else if (file.extension === 'mp4') {
                    mimetype = 'image/mp4';
                    msgtype = 'm.video';
                }

                const url = await client.upload(
                    fileName,
                    file.extension,
                    mimetype,
                    body,
                );

                myLogger.debug(
                    `Sending to Matrix ${msgtype} ${mimetype} ${url}`,
                );
                const info = {
                    size: file.size,
                    mimetype: mimetype,
                };
                if (file.height && file.width) {
                    info['w'] = file.width;
                    info['h'] = file.height;
                }
                await sendMatrixMessage(
                    client,
                    this.matrixRoom,
                    post.id,
                    {
                        msgtype,
                        body: file.name,
                        url,
                        info: info,
                    },
                    metadata,
                );
            }
        }

        client
            .sendTyping(this.matrixRoom, client.getUserId(), false, 3000)
            .catch(e =>
                myLogger.warn(
                    `Error sending typing notification to ${this.matrixRoom}\n${e.stack}`,
                ),
            );
    },
    me: async function (
        this: Channel,
        client: mxClient.MatrixClient,
        post: MattermostPost,
        metadata: Metadata,
    ) {
        await sendMatrixMessage(
            client,
            this.matrixRoom,
            post.id,
            await mattermostToMatrix(post.props.message, 'm.emote'),
            metadata,
        );
        client
            .sendTyping(this.matrixRoom, client.getUserId(), false, 3000)
            .catch(e =>
                myLogger.warn(
                    `Error sending typing notification to ${this.matrixRoom}\n${e.stack}`,
                ),
            );
    },
};

export const MattermostHandlers = {
    posted: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const post: MattermostPost = JSON.parse(m.data.post) as MattermostPost;
        if (post.type.startsWith('system_')) {
            return;
        }
        if (post.user_id === config().mattermost_bot_userid) {
            return;
        }

        if (!(await this.main.isMattermostUser(post.user_id))) {
            return;
        }

        const client = await this.main.mattermostUserStore.getClient(
            post.user_id,
        );
        if (client === undefined) {
            return;
        }
        const metadata: Metadata = {};
        if (post.root_id !== '') {
            try {
                const threadResponse = await this.main.client.get(
                    `/posts/${post.root_id}/thread`,
                );

                // threadResponse.order often contains duplicate entries
                const threads = Object.values(threadResponse.posts)
                    .sort((a: any, b: any) => a.create_at - b.create_at)
                    .map((x: any) => x.id);

                const thisIndex = threads.indexOf(post.id);
                const id = threads[thisIndex - 1] as string;
                const replyTo = await Post.findOne({
                    //postid: id
                    where: { postid: id },
                });
                if (replyTo) {
                    metadata.replyTo = {
                        matrix: replyTo.eventid,
                        mattermost: post.root_id,
                    };
                }
            } catch (e) {
                await handlePostError(this.main.dataSource, e, post.root_id);
            }
        }

        const handler = MattermostPostHandlers[post.type];
        if (handler !== undefined) {
            await handler.bind(this)(client, post, metadata);
        } else {
            myLogger.debug(`Unknown post type: ${post.type}`);
        }
    },
    post_edited: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const post = JSON.parse(m.data.post);
        if (!(await this.main.isMattermostUser(post.user_id))) {
            return;
        }
        const client = await this.main.mattermostUserStore.getOrCreateClient(
            post.user_id,
        );

        const matrixEvent = await Post.findOne({
            //postid: post.id,
            where: { postid: post.id },
        });
        const msgtype = post.type === '' ? 'm.text' : 'm.emote';

        const msg = await mattermostToMatrix(post.message, msgtype);
        msg.body = `* ${msg.body}`;
        if (msg.formatted_body) {
            msg.formatted_body = `* ${msg.formatted_body}`;
        }

        if (matrixEvent) {
            msg['m.new_content'] = await mattermostToMatrix(
                post.message,
                msgtype,
            );
            msg['m.relates_to'] = {
                event_id: matrixEvent.eventid,
                rel_type: 'm.replace',
            };
        }
        /*
        await client.sendMessage(this.matrixRoom, m.event, {
            msgtype: msg.msgtype,
            body: msg.body,
        });
        */
        await sendMatrixMessage(client, this.matrixRoom, post.id, msg, {});
    },
    post_deleted: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        // See the README for details on the logic.
        const post = JSON.parse(m.data.post);
        const user = await User.findOne({
            where: { mattermost_userid: post.user_id, is_matrix_user: false },
        });
        if (!user) {
            return;
        }
        const client = await this.main.mattermostUserStore.getOrCreateClient(
            post.user_id,
        );

        // There can be multiple corresponding Matrix posts if it has
        // attachments.
        const matrixEvents = await Post.find({
            where: [{ rootid: post.id }, { postid: post.id }],
        });

        //const promises: Promise<unknown>[] = [Post.removeAll(this.main.dataSource,post.postid)];
        // It is okay to redact an event already redacted.
        for (const event of matrixEvents) {
            await client.sendRedactEvent(
                this.matrixRoom,
                event.eventid,
                'Post Deleted',
            );
            /*
            await this.main.botClient.sendStateEvent(
                this.matrixRoom,
                'm.room.redaction',
                this.main.botClient.getUserId(),
                {
                    event_id: event.eventid,
                },
            )
            */
            await Post.removeAll(this.main.dataSource, post.postid);
        }
    },
    reaction_added: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const reaction = JSON.parse(m.data.reaction);

        const post: Post = await Post.findOne({
            where: { postid: reaction.post_id },
        });

        const theEmoji = emoji.get(reaction.emoji_name);
        if (!theEmoji) {
            myLogger.error(`Unknown emoji ${reaction.emoji_name} `);
        } else {
            const client =
                await this.main.mattermostUserStore.getOrCreateClient(
                    reaction.user_id,
                );
            await client.sendReaction(this.matrixRoom, post.eventid, theEmoji);
        }
    },

    user_added: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const channel = await this.main.client.get(
            `/channels/${this.mattermostChannel}`,
        );
        if (channel.type == 'P') {
            const owner = await this.main.mattermostUserStore.getOrCreateClient(
                channel.creator_id,
            );
            const user = User.findOne({
                where: { mattermost_userid: m.data.user_id },
            });
            await owner.invite(this.matrixRoom, (await user).matrix_userid);
        } else {
            const client =
                await this.main.mattermostUserStore.getOrCreateClient(
                    m.data.user_id,
                );
            await joinUserToMatrixRoom(
                client,
                this.matrixRoom,
                this.main.adminClient,
            );
        }
    },
    user_removed: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const client = await this.main.mattermostUserStore.getClient(
            m.data.user_id,
        );
        if (client !== undefined) {
            await client.leave(this.matrixRoom);
            const roomKey: string = `${client.getUserId()}:${this.matrixRoom}`;
            matrixUsersInRoom.delete(roomKey);
        }
    },
    leave_team: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        await MattermostHandlers.user_removed.bind(this)(m);
    },
    typing: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const client = await this.main.mattermostUserStore.getClient(
            m.data.user_id,
        );

        if (client !== undefined) {
            await joinUserToMatrixRoom(
                client,
                this.matrixRoom,
                this.main.adminClient,
            );
            client
                .sendTyping(this.matrixRoom, client.getUserId(), true, 6000)
                .catch(e =>
                    myLogger.warn(
                        `Error sending typing notification to ${this.matrixRoom}\n${e.stack}`,
                    ),
                );
        }
    },
    channel_viewed: none,
};

export const MattermostMainHandlers = {
    hello: none,
    added_to_team: none,
    new_user: none,
    status_change: none,
    channel_viewed: none,
    preferences_changed: none,
    sidebar_category_updated: none,
    channel_created: async function (
        this: Main,
        m: MattermostMessage,
    ): Promise<void> {


        const ok = await this.onChannelCreated(m.data.channel_id);

    },
    direct_added: async function (
        this: Main,
        m: MattermostMessage,
    ): Promise<void> {
        await this.client.post('/posts', {
            channel_id: m.broadcast.channel_id,
            message: 'This is a bot. You will not get a reply',
        });
    },
    user_updated: async function (
        this: Main,
        m: MattermostMessage,
    ): Promise<void> {
        const user = this.mattermostUserStore.get(m.data.user.id);
        if (user !== undefined) {
            await this.mattermostUserStore.updateUser(m.data.user, user);
        }
    },
};
