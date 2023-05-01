import { ApiBaseClient } from "./apiBaseClient";
import { UserAuthProfile } from "../models/userAuthProfile";
import { APIRequestContext,APIRequest,expect} from "@playwright/test";


export class MatrixApiClient extends ApiBaseClient {
  

  public constructor(authProfile: UserAuthProfile,request:APIRequest) {
    super(authProfile,request);
  }

 

  public async authenticate() :Promise<APIRequestContext>{
    let context:APIRequestContext=await super.authenticate()
    return context
  }

  public async login(): Promise<APIRequestContext> {
    let options: any = {
      baseURL: this.authProfile.baseURL
    };
    const context: APIRequestContext = await super.login()
    this.isLoggedIn=false
    const login = await context.post('/_matrix/client/r0/login', {
      data: {
        
          "type": "m.login.password",
          "identifier": {
            "type": "m.id.user",
            "user": this.authProfile.user
          },
          "password": this.authProfile.password,
         
      }
    })
    expect(login.ok(),`Login as ${this.authProfile.user} ok`).toBeTruthy();
    const status=login.status()
    const json=await login.json()
    this.setUserData(json)
   
    if (json.access_token) {
      options.extraHTTPHeaders = {
        Authorization: "Bearer "+json.access_token,
      };
      this.isLoggedIn=true
      this.requestContext= await this.request.newContext(options)
      return this.requestContext
    }
    return context

  }

  public async logout() :Promise<void> {
    if( this.isLoggedIn) {
      const logout=await super.getRequestContext().post('/_matrix/client/r0/logout', {
        data: {
        }
      })
      const status=logout.status()
      const text=logout.statusText()
      expect(logout.ok(),`Logout as ${this.authProfile.user} ok`).toBeTruthy();

    }
    this.isLoggedIn=false
  }
}
