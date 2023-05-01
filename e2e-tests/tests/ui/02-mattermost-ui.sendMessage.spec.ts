
import { expect } from '@playwright/test';
import { test} from "@e2e-support/fixtures/apiProfilesFixture";
import { faker } from "@faker-js/faker";
import {LoginPage} from "@e2e-support/ui/mm/pages/login"
import {LandingLoginPage} from "@e2e-support/ui/mm/pages/landing_login"
import {ChannelsPage} from "@e2e-support/ui/mm/pages/channels"

test('Mattermost send message', async ({ page,mattermost_user1 }) => {
  const theChannel="off-topic"
  const landingLoginPage= new LandingLoginPage(page,false)

  await page.goto(mattermost_user1.baseURL);
  await landingLoginPage.goto(30000)
  await landingLoginPage.toBeVisible()
  await landingLoginPage.toLogin()

  const loginPage= new LoginPage(page)
  await loginPage.toBeVisible()
 
  await loginPage.login(mattermost_user1,false)
  const firstTeam:any = loginPage.getFirstTeam()
  const message=faker.lorem.paragraph()
  const channelsPage=new ChannelsPage(page)
  await channelsPage.goto(firstTeam.name,theChannel)
  await channelsPage.toBeVisible()
 
  await channelsPage.postMessage(message)
  await channelsPage.postMessage('\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)')
  await loginPage.logout()
  await page.close()
  
});