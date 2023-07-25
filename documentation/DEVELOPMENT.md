# Testing

This repository has both unit and integration tests, using [tape](https://github.com/substack/tape) for both of them. It also uses [Prettier](https://prettier.io) to enforce code style and [ESLint](https://eslint.org) for linting.

## Linting

Running

```
$ npm run lint
```

checks the code with `prettier` and `eslint`. We do not permit any ESLint warnings.

To fix errors, we can use Prettier to autoformat the code via

```
$ npm run fmt.
```

One can also run ESLint's autofix with

```
$ npm run fix
```

which will correct some but not all of the eslint warnings.

## Unit tests

Unit tests are placed next to the source files, e.g. the unit tests for `src/utils/Functions.ts` are at `src/utils/Functions.test.ts`. These are run by the subcommand

```
$ npm run test
```

While attempts have been made to make the code more modular, hence more unit-testable, most of the code is not really amenable to unit testing. Instead, most of it is covered under integration tests.

## Integration tests

Integration test are implemented with Microsoft Playwright Test.
See https://playwright.dev/

Detailed information about the integration tests can be found in the link: [More information about playwright integration tests](../e2e-tests/README.md)

# Docker containers

The rest of this section documents the docker containers used development environment.

## Postgres

This is a standard postgres image pulled from DockerHub. It has two database, one for mattermost and one for synapse, with the mattermost one being the "default" one.
There is also an additional database used by the bridge for storing some meta-data. Does not need to be postgres in a target environment. Sqlite is supported https://www.sqlite.org/index.html.

The tables are pre-populated with values extracted from live instances in our development environment. This makes it faster to start up and more convenient to write tests with known ids. The dumps are piped through awk to remove redundant lines. The awk script is placed at `docker/postgres/minify-dump.awk`.

### Backup of Postgres databases

Scripts are located under the _scripts_ directory in the _docker_ directory.

- Run script ./scripts/do-dump.sh
- Database dumps are located in the _backup_ directory.

```shell
janostgren@MBPsomtllhorJan docker % ./scripts/do-dump.sh
Dumping databases to ./backup.
total 7176
-rw-r--r--  1 janostgren  staff  1588747 20 Jun 17:34 mattermost.sql
-rw-r--r--  1 janostgren  staff    44567 20 Jun 17:34 mm-matrix-bridge.sql
-rw-r--r--  1 janostgren  staff  2036095 20 Jun 17:34 synapse.sql
janostgren@MBPsomtllhorJan docker %

```

## Matrix

This installs synapse from the alpine repositories. It uses `nc` to wait until `postgres` is up before starting synapse, since synapse crashes if the database is inaccessible.
Synapse is the only container which access the bridge through http. It should use the special host called host.docker.internal. See https://docs.docker.com/desktop/networking/

### Application Service registration file

The registration file **registration.yaml** is required for setting up the application service used be the connector.

Example of the registration file in docker. It is generated from the information in configuration file **config.yaml**.

```yaml
id: xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt
hs_token: 4Z9Nbbv5SJHskTzytN2-hSMubMUCKgybSRrgtmrlkpB-QaUwm-PAdtgnAwlptwPT
as_token: c6QW7JvyncGYcoqwPrsE7fU12cnvFkbkwmCQw_3tYQKCf0bnmzN3nZJHrTYmTUY2
namespaces:
  users:
    - exclusive: true
      regex: '@mm_.*:localhost'
url: http://host.docker.internal:9995
sender_localpart: matterbot
rate_limited: true
protocols:
  - mattermost
```

### Predefined users

| user         | authentication | usage                                                                                           |
| ------------ | -------------- | ----------------------------------------------------------------------------------------------- |
| admin        | Admin..123456  | Default admin user. Used by the connector. Defined in config file. Do not login with this user. |
| user_admin   | Admin..123456  | Admin user used in synapse admin.                                                               |
| matterbot    | Access Token   | The application service users.                                                                  |
| user1.matrix | User..1234     | A normal user which can be used for testing                                                     |
| mm_user1.mm  | N/A            | Puppet user for user1.mm in Mattermost                                                          |

## Mattermost

This performs a standard Mattermost 7.9.1 install on alpine.

This again uses `nc` to wait until `postgres` is up. While Mattermost has built in support for retrying connecting to the database, it waits for 10 seconds between retries, which is generally too much.

### Predefined users

| user                | authentication                 | usage                                                                                                                                    |
| ------------------- | ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| admin               | Admin..123456                  | Default admin user. Not used by the connector.                                                                                           |
| matrix.bridge       | Admin..123456 and Access Token | The system user used by the connector. Defined in config file. You must define the personal acess token to this user in **config.yaml**. |
| user1.mm            | User..1234                     | A normal user which can be used for testing                                                                                              |
| matrix_user1.matrix |                                | Puppet user from matrix for user1.matrix                                                                                                 |

## Element

The container for Element web UI. This container talks to Synapse Matrix Server on the home server port.
Configuration file _element-config.json_ changes.

```json
 "default_server_config": {
    "m.homeserver": {
      "base_url": "http://synapse:8008",
      "server_name": "synapse"
    },
    "m.identity_server": {
      "base_url": "http://localhost:8008"
    }
  }
```

## Mailhog

A simple SNMP server for testing of email. An installation of the MailHog docker container. See https://github.com/mailhog/MailHog
for additional information.

## Synapse Admin

A user interface for administration of a Synapse Matrix Server
See here for details https://github.com/Awesome-Technologies/synapse-admin
