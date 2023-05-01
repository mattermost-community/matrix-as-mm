/*
 * Client for working directly with the Synapse Matrix Server - Admin API
 */

import * as log4js from 'log4js';
import { getLogger } from '../Logging';
import { MatrixClient } from './MatrixClient';

import * as axios from 'axios';
import * as https from 'https';
import * as http from 'http';

const TRACE_ENV_NAME = 'API_TRACE';

export class SynapseAdminClient {
    private client: axios.AxiosInstance;
    readonly apiTrace;
    private myLogger: log4js.Logger;
    private isValid:boolean=false

    private constructor(matrixClient: MatrixClient) {
        this.client = matrixClient.getClient();
        this.apiTrace = matrixClient.apiTrace;
        this.myLogger = getLogger(
            'SynapseAdminClient',
            this.apiTrace ? 'trace' : 'debug',
        );
    }

    public async getUserAccount(userId: string): Promise<any> {
        return this.doRequest({
            method: 'GET',
            url: `_synapse/admin/v2/users/${userId}`,
        });
    }

    public async isAdmin(userId: string): Promise<any> {
        return this.doRequest({
            method: 'GET',
            url: `_synapse/admin/v1/users/${userId}/admin`,
        });
    }

    public async whoIs(userId: string): Promise<any> {
        return this.doRequest({
            method: 'GET',
            url: `_synapse/admin/v1/whois/${userId}`,
        });
    }

    public async loginAs(userId: string): Promise<any> {
        return this.doRequest({
            method: 'POST',
            url: `_synapse/admin/v1/users/${userId}/login`,
        });
    }

    private async doRequest(options: axios.AxiosRequestConfig): Promise<any> {
        let method = options.method || 'GET';
        this.myLogger.trace(`${method} ${options.url}`);
        try {
            let response: axios.AxiosResponse = await this.client.request(
                options,
            );
            return response.data;
        } catch (e: any) {
            const me = MatrixClient.getMatrixError(e);

            if (me) {
                this.myLogger.error(
                    `${method} ${options.url} error: ${me.errcode}:${me.error}`,
                );
            }
            throw me || e;
        }
    }

    static async createClient (matrixClient: MatrixClient):Promise<SynapseAdminClient>{
        const synapseClient = new SynapseAdminClient(matrixClient)
        try {
            const isAdmin=await synapseClient.isAdmin(matrixClient.getUserId())
            if(isAdmin.admin === true) {
                synapseClient.isValid=true
                synapseClient.myLogger.info("Synapse admin client created for %s",matrixClient.getUserId())
                return synapseClient
            }
        }
        catch (error) {
            synapseClient.myLogger.error("Not a Matrix Synapse admin client. Message=%s",error.message)
        }
        return undefined

    }
}
