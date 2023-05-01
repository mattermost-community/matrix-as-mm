import { expect, APIRequestContext } from "@playwright/test";
import { faker } from "@faker-js/faker";
import { test } from "@e2e-support/fixtures/apiProfilesFixture";
import { MatrixApiClient } from "@e2e-support/apiModels/matrixApiClient";
import { MattermostApiClient } from "@e2e-support/apiModels/mattermostApiClient";

import * as pwHelpers from "@e2e-support/functions/pwHelper"

test.describe("The Matrix Connector - User Mapping", () => {
  let matrixContext: APIRequestContext;
  let matrixApiClient: MatrixApiClient;
  
  let mmContext: APIRequestContext;
  let mmApiClient: MattermostApiClient;
  let serverName = 'localhost'
  let matrixBridgeUser = 'matrix.bridge'
  let matterBotUser = '@matterbot:localhost'

  test.beforeAll(async ({ playwright, mattermost_admin, matrix_admin }) => {
    matrixApiClient = new MatrixApiClient(matrix_admin, playwright.request);
    serverName = matrixApiClient.getDomain()
    matterBotUser = '@matterbot:'+serverName
    matrixContext = await matrixApiClient.authenticate();
    mmApiClient = new MattermostApiClient(mattermost_admin, playwright.request);
    mmContext = await mmApiClient.login();
  });

  test("User Mapping Mattermost <-> Matrix", async ({ }) => {
    await test.step("Mattermost me", async () => {
      const get = await mmContext.get(`/api/v4/users/me`, {});
      expect(get.ok()).toBeTruthy();
      let me = await get.json();
    
      expect.soft(me.roles.includes("system_admin")).toBeTruthy();
    });

    let mmUsers = await test.step("Mattermost Users", async () => {
      const get = await mmContext.get(`api/v4/users`, {});
      expect(get.ok()).toBeTruthy();
      let allUsers = await get.json();
    
      let users: any[] = allUsers.filter((user) => {
        return !user?.is_bot;
      });
      return users;
    });
    let appServiceUsers = await test.step("Synapse Users", async () => {
      const get = await matrixContext.get(`/_synapse/admin/v2/users`, {});
      expect(get.ok()).toBeTruthy();
      let allUsers = await get.json();

      let asUsers: any[] = []
      for (let user of allUsers.users) {
        const get = await matrixContext.get(`/_synapse/admin/v2/users/${user.name}`, {});
        expect(get.ok()).toBeTruthy();
        let asUser = await get.json()
        if (asUser.appservice_id) {
          asUsers.push(asUser)
        }
      }
      return asUsers;
    });
    let matrixUsers = await test.step("Matrix Users", async () => {
      const post = await matrixContext.post(`/_matrix/client/v3/user_directory/search`,
        {
          data: {
            limit: 10000,
            search_term: serverName
          }
        });
      expect(post.ok()).toBeTruthy();
      let response = await post.json();
      let users = response.results
    
      return users;
    });
    await test.step("Summarize test and validate results", async () => {
      pwHelpers.infoAnnotation(test.info(), `Name of matrix bridge user = ${matrixBridgeUser}`)
      pwHelpers.infoAnnotation(test.info(), `Name matterbot usser = ${matterBotUser}`)
      pwHelpers.infoAnnotation(test.info(), `Number of Mattermost users = ${mmUsers.length}`)
      pwHelpers.infoAnnotation(test.info(), `Number of Matrix app service users = ${appServiceUsers.length}`)
      pwHelpers.infoAnnotation(test.info(), `Number of Matrix users = ${matrixUsers.length}`)

      const matrixBridge = mmUsers.find(user => {
        return user.username === matrixBridgeUser
      })
      expect.soft(matrixBridge, `Matrix bridge user ${matrixBridgeUser} exists`).toBeDefined()
      expect.soft(matrixBridge.roles.includes("system_admin"), "Matrix bridge is system admin").toBeTruthy();

      const mmTestUsers: any[] = mmUsers.filter(user => {
        const regex = /user\d+\.mm/;
        return regex.test(user.username)
      })
      expect.soft(mmTestUsers.length, "Mattermost test users exists").toBeGreaterThan(0)
      pwHelpers.infoAnnotation(test.info(), `Number of Mattermost test users = ${mmTestUsers.length}`)
    
      const matterBot = appServiceUsers.find(user => {
        return user.name === matterBotUser
      })
      expect.soft(matterBot, `Matrix app service bot user ${matterBotUser} exists`).toBeDefined()

      const asUsers: any[] = appServiceUsers.filter(user => {
        const regex = /@mm_user\d+\.mm:\S+/;
        return regex.test(user.name)
      })
      expect.soft(asUsers.length, "Matrix service users exists").toBeGreaterThan(0)
      pwHelpers.infoAnnotation(test.info(), `Number of matrix service users = ${asUsers.length}`)

      const matrixTestUsers: any[] = matrixUsers.filter(user => {
       
        const regex = /@user\d+\.matrix:\S+/;
        return regex.test(user.user_id)
      })
      expect.soft(matrixTestUsers.length, "Matrix test users exists").toBeGreaterThan(0)
      pwHelpers.infoAnnotation(test.info(), `Number of Matrix test users = ${matrixTestUsers.length}`)
    
    
    })

    

  });
});
