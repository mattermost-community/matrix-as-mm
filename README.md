# Mattermost ↔ Matrix Connector

**Mattermost Matrix Connector** is a bridge between Matrix and Mattermost.The main use case is to share channels/rooms and chats between Mattermost and Matrix compatible platforms.

The integration to Matrix is based on the Application Service API. It means that matrix part of the connector must support this standard API. We are using the Synapse Matrix server in development. [More information about Synapse Matrix platform can be found at](https://matrix.org/docs/projects/server/synapse).

## Original product

This is complete new version of the bridge spawned from https://github.com/dalcde/matrix-appservice-mattermost.

## Main use cases

|     | Use case                           | Description                                                                                                                |
| --- | ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| 🔓  | Federated Public Channels/Rooms  | Posts from public channels in Mattermost are federated to public rooms in Matrix. This use case works in both directions.  |
| 🔐  | Federated Private Channels/Rooms | Posts from private channels in Mattermost are federated to public rooms in Matrix. This use case works in both directions. |
| 💬  | Federated direct message chats   | Federated chats can be created in both platforms.                                                                        |

### Details on functionality

- Federated public channels are created by an administrator in Mattermost.
- Private federated channels can be created by all users in Mattermost.
- Private/Public rooms can be created by all users in Matrix. Public rooms in this context require invitations from creator.
- Direct message chats can be created in both platforms.

### Remote users (Puppet users)

The connector create remote users automatically when a users is posting a messaging in Federated channel/room or chat. We call the remote users for puppet users. They are real users in the platforms but can not be used as an ordinary users. You can not use a puppet user for interactive login in the user interface.

## Supported features in Federated messages

- Mattermost -> Matrix:

  - [x] Markdown -> HTML
  - [x] Join/leave
  - [x] Attachments
  - [x] Username Substitutions
  - [x] /me
  - [x] Edits
  - [x] Replies
  - [x] Deletes
  - [x] Redaction
  - [ ] Room substitutions (#9)
  - [ ] Presence (#8)
  - [ ] Avatars (#17)
  - [x] Reactions (#13)
  - [ ] Attachment thumbnails (#10)
  - [ ] Correctly indicate remover when removing from channel (#7)
  - [x] Typing notification

- Matrix -> Mattermost:
  - [x] HTML -> Markdown
  - [x] Join/leave
  - [x] Attachments
  - [x] Username Substitutions
  - [x] /me
  - [x] Edits
  - [x] Replies
  - [x] Deletes
  - [x] Redaction
  - [ ] Room substitutions (#9)
  - [x] PMs (#1)
  - [ ] Presence (#8)
  - [ ] Avatars (#17)
  - [x] Reactions (#13)
  - [ ] Correctly indicate remover when removing from channel (#7)
  - [ ] Customize username (#12)
  - [ ] Typing notification (#11)

# Detailed documentation

## Installation and deployment

[Details for installation](./documentation/DEPLOYMENT.md)

## Development and more

[More information about development](./documentation/DEVELOPMENT.md)

## Main Use cases

[More information about main use cases](./documentation/USE-CASES.md)
