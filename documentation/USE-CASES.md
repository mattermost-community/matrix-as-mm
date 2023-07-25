# Use cases for connecting Mattermost and Matrix

## Mattermost UI - Use cases

![Bridge uses cases in Mattermost](./images/mm-ui.jpg)

- Users will use the UI to work with distributed channels exactly in the same ways as working with ordinary public channels and group channels.
- Public channels for communication with Matrix will be created by admin users in Mattermost. Only admin users can create these channels.
- The public channels for federation with Matrix must be created in the *default* team.
- The default team is created when first admin users is created in Mattermost. The does not need to be default.
- All users can create group channels for direct messaging with Matrix users.
- All users can create private channels for communicating with Matrix users.
- Group channels for direct messaging and private distributed channels must include the _matrix.bridge_ user. It is required for communication with Matrix users.

### Create group channel for chatting with Matrix users

![Create group channel](./images/mm-ui-group-channel.jpg)

- Create the Direct Message channel in the UI.
- For communication with Matrix you must include matrix users and the _matrix.bridge_ user.
- Matrix user has names starting with the prefix \_matrix\_\_. An example matrix_user2.matrix is the user user2.matrix in Matrix.
- Now this group channel is enabled for communication with Matrix user user2.matrix

### Settings for the the default team
![Create public channel](./images/mm-default-team.png)
- If you enable *Allow any user with an account on this server to join this team* settings all Mattermost user will be invited to this team automatically. It means that they will be able to join all rooms in the team.
- The setting described above is the most simple setting, but it may not be compliant to your policies for channel memberships. 

### Create a federated(distributed) Public Channel

![Create public channel](./images/mm-federated-channel.png)

- Only user with system admin role can create these channels.
- The channels must be in the **default** team.
- The _matrix.bridge_ user must be invited. When this user is invited the mapping to a public room in Matrix is created.

### Create a federated(distributed) Private Channel

![Create public channel](./images/mm-private-channel.png)

- All users can create these channels.
- The _matrix.bridge_ user must be invited. When this user is invited the mapping to a private room in Matrix is created.

## Matrix (Element) UI - Main use cases

### Direct messaging - Start chat from Mattermost

![start a chat](./images/element-start-chatt.png)

- Accept the invitation by pressing on **Start chatting** button

### Direct messing - Chatting with mattermost user

![element chatting](./images/element-chatting.png)

- Use the chat room as you do in communication with other Element users.

### Direct messaging - Start a chat with mattermost users

![element invite](./images/element-invite-to-chat.png)

- You must invite mattermost users and the the special user _Mattermost Bridge_.
- Mattermost users begins with the \_mm\_\_ prefix mm_user2.mm is user2.mm in mattermost.

### Join federated public rooms

![element join public](./images/element-join-public.png)

- Just join the public rooms you are interested of.
- The federated public rooms work exactly as normal public rooms

### Join federated private rooms

![element join private](./images/element-join-private.png)

- You will get an invitation from the creator of the 🔐 private room.
- The federated private rooms work exactly as normal private rooms.
- 🙁 You cannot create a private federated from Element in this release of the connector.

### Create private/public federated room

![element create private](./images/element-priv-room.png)
- You create a new room in the Element UI. 
- It can be a private or public room. 
- For a private room you will need to disable the end-to-end encryption option.
- For public room you need to set an unique room alias. Good practice is to use small letters of the room name for the alias.
- Both public and private rooms need invitations of members.

![element invite to room](./images/element-invite-to-room.png)
- For a room to be federated to Mattermost the **Mattermost Bridge** user and Mattermost puppet users need to be invited.
- You can invite several Mattermost users and several local users to the federated room.

![element first room message](./images/element-first-message.png)
- The mapped channel in Mattermost is created when the first message is sent to the room.
- You will see a notice message that the channel is created on the **matrixrooms** team in Mattermost.

![mm on first channel message](./images/mm-on-first-message.png)
- The mapped federated channel is now available in Mattermost for the invited users.
- All features for post and respond to messages are available. 
- You can see that we now supports reactions and emojis in both directions. 


![element after first room message](./images/element-after-first-message.png)
- Messages from the mapped Mattermost channel is available in the room
- You can invite more local and puppet users to the room from the UI.


### EMail federation

![email federation](./images/mm-email.png)

- The email address for a user in matrix will be copied to mattermost, if it is not defined in mattermost for an existing user.
- This feature works if matrix home server is Synapse.
