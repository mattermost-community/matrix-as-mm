import { ApiBaseClient } from "./apiBaseClient";
import { UserAuthProfile } from "../models/userAuthProfile";
import { APIRequestContext, APIRequest, expect } from "@playwright/test";


export class MattermostApiClient extends ApiBaseClient {
  public constructor(authProfile: UserAuthProfile, request: APIRequest) {
    super(authProfile, request);
  }

  public async login(): Promise<APIRequestContext> {
    let options: any = {
      baseURL: this.authProfile.baseURL
    };
    const context: APIRequestContext = await super.login()
    const login = await context.post('/api/v4/users/login', {
      data: {
        "login_id": this.authProfile.user, "password": this.authProfile.password
      }
    })
    const json=await login.json()
    this.setUserData(json)

    expect(login.ok(),`Login as ${this.authProfile.user} ok`).toBeTruthy();
    const headers: any[] = login.headersArray()

    const token = headers.find(header => { return header.name === 'Token' })
    if (token) {
      options.extraHTTPHeaders = {
        Authorization: "Bearer " + token.value,
      };
      this.requestContext= await this.request.newContext(options)
      return this.requestContext
    }
    this.isLoggedIn=true 
    return context

  }


  public async authenticate(): Promise < APIRequestContext > {
    const context: APIRequestContext = await super.authenticate()
    return context
  }
    
}
