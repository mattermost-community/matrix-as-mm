import {
    Entity, PrimaryColumn, Column, BaseEntity, CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import { Client, ClientError } from '../mattermost/Client';
import { config } from '../Config';
import { randomString } from '../utils/Functions';
const PERSONAL_ACCESS_TOKEN_NAME = 'For the bridge';

@Entity('users')
export class User extends BaseEntity {
    @PrimaryColumn('text')
    public matrix_userid!: string;

    @Column('character', { length: '26', nullable: false })
    public mattermost_userid!: string;

    @Column('text', { nullable: false })
    public access_token!: string;

    @Column('boolean', { nullable: false })
    public is_matrix_user!: boolean;

    @Column('text', { nullable: false })
    public mattermost_username!: string;

    @Column('text', { nullable: false })
    public matrix_displayname!: string;

    @Column('varchar', { nullable: true, length: 128 })
    public email_match!: string;

    @CreateDateColumn()
    created_at!: Date;

    @UpdateDateColumn()
    updated_at!: Date;

    private _client?: Client;

    public get client(): Client {
        if (this._client === undefined) {
            this._client = new Client(
                config().mattermost_url,
                this.mattermost_userid,
                this.access_token,
            );
        }
        return this._client;
    }

    public static async createMatrixUser(
        client: Client,
        matrix_userid: string,
        username: string,
        displayname: string,
        userInfo: any,
        email: string = undefined,

    ): Promise<User> {

        let emailMatch: string = null

        if (!userInfo) {
            if (email) {
                const emailUser = await client.get(`/users/email/${email}`, undefined, false, false)
                if (emailUser.status === 200) {
                    emailMatch = email
                    email=`duplicate_${email}`
                }

            } else {
                email = config()
                    .mattermost_email_template.replace(
                        '[USERNAME]',
                        randomString(16),
                    )
                    .replace('[RANDOM]', randomString(16))

            }
            userInfo = await client.post('/users', {
                username: username,
                password: randomString(45) + 'aA#2',
                first_name: displayname,
                email: email
            });

            const verifyEmail = await client.post(
                `/users/${userInfo.id}/email/verify/member`,
            );

        } else {
            const tokens = await client.get(`/users/${userInfo.id}/tokens`)
            for (const userToken of tokens) {
                if (userToken.description === PERSONAL_ACCESS_TOKEN_NAME && userToken.is_active) {
                    await client.post('/users/tokens/revoke',
                        {
                            "token_id": userToken.id
                        }
                    )
                }
            }
        }
        const token = await client.post(`/users/${userInfo.id}/tokens`, {
            description: PERSONAL_ACCESS_TOKEN_NAME,
        });

        const user = User.create({
            matrix_userid,
            mattermost_userid: userInfo.id,
            access_token: token.token,
            is_matrix_user: true,
            mattermost_username: username,
            matrix_displayname: displayname,
            email_match: emailMatch

        });
        await user.save();
        return user;
    }

    public static async createMattermostUser(
        client: Client,
        matrix_userid: string,
        mattermost_userid: string,
        username: string,
        displayname: string,
    ): Promise<User> {
        const myTokens: any = await client.get(
            `/users/${mattermost_userid}/tokens`,
        );
        let haveToken = myTokens.find(token => {
            return (
                token.description === PERSONAL_ACCESS_TOKEN_NAME &&
                token.is_active
            );
        });
        if (haveToken) {
            let user = await User.findOne({
                //mattermost_userid: userid,
                where: { mattermost_username: username },
            });
            if (user) {
                return user;
            }
        }

        let token: any = await client.post(
            `/users/${mattermost_userid}/tokens`,
            {
                description: PERSONAL_ACCESS_TOKEN_NAME,
            },
        );

        const user = User.create({
            matrix_userid,
            mattermost_userid,
            access_token: token?.token || '',
            is_matrix_user: false,
            mattermost_username: username,
            matrix_displayname: displayname,
        });
        await user.save();

        return user;
    }
}
