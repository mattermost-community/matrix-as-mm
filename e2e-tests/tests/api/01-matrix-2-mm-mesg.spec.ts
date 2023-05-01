import { expect, APIRequestContext } from "@playwright/test";
import { faker } from "@faker-js/faker";
import { test } from "@e2e-support/fixtures/apiProfilesFixture";
import { MatrixApiClient } from "@e2e-support/apiModels/matrixApiClient";
import { MattermostApiClient } from "@e2e-support/apiModels/mattermostApiClient";
import { ConnectorApiClient} from "@e2e-support/apiModels/connectorApiClient";
import * as pwHelper from '@e2e-support/functions/pwHelper'


test.describe("Matrix Connector - Test send messages and reply", () => {
  let matrixContext: APIRequestContext;
  let matrixApiClient: MatrixApiClient;
  
  let mmContext: APIRequestContext;
  let mmApiClient: MattermostApiClient;
  let connectorContext: APIRequestContext;
  let connectorApiClient:ConnectorApiClient
 
  let roomName: string = "town-square";
  let idleTime:number=500

  let hackerPhrase = faker.hacker.phrase();
  let fakeEmail=faker.internet.email();
  

  test.beforeAll(async ({ playwright, matrix_user1, mattermost_user1,matrix_connector }) => {
    connectorApiClient = new ConnectorApiClient(matrix_connector, playwright.request);
    connectorContext= await connectorApiClient.authenticate();
    matrixApiClient = new MatrixApiClient(matrix_user1, playwright.request);
    matrixContext = await matrixApiClient.login();
    mmApiClient = new MattermostApiClient(mattermost_user1, playwright.request);
    mmContext = await mmApiClient.login();
  
  });

  test.afterAll(async () => {
    if (matrixApiClient.loggedIn()) {
      await matrixApiClient.logout()
    }

  }
  )

  test("Matrix to Mattermost - Post message and reply", async ({}) => {
    let eventId = ''
    let roomId=''
    pwHelper.infoAnnotation(test.info(), `The federated public room name=${roomName}`)

    await test.step("Check that Matrix connector is running", async () => {
          const apiResponse =await connectorContext.get('/bridge/status')
          expect(apiResponse.ok()).toBeTruthy();
          const status=await apiResponse.text()
          expect(status,"The matrix connector is running").toBe('running')
      });

    await test.step("Send Text message from Matrix", async () => {
      let publicRooms: any[] = await test.step("Get Public rooms", async () => {
        const rooms = await matrixContext.get(
          `/_matrix/client/r0/publicRooms?limit=100`,
          {}
        );
        expect(rooms.ok()).toBeTruthy();
        let json = await rooms.json();
        pwHelper.infoAnnotation(test.info(), `Number of public matrix rooms are ${json.chunk.length}`)
        return json.chunk;
      });

      roomId =
        await test.step(`Get the public rooms: ${roomName} `, async () => {
          expect(
            publicRooms.length,
            "More than one public room expected."
          ).toBeGreaterThanOrEqual(2);
          let roomAlias = `#${roomName}:${matrixApiClient.getDomain()}`;
          let theRoom = publicRooms.find((room) => {
            return room.canonical_alias === roomAlias;
          });
          expect(theRoom).not.toBeUndefined();
          return theRoom.room_id;
        });
      


      let theMessage = await test.step("Send Text Message", async () => {
        const transactionId = "m." + Date.now();
        let message = `Strange message seen:\n${hackerPhrase}\n from ${fakeEmail}`;

        
        let apiResponse = await matrixContext.put(
          `/_matrix/client/r0/rooms/${roomId}/send/m.room.message/${transactionId}`, 
          {
          data: {
            body: message,
            msgtype: "m.text",
          },
        });
        expect(apiResponse.ok()).toBeTruthy();
        let json = await apiResponse.json();
        eventId = json.event_id
        return message;
      });
    });

    await pwHelper.wait(idleTime)

    await test.step("Get the post in Mattermost", async () => {
      let defaultTeam =
        await test.step("Get the default team from Mattermost", async () => {
          const teams = await mmContext.get(
            `/api/v4/users/me/teams?page=0&per_page=200`,
            {}
          );
          expect(teams.ok()).toBeTruthy();
          let json: any[] = await teams.json();
          expect(json.length, "Number of teams is greater than 0").toBeGreaterThanOrEqual(1);
          const defaultTeam = json.at(0)
          return defaultTeam


        });
      let theChannel =
        await test.step("Get The channel from Mattermost", async () => {
          const channels = await mmContext.get(
            `/api/v4/users/me/channels?page=0&per_page=200`,
            {}
          );
          expect(channels.ok()).toBeTruthy();
          let json: any[] = await channels.json();

          let theChannel = json.find(channel => {
            return channel.name === roomName && channel.team_id === defaultTeam.id;
          });
          expect(theChannel).toBeDefined();
          return theChannel;
        });

      const thePost = await test.step("Get the post from matrix in the channel", async () => {
        let since: number = Date.now() - 30 * 1000;

        const apiResponse = await mmContext.get(
          `/api/v4/channels/${theChannel.id}/posts?page=0&per_page=100&since=${since}`,
          {}
        );
        expect(apiResponse.ok()).toBeTruthy();
        let json = await apiResponse.json();

        expect(json.order.length, "Should find posts.").toBeGreaterThanOrEqual(1);
        let posts: any[] = Object.values(json.posts);
        let thePost = posts.find((post) => {
          return post.message.includes(hackerPhrase);
        });
        expect(
          thePost,
          `Post with message ${hackerPhrase} should be found channel ${roomName}`
        ).toBeDefined();

        return thePost;
      });
     const replyMessage=await test.step("Reply to the post from matrix", async () => {
        const replyMessage=`I have seen the strange message from ${fakeEmail}`
        const apiResponse = await mmContext.post(
          `/api/v4/posts`,
          {
            data: {
              channel_id: thePost.channel_id,
              message: replyMessage,
              root_id: thePost.id,
            }
          }
        );
        expect(apiResponse.ok()).toBeTruthy();
        let json = await apiResponse.json();
        return replyMessage

      })
      await pwHelper.wait(idleTime* 3)
      await test.step("Check the reply from mattermost in matrix", async () => {
        const limit=10
        const apiResponse = await matrixContext.get(
          `/_matrix/client/r0/rooms/${roomId}/messages?dir=b&limit=${limit}`,
          {
            
          }
        );
        expect(apiResponse.ok()).toBeTruthy();
        let json = await apiResponse.json();
        let messages:any[]=json.chunk
        expect(messages.length).toBeGreaterThan(1)
       
        const matrixEvent= messages.find (message=> {
          return message.event_id === eventId
        })
        expect(matrixEvent.event_id,"The posted room message in Matrix contains correct event id").toBe(eventId)
        const mmEvent= messages.find (message=> {
          const id=message.content["m.relates_to"]?.["m.in_reply_to"]?.event_id
          const body:string= message.content.body || ''
          return body.includes(fakeEmail) && id
          
        })
        
        expect(mmEvent,"The reply message from Mattermost is found").toBeDefined() 
        expect (mmEvent.sender.includes(mmApiClient.authProfile.user)).toBeTruthy()
        pwHelper.infoAnnotation(test.info(), `The matrix user name sending the reply=${mmEvent.sender}`)
      })
    });
  });
})
