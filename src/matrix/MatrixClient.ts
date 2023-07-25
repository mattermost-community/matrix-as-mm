import * as log4js from 'log4js';
import { getLogger } from '../Logging';

import * as axios from 'axios';
import * as https from 'https';
import * as http from 'http';
import { string } from 'yargs';

const TRACE_ENV_NAME = 'API_TRACE';

export type Membership = 'join' | 'leave' | 'invite' | 'knock' | 'ban';

export type RoomPreset =
    | 'public_chat'
    | 'private_chat'
    | 'trusted_private_chat';

export type RoomVisibility = 'public' | 'private';

export interface RoomCreateContent {
    preset: RoomPreset;
    visibility: RoomVisibility;
    room_alias_name?: string;
    name?: string;
    topic?: string;
    invite?: string[];
    room_version?: string;
    /*
    "creation_content": {
        "m.federate": false
    }
    */
    is_direct: boolean;
}

export interface RoomCreatedInfo extends RoomCreateContent {
    room_id: string;
}

export interface MatrixClientCreateOpts {
    userId: string;
    baseUrl: string;
    accessToken?: string;
    apiTrace?: boolean;
}

export enum SessionCreatedWith {
    None = 0,
    RegisterAppService,
    LoginAppService,
    LoginPassword,
}

export interface MessageContent {
    body: string;
    msgtype: string;
    format?: string;
    formatted_body?: string;
    [propName: string]: unknown;
}

/*
export interface SendRoomContent {
    content:MessageContent;
   
}
*/

export class MatrixClient {
    private myLogger: log4js.Logger;
    private client: axios.AxiosInstance;
    private userId: string;
    private baseUrl: string;
    private accessToken: string;
    private sessionCreateMethod: SessionCreatedWith = SessionCreatedWith.None;
    private sessionIsValid: boolean = false;
    private logoutDone: boolean = false;
    readonly apiTrace;

    constructor(options: MatrixClientCreateOpts) {
        //super()
        this.apiTrace = options.apiTrace || false;
        if (!this.apiTrace) {
            const apiTraceEnv = process.env[TRACE_ENV_NAME];
            this.apiTrace = apiTraceEnv && apiTraceEnv === 'true';
        }
        this.myLogger = getLogger(
            'MatrixClient',
            this.apiTrace ? 'trace' : 'debug',
        );

        this.accessToken = options.accessToken || '';
        (this.userId = options.userId), (this.baseUrl = options.baseUrl);
        const httpsAgent = new https.Agent({
            keepAlive: true,
        });
        const httpAgent = new http.Agent({
            keepAlive: true,
        });

        const bearer: string = this.accessToken
            ? `Bearer ${options.accessToken}`
            : '';
        this.client = axios.default.create({
            baseURL: options.baseUrl,
            httpsAgent: httpsAgent,
            httpAgent: httpAgent,
            headers: {
                Authorization: bearer,
            },
        });
        this.myLogger.trace(
            'New matrix client created for userId=%s, baseUrl=%s,accessToken=%s',
            this.userId,
            this.baseUrl,
            this.accessToken,
        );
    }
    public getClient(): axios.AxiosInstance {
        return this.client;
    }
    public isSessionValid(): boolean {
        return this.sessionIsValid;
    }

    public getSessionCreateMethod(): SessionCreatedWith {
        return this.sessionCreateMethod;
    }

    public getUserId(): string {
        return this.userId;
    }

    public setUserId(userId: string) {
        this.userId = userId;
    }

    public getAccessToken(): string {
        return this.accessToken;
    }

    public setAccessToken(token: string) {
        this.accessToken = token;
    }

    public getBaseUrl(): string {
        return this.baseUrl;
    }

    public async getWellKnownClient(): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.get(
            '/.well-known/matrix/client',
        );
        return resp.data;
    }

    public async whoAmI(): Promise<any> {
        return this.doRequest({
            url: '_matrix/client/r0/account/whoami',
        });
    }

    public async getPublicRooms(limit: number = 100): Promise<any> {
        return this.doRequest({
            url: '_matrix/client/v3/publicRooms',
            params: { limit: limit },
        });
    }

    public async getRoomVisibility(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/r0/directory/list/room/${roomId}`,
        });
    }

    public async getRoomStateAll(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/state`,
        });
    }

    public async getRoomState(roomId: string, state: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/state/${state}`,
        });
    }

    public async sendRedactEvent(
        roomId: string,
        eventId: string,
        reason: string = '',
    ): Promise<any> {
        const txnId: string = 'm' + Date.now();
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/r0/rooms/${roomId}/redact/${eventId}/${txnId}`,

            data: { reason: reason },
        });
    }

    public async sendReaction(
        roomId: string,
        eventId: string,
        key: string,
    ): Promise<any> {
        const txnId: string = 'm' + Date.now();
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/r0/rooms/${roomId}/send/m.reaction/${txnId}`,

            data: {
                'm.relates_to': {
                    rel_type: 'm.annotation',
                    event_id: eventId,
                    key: key,
                },
            },
        });
    }

    public async sendStateEvent(
        roomId: string,
        eventType: string,
        stateKey: string,
        data?: any,
    ): Promise<any> {
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/rooms/${roomId}/state/${eventType}/${stateKey}`,
            data: data,
        });
    }
    public async getRoomEvent(roomId: string, eventId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/event/${eventId}`,
        });
    }

    public async getRoomAliases(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/aliases`,
        });
    }

    public async getRoomMembers(
        roomId: string,
        membership: Membership = 'join',
    ): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/members`,
            params: { membership: membership },
        });
    }

    public async getJoinedMembers(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/joined_members`,
        });
    }

    public async invite(
        roomId: string,
        userId: string,
        reason: string = 'Invited to room',
    ): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/invite`,
            method: 'POST',
            data: {
                user_id: userId,
                reason: reason,
            },
        });
    }

    public async joinRoom(
        roomId: string,
        reason: string = 'joining room',
    ): Promise<any> {
        return await this.doRequest({
            method: 'POST',
            url: `_matrix/client/v3/rooms/${roomId}/join`,
            data: {
                reason: reason,
            },
        });
    }

    public async leave(
        roomId: string,
        reason: string = 'leaving room',
    ): Promise<any> {
        return await this.doRequest({
            method: 'POST',
            url: `_matrix/client/v3/rooms/${roomId}/leave`,
            data: {
                reason: reason,
            },
        });
    }

    public async getJoinedRooms(): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/joined_rooms`,
        });
    }

    public async createRoom(content: RoomCreateContent): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/createRoom`,
            method: 'POST',
            data: content,
        });
    }

    public async registerService(userName?: string): Promise<string> {
        let retValue: string = 'OK';
        try {
            const resp: axios.AxiosResponse = await this.client.post(
                '/_matrix/client/r0/register',
                {
                    username: userName || this.userId,
                    type: 'm.login.application_service',
                },
                {
                    params: { as_token: this.accessToken },
                },
            );
            retValue = resp.statusText;
        } catch (error: any) {
            const me = MatrixClient.getMatrixError(error);
            const code = me.data.errcode;
            if (code && code === 'M_USER_IN_USE') {
                retValue = code;
            } else {
                throw error;
            }
        }
        this.sessionCreateMethod = SessionCreatedWith.RegisterAppService;
        this.sessionIsValid = true;
        return retValue;
    }

    public async loginAppService(
        userName: string,
        setToken: boolean = false,
    ): Promise<any> {
        const responseData = await this.doRequest({
            method: 'POST',
            url: '/_matrix/client/r0/login',

            data: {
                username: userName,
                type: 'm.login.application_service',
                identifier: {
                    type: 'm.id.user',
                    user: userName,
                },
            },
        });
        if (setToken) {
            this.setAccessToken(responseData.access_token);
        }
        this.sessionCreateMethod = SessionCreatedWith.LoginAppService;
        this.sessionIsValid = true;
        return responseData;
    }

    public async loginWithPassword(
        userName: string,
        password: string,
    ): Promise<any> {
        const responseData = await this.doRequest({
            method: 'POST',
            url: '/_matrix/client/r0/login',

            data: {
                identifier: {
                    type: 'm.id.user',
                    user: userName,
                },
                initial_device_display_name: `${userName}_device`,
                password: password,
                type: 'm.login.password',
            },
        });
        this.sessionCreateMethod = SessionCreatedWith.LoginPassword;
        this.sessionIsValid = true;
        this.setAccessToken(responseData.access_token);
        return responseData;
    }

    public async logout() {
        this.sessionIsValid = false;
        this.logoutDone = true;
        return await this.doRequest({
            method: 'POST',
            url: '/_matrix/client/v3/logout',
        });
    }

    public async isAvailable(userName: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/r0/register/available`,
            params: {
                username: userName,
            },
        });
    }

    public async getProfileInfo(userId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/profile/${userId}`,
        });
    }

    public async getUserDisplayName(userId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/profile/${userId}/displayname`,
        });
    }

    public async setUserDisplayName(
        userId: string,
        displayName: string,
    ): Promise<any> {
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/profile/${userId}/displayname`,
            data: {
                displayname: displayName,
            },
        });
    }

    public async sendTyping(
        roomId: string,
        userId: string,
        typing: boolean = true,
        timeout: number = 2000,
    ): Promise<any> {
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/rooms/${roomId}/typing/${userId}`,
            data: {
                timeout: timeout,
                typing: typing,
            },
        });
    }

    public async sendMessage(
        roomId: string,
        eventType: string,
        content: MessageContent,
    ): Promise<any> {
        const txnId: string = 'm' + Date.now();
        //this.myLogger.debug('send Message: ', content);
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/rooms/${roomId}/send/${eventType}/${txnId}`,
            data: content,
        });
    }

    public async download(
        serverName: string,
        mediaId: string,
        fileName: string,
    ) {
        const content = await this.doRequest({
            url: `/_matrix/media/v3/download/${serverName}/${mediaId}/${fileName}`,
            responseType: 'arraybuffer',
        });
        return content;
    }

    public async upload(
        fileName: string,
        extension: string,
        contentType: string,
        data: Buffer,
    ): Promise<any> {
        const responseType: axios.ResponseType = 'arraybuffer';

        let headers: any = {};
        if (contentType) {
            headers = {
                'Content-Type': contentType,
            };
        }
        try {
            const content = await this.doRequest({
                method: 'POST',
                url: '_matrix/media/v3/upload',
                //responseType: responseType,
                headers: {
                    headers,
                },
                params: {
                    filename: fileName,
                },
                data: data,
            });
            return content.content_uri;
        } catch (error) {
            this.myLogger.fatal(
                'Failed to upload content file=%s , contentType=%s',
                fileName,
                contentType,
            );
            throw error;
        }
    }

    private async doRequest(options: axios.AxiosRequestConfig) {
        let myOptions: axios.AxiosRequestConfig = {
            headers: { Authorization: `Bearer ${this.accessToken}` },
            validateStatus: function (status) {
                return status >= 200 && status < 300; // default
            },
        };
        const method = options.method || 'GET';
        myOptions = Object.assign(myOptions, options);

        this.myLogger.trace(
            `${method} ${this.getBaseUrl()}/${
                options.url
            }. Active userId=${this.getUserId()}, Valid Session= ${
                this.sessionIsValid
            }`,
        );
        try {
            const response: axios.AxiosResponse = await this.client.request(
                myOptions,
            );
            return response.data;
        } catch (e: any) {
            const me = MatrixClient.getMatrixError(e);
            if (!this.sessionIsValid && me) {
                return me;
            }
            if (me.error) {
                this.myLogger.error(
                    `${method} ${options.url} error: ${me.errcode}:${me.error} statusText= ${me.statusText}`,
                );
            } else {
                this.myLogger.error(
                    `${method} ${options.url} error message: ${e.message}`,
                );
            }
            throw me.error ? me : e;
        }
    }

    public static getMatrixError(error: any): any {
        const er = error?.response;
        const me: any = {};
        if (er) {
            me.data = er.data;
            me.status = er.status;
            me.statusText = er.statusText;
        }
        return me;
    }
}
