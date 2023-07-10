import { UserAuthProfile } from '../models/userAuthProfile';
import { APIRequestContext, APIRequest } from '@playwright/test';

export abstract class ApiBaseClient {
    protected isLoggedIn: boolean = false;
    readonly authProfile: UserAuthProfile;
    protected requestContext: APIRequestContext = undefined as any;
    protected request: APIRequest;
    protected userData: any = {} as any;
    public constructor(authProfile: UserAuthProfile, request: APIRequest) {
        this.authProfile = authProfile;
        this.request = request;
    }

    public getUserData(): any {
        return this.userData;
    }

    protected setUserData(userData: any) {
        this.getUserData = userData;
    }

    public loggedIn(): boolean {
        return this.isLoggedIn;
    }

    public getRequestContext(): APIRequestContext {
        return this.requestContext;
    }
    protected async authenticate(): Promise<APIRequestContext> {
        let options: any = {
            baseURL: this.authProfile.baseURL,
        };
        if (this.authProfile.bearerToken) {
            options.extraHTTPHeaders = {
                Authorization: 'Bearer ' + this.authProfile.bearerToken,
            };
        }
        this.requestContext = await this.request.newContext(options);
        return this.requestContext;
    }

    protected async login(): Promise<APIRequestContext> {
        let options: any = {
            baseURL: this.authProfile.baseURL,
        };

        this.requestContext = await this.request.newContext(options);
        return this.requestContext;
    }

    public getDomain(): string {
        return this.authProfile.domain || '';
    }

    public hasLogin(): boolean {
        return this.authProfile.password ? true : false;
    }
}
