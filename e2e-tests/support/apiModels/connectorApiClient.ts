import { ApiBaseClient } from "./apiBaseClient";
import { UserAuthProfile } from "../models/userAuthProfile";
import { APIRequestContext,APIRequest,expect} from "@playwright/test";


export class ConnectorApiClient extends ApiBaseClient {
  public constructor(authProfile: UserAuthProfile,request:APIRequest) {
    super(authProfile,request);
  }
  public async authenticate() :Promise<APIRequestContext>{
    let context:APIRequestContext=await super.authenticate()
    return context
  }
}
