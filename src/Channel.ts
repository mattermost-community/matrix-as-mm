import * as log4js from 'log4js';

import { MattermostMessage, MatrixEvent } from './Interfaces';

import { getLogger } from './Logging';
import Main from './Main';
import MatrixHandlers from './matrix/MatrixHandler';
import {
    getMatrixUsers,
    getMatrixClient,
    joinMatrixRoom,
} from './matrix/Utils';
import {
    getMattermostUsers,
    joinMattermostChannel,
    leaveMattermostChannel,
} from './mattermost/Utils';
import { MattermostHandlers } from './mattermost/MattermostHandler';

export default class Channel {
    private team?: string;
    private myLogger: log4js.Logger;

    constructor(
        public readonly main: Main,
        public readonly matrixRoom: string,
        public readonly mattermostChannel: string,
    ) {
        this.myLogger = getLogger('Channel');
    }

    public async getTeam(): Promise<string> {
        if (this.team === undefined) {
            this.team = (
                await this.main.client.get(
                    `/channels/${this.mattermostChannel}`,
                )
            ).team_id as string;
        }
        return this.team;
    }

    public async syncChannel(): Promise<void> {
        const [matrixUsers, mattermostUsers] = await Promise.all([
            getMatrixUsers(this.main, this.matrixRoom),
            getMattermostUsers(this.main.client, this.mattermostChannel),
        ]);

        for (const matrix_userid of matrixUsers.real.values()) {
            if (!this.main.skipMatrixUser(matrix_userid)) {
                const user = await this.main.matrixUserStore.getOrCreate(
                    matrix_userid,
                    true,
                );
                mattermostUsers.delete(user.mattermost_userid);
                await joinMattermostChannel(this, user);
            }
        }

        for (const userid of mattermostUsers.values()) {
            if (!this.main.skipMattermostUser(userid)) {
                if (!(await this.main.isMattermostUser(userid))) {
                    await leaveMattermostChannel(
                        this.main.client,
                        this.mattermostChannel,
                        userid,
                    );
                } else {
                    const user =
                        await this.main.mattermostUserStore.getOrCreate(
                            userid,
                            true,
                        );
                    matrixUsers.remote.delete(user.matrix_userid);

                    const client = this.main.botClient;
                    await joinMatrixRoom(client, this.matrixRoom);
                }
            }
        }

        for (const matrix_userid of matrixUsers.remote.values()) {
            const user = this.main.mattermostUserStore.get(matrix_userid);
            if (user) {
                const client = await this.main.mattermostUserStore.client(user);
                await client.leave(this.matrixRoom);
            }
        }
    }

    public async onMattermostMessage(m: MattermostMessage): Promise<void> {
        const handler = MattermostHandlers[m.event];

        if (handler === undefined) {
            this.myLogger.debug(`Unknown mattermost message type: ${m.event}`);
        } else {
            await handler.bind(this)(m);
        }
    }

    public async onMatrixEvent(event: MatrixEvent): Promise<void> {
        const handler = MatrixHandlers[event.type];
        if (handler === undefined) {
            this.myLogger.debug(`Unknown matrix event type: ${event.type}`);
        } else {
            await handler.bind(this)(event);
        }
    }
}
