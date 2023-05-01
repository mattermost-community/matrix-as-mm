import type { PlaywrightTestConfig } from "@playwright/test";

import * as userAuthProfile from "@e2e-support/models/userAuthProfile";

/**
 * Read environment variables from file.
 * https://github.com/motdotla/dotenv
 */
// require('dotenv').config();

/**
 * See https://playwright.dev/docs/test-configuration.
 */
const config: PlaywrightTestConfig<userAuthProfile.UserAuthConfig> = {
  testDir: "./tests",
  reporter: [['html'], ['github']],
  //outputDir: '../test-results/',
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
      user: "<none>",
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com:9995",
      bearerToken: "4Z9Nbbv5SJHskTzytN2-hSMubMUCKgybSRrgtmrlkpB-QaUwm-PAdtgnAwlptwPT",
    },
    mattermost_admin: {
      user: "admin",
      password: "Admin..123456",
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com",
      domain: "localhost",
      bearerToken: "s537n3t8zib1tx7eyd44qzqnbr",
    },
    matrix_bridge: {
      user: "admin",
      password: "Admin..123456",
      email:"admin@localhost.com",
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com",
      domain: "localhost",
      bearerToken: "bxfcapjqiina9xayxw6y65ubwh",
    },
    mattermost_user1: {
      user: "user1.mm",
      password: "User..1234",
      email:"user1.mm@localhost.com",
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com",
      domain: "localhost"
    },
    mattermost_bridge: {
      user: "matterbot",
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com:8008",
      domain: "localhost",
      bearerToken:
        "c6QW7JvyncGYcoqwPrsE7fU12cnvFkbkwmCQw_3tYQKCf0bnmzN3nZJHrTYmTUY2",
    },
    matrix_admin: {
      user: "admin",
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com:8008",
      domain: "localhost",
      bearerToken:
        "syt_YWRtaW4_bihzjNVTSABtwCbmgAJD_3pqKAm",
    },
    matrix_user1: {
      user: "user1.matrix",
      password:"User..1234",
     
      baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com:8008",
      domain: "localhost",
      additional: {
        elementURL:"http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com:8080"
      }
    },
    
    baseURL: "http://ec2-54-216-207-175.eu-west-1.compute.amazonaws.com",
    trace: "on",
    video: "on",
    
  },
  

};

export default config;
