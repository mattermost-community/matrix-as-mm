# PlayWright Tests - Mattermost Matrix Connector

## Overview

The Playwright test are divided into API and UI scenarios. The type of tests are End-2-End integration tests.

## The playwright test project

The Playwright test project is located in the sub folder _e2e-tests_ under the main git project for the Matrix Connector. You need to be in the test project folder to run the tests.

### Directory structure

| Directory | Content                                 |
| --------- | --------------------------------------- |
| tests/api | API tests. Complete scenarios           |
| tests/ui  | User interface tests. Web browser tests |

### Configuration files Playwright

| file                    | Description                                                                                     |
| ----------------------- | ----------------------------------------------------------------------------------------------- |
| playwright.config.ts    | Configuration for running tests in local development environment                                |
| plywright.config.aws.ts | Configuration for running in an AWS environment. Must be configured for your shared environment |

### Test cases

| test spec file                       | dir | Description                                                           |
| ------------------------------------ | --- | --------------------------------------------------------------------- |
| 01-matrix-2-mm-mesg.spec.ts          | api | Send message from Matrix to Mattermost and reply in Mattermost        |
| 02-mm-2-matrix-userMapping.spec.ts   | api | Check required user in Matrix and Mattermost for the tests            |
| 01-element-post-message.spec.ts      | ui  | Post message in the _Town Square_ public room. Element user interface |
| 02-mattermost-ui.sendMessage.spec.ts | ui  | Post message in the _Off Topic_ public channel. Mattermost user       |

### The configuration file

This is content of the configuration file for your local environment. Must be configured for your environment with correct end-points and authentication properties

```typescript
import type { PlaywrightTestConfig } from '@playwright/test';

import * as userAuthProfile from '@e2e-support/models/userAuthProfile';

const config: PlaywrightTestConfig<userAuthProfile.UserAuthConfig> = {
  testDir: './tests',
  reporter: [['html'], ['github']],
  /* Maximum time one test can run for. */
  timeout: 120 * 1000,
  expect: {
    timeout: 15000,
  },
  /* Run tests in files in parallel */
  fullyParallel: false,
  /* Fail the build on CI if you accidentally left test.only in the source code. */
  forbidOnly: !!process.env.CI,
  /* Retry on CI only */
  retries: process.env.CI ? 2 : 0,
  /* Opt out of parallel tests on CI. */
  workers: process.env.CI ? 1 : 2,

  /* Shared settings for all the projects below. See https://playwright.dev/docs/api/class-testoptions. */
  use: {
    actionTimeout: 10 * 1000,
    navigationTimeout: 10 * 1000,
    matrix_connector: {
      user: '<none>',
      baseURL: 'http://localhost:9995',
      bearerToken:
        '4Z9Nbbv5SJHskTzytN2-hSMubMUCKgybSRrgtmrlkpB-QaUwm-PAdtgnAwlptwPT',
    },
    mattermost_admin: {
      user: 'admin',
      password: 'Admin..123456',
      baseURL: 'http://localhost:8065',
      domain: 'localhost',
      bearerToken: 's537n3t8zib1tx7eyd44qzqnbr',
    },
    matrix_bridge: {
      user: 'admin',
      password: 'Admin..123456',
      email: 'admin@localhost.com',
      baseURL: 'http://localhost:8065',
      domain: 'localhost',
      bearerToken: 'bxfcapjqiina9xayxw6y65ubwh',
    },
    mattermost_user1: {
      user: 'user1.mm',
      password: 'User..1234',
      email: 'user1.mm@localhost.com',
      baseURL: 'http://localhost:8065',
      domain: 'localhost',
    },
    mattermost_bridge: {
      user: 'matterbot',
      baseURL: 'http://localhost:8008',
      domain: 'localhost',
      bearerToken:
        'c6QW7JvyncGYcoqwPrsE7fU12cnvFkbkwmCQw_3tYQKCf0bnmzN3nZJHrTYmTUY2',
    },
    matrix_admin: {
      user: 'admin',
      baseURL: 'http://localhost:8008',
      domain: 'localhost',
      bearerToken: 'syt_YWRtaW4_ESjBoGLaWtscFgZHsBhJ_027WFj',
    },
    matrix_user1: {
      user: 'user1.matrix',
      password: 'User..1234',

      baseURL: 'http://localhost:8008',
      domain: 'localhost',
      additional: {
        elementURL: 'http://localhost:8080',
      },
    },

    baseURL: 'http://localhost',
    trace: 'on',
    video: 'on',
  },
};

export default config;
```

### Running all tests in the local environment

```shell
npx playwright test tests/api tests/ui

Running 4 tests using 2 workers

```
