import * as log4js from 'log4js';
import * as mxClient from '../matrix/MatrixClient';
import { User } from '../entities/User';
import { config } from '../Config';
//import Mutex from '../utils/Mutex';
import { Mutex, withTimeout, E_TIMEOUT, MutexInterface } from 'async-mutex';
import Main from '../Main';
import { inDebugger } from '../utils/Functions';
import { MattermostUserInfo } from '../Interfaces';
import {
    getMatrixClient,
    loginAppService,
    registerAppService,
} from '../matrix/Utils';
import { getLogger } from '../Logging';

export default class MattermostUserStore {
    private users: Map<string, User>;
    private clients: Map<string, mxClient.MatrixClient>;
    private mutex: Mutex;
    private myLogger: log4js.Logger;
    constructor(private readonly main: Main) {
        this.mutex = new Mutex();
        this.users = new Map();
        this.clients = new Map();
        this.myLogger = getLogger('MattermostUserStore');
    }

    public get(userid: string): User | undefined {
        return this.users.get(userid);
    }

    public countUsers(): number {
        return this.users.size;
    }

    public async getOrCreate(
        userid: string,
        sync: boolean = false,
    ): Promise<User> {
        const mutexTimeout = inDebugger() ? 60000 : 3000;
        const mutex: MutexInterface = withTimeout(new Mutex(), mutexTimeout);
        const release = await mutex.acquire();
        try {
            let user = this.users.get(userid) || null;
            if (user) {
                await this.updateUser(undefined, user);
                return user;
            }

            const count = await User.count({
                //mattermost_userid: userid,
                where: { mattermost_userid: userid },
            });
            if (count > 0) {
                user = await User.findOne({
                    //mattermost_userid: userid,
                    where: { mattermost_userid: userid },
                });
                if (user && user?.is_matrix_user) {
                    throw new Error(
                        `Trying to get Matrix user ${userid} from MattermostUserStore`,
                    );
                }
            }
            if (count === 0 || user) {
                const data = await this.main.client.get(`/users/${userid}`);
                const server_name = config().homeserver.server_name;
                const username = `${config().matrix_localpart_prefix}${
                    data.username
                }`;
                const matrix_userId: string =
                    `@${username}:${server_name}` || '';
                if (!matrix_userId) {
                    this.myLogger.error(
                        'Can not create a valid matrix user id for %s. username %s ,server name %s',
                        userid,
                        username || 'empty or undefined not valid',
                        server_name || 'empty or undefined not valid',
                    );
                    throw 'Matrix user id not valid';
                } else {
                    this.myLogger.debug('Matrix userid=%s', matrix_userId);
                }

                const info = await registerAppService(
                    this.main.botClient,
                    username,
                    this.myLogger,
                );

                this.myLogger.info(
                    `Creating matrix puppet ${matrix_userId} Mattermost userid: ${userid}`,
                );
                user = await User.createMattermostUser(
                    this.main.client,
                    matrix_userId,
                    userid,
                    data.username,
                    '', // Set the displayname to be '' for now. It will be updated in updateUser
                );

                if (user) {
                    await this.updateUser(data, user);
                    this.users.set(userid, user);
                    return user;
                }
            }
        } catch (error) {
            if (error == E_TIMEOUT) {
            } else {
                this.myLogger.error(
                    `Get or creating Matrix puppet user ${userid} failed . Error=${error.message}`,
                );
            }
        } finally {
            release();
        }
        // throw `Failed to create new Matrix puppet user for Mattermost userid ${userid}`;
    }

    public async updateUser(
        data: MattermostUserInfo | undefined,
        user: User,
    ): Promise<void> {
        if (data === undefined) {
            data = (await this.main.client.get(
                `/users/${user.mattermost_userid}`,
            )) as MattermostUserInfo;
        }

        let displayName = data.username;
        if (data.first_name || data.last_name) {
            displayName = `${data.first_name} ${data.last_name}`.trim();
        }
        displayName = config()
            .matrix_display_name_template.replace('[DISPLAY]', displayName)
            .replace('[USERNAME]', data.username);

        if (
            user.mattermost_username !== data.username ||
            user.matrix_displayname !== displayName
        ) {
            user.mattermost_username = data.username;
            user.matrix_displayname = displayName;
            await user.save();
        }
        //await this.client.(user).setDisplayName(displayName);
    }

    public async logoutClients() {
        this.myLogger.info(
            'Logging out Matrix clients. Number of clients=%d',
            this.clients.size,
        );
        try {
            await Promise.all(
                Array.from(this.clients.entries(), async ([, client]) => {
                    client.logout();
                }),
            );
        } catch (e) {
            this.myLogger.error(
                'Error when logging out Matrix clients %s',
                e.message,
            );
        }
    }

    public async client(user: User): Promise<mxClient.MatrixClient> {
        let client = this.clients.get(user.matrix_userid);
        //let userName= user.matrix_userid.slice(1,user.matrix_userid.indexOf(':'))
        if (client === undefined) {
            client = getMatrixClient(
                this.main.registration,
                user.matrix_userid,
            );

            await loginAppService(client, client.getUserId(), true);
            this.clients.set(user.matrix_userid, client);
            const me = await client.whoAmI();
            this.myLogger.debug('Matrix client user = %s', me);
        }
        return client;
    }

    public async getOrCreateClient(
        userid: string,
        sync: boolean = false,
    ): Promise<mxClient.MatrixClient> {
        return this.client(await this.getOrCreate(userid, sync));
    }

    public async getClient(
        userid: string,
    ): Promise<mxClient.MatrixClient | undefined> {
        const user = this.get(userid);
        if (user === undefined) {
            this.myLogger.error('Failed to get Matrix client for %s', userid);
            return undefined;
        } else {
            return this.client(user);
        }
    }
}
