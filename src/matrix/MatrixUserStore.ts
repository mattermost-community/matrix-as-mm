import * as log4js from 'log4js';

import { User } from '../entities/User';

import { Mutex, withTimeout, E_TIMEOUT, MutexInterface } from 'async-mutex';
import Main from '../Main';
import { localpart, sanitizeMattermostUsername } from '../utils/Functions';
import { config } from '../Config';
import { inDebugger } from '../utils/Functions';
import { getLogger } from '../Logging';

export default class MatrixUserStore {
    public readonly byMatrixUserId: Map<string, User>;
    public readonly byMattermostUserId: Map<string, User>;

    private myLogger: log4js.Logger;
    constructor(private readonly main: Main) {
        this.byMatrixUserId = new Map();
        this.byMattermostUserId = new Map();
        this.myLogger = getLogger('MatrixUserStore');
    }

    public get(matrix_userid: string): User | undefined {
        const user = this.byMatrixUserId.get(matrix_userid);
        return user;
    }

    public async getOrCreate(
        matrix_userid: string,
        sync: boolean = false,
    ): Promise<User> {
        const mutexTimeout = inDebugger() ? 120000 : 3000;
        const mutex: MutexInterface = withTimeout(new Mutex(), mutexTimeout);
        const release = await mutex.acquire();
        try {
            let user = this.get(matrix_userid);
            if (user !== undefined) {
                return user;
            }
            user = await User.findOne({
                //matrix_userid,
                where: { matrix_userid: matrix_userid },
            });

            if (user) {
                const info = await user.client.get(
                    '/users/me',
                    undefined,
                    false,
                    false,
                );
                if (
                    info.status === 200 &&
                    info.data.username == user.mattermost_username &&
                    this.get(matrix_userid) == undefined
                ) {
                    this.myLogger.debug(
                        `Mapping mattermost puppet user id: ${user.mattermost_userid} name: ${user.mattermost_username} to matrix user: ${matrix_userid}`,
                    );
                    this.byMatrixUserId.set(matrix_userid, user);
                    this.byMattermostUserId.set(user.mattermost_userid, user);
                    return user;
                }
            }
            const client = this.main.client;
            const localpart_ = localpart(matrix_userid);
            const template = config().mattermost_username_template;

            let displayname = '';

            if (template.includes('[DISPLAY]')) {
                try {
                    const resp = await this.main.botClient.getProfileInfo(
                        matrix_userid,
                    );
                    if (resp.displayname) {
                        displayname = resp.displayname;
                    }
                } catch (e) {
                    // Some users have no display name
                }
            }

            const username = template
                .replace('[DISPLAY]', displayname)
                .replace('[LOCALPART]', localpart_);

            let userInfo = undefined;
            const info = await client.post('/users/usernames', [username]);
            if (info.length > 0) {
                userInfo = info[0];
            }
            const email = await this.getUserEmail(matrix_userid);

            user = await User.createMatrixUser(
                client,
                matrix_userid,
                username,
                displayname,
                userInfo,
                email,
            );
            this.myLogger.debug(
                `Creating mattermost puppet user id: ${user.mattermost_userid} name:  ${user.mattermost_username} for matrix user: ${matrix_userid}`,
            );

            this.byMatrixUserId.set(matrix_userid, user);
            this.byMattermostUserId.set(user.mattermost_userid, user);
            return user;
        } catch (error) {
            if (error == E_TIMEOUT) {
            } else {
                this.myLogger.error(
                    'Get or creating mattermost user failed %s',
                    error.message,
                );
            }
        } finally {
            release();
        }
    }

    public async updateUser(user: User): Promise<void> {
        let displayname = localpart(user.matrix_userid);

        try {
            const resp = await this.main.botClient.getProfileInfo(
                user.matrix_userid,
            );
            if (resp.displayname) {
                displayname = resp.displayname;
            }
        } catch (e) {
            // Some users have no display name
        }

        if (user.matrix_displayname !== displayname) {
            user.matrix_displayname = displayname;
            await user.save();
        }

        await this.main.client.put(`/users/${user.mattermost_userid}/patch`, {
            first_name: displayname,
            last_name: '',
        });
    }

    /**
     * Given a mattermost userid, return the corresponding User if it is a
     * puppet of a matrix user, or null otherwise.
     */
    public async getByMattermost(
        mattermostUserId: string,
    ): Promise<User | null> {
        const cached = this.byMattermostUserId.get(mattermostUserId);
        if (cached !== undefined) {
            return cached;
        }

        const count = await User.count({
            where: { mattermost_userid: mattermostUserId },
        });
        if (count > 0) {
            const response = await User.findOne({
                where: { mattermost_userid: mattermostUserId },
            });
            if (response === null || response.is_matrix_user === false) {
            } else {
                return response;
            }
        }
        return null;
    }

    private async getUserEmail(matrix_userid: string): Promise<string> {
        const client = this.main.synapseClient;
        if (client) {
            try {
                const info = await client.getUserAccount(matrix_userid);
                if (info.threepids && info.threepids.length > 0) {
                    const firstEmail = info.threepids.find(tp => {
                        return tp.medium === 'email';
                    });
                    if (firstEmail) {
                        this.myLogger.info(
                            'Found email %s for %s',
                            firstEmail.address,
                            matrix_userid,
                        );
                        return firstEmail.address;
                    }
                }
            } catch (error) {
                this.myLogger.error(
                    'Failed to get account information for %s',
                    matrix_userid,
                );
            }
        }
        return undefined;
    }
}
