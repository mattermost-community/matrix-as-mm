import { expect } from '@playwright/test';
import { test} from "@e2e-support/fixtures/apiProfilesFixture";

test('Element - Post message', async ({ page,matrix_user1 }) => {
  test.setTimeout(60*1000)
  await page.route("**/_matrix/client/r0/login", async (route) => {
    let req = route.request();
    
    let url = req.url();
    let method = req.method();
    if (method === "POST" && url.includes("/_matrix/client/r0/login")) {
      let f=await route.fetch()
      let postData =await f.json()
      //let postData = req.postDataJSON();

      if (postData?.well_known?.['m.homeserver']?.base_url) {
        postData.well_known = {
          "m.homeserver": {
            base_url: matrix_user1.baseURL,
          },
        };
        await route.fulfill({json:postData})
        return
      }
      
    }
    return route.continue();
  });
  test.setTimeout(120000);
  let elementURL=matrix_user1?.additional?.elementURL 
  expect(elementURL,"ElementURL must be in additional").toBeDefined()
  await page.goto(`${elementURL}/#/welcome`,
  {waitUntil:"networkidle"});
  let riskyBrowser = page.locator(
    "#matrixchat > div > div > div:nth-child(2) > div > div > button"
  );
  let visible = await riskyBrowser.isVisible();
  if (visible) {
    await riskyBrowser.click();
  }

  await page.getByRole('link', { name: 'Sign In' }).click();
  await page.getByRole('button', { name: 'Edit' }).click();
  await page.getByPlaceholder('Other homeserver').fill(matrix_user1.baseURL);
  await page.getByRole('button', { name: 'Continue' }).click();
  await page.getByPlaceholder('username').fill(matrix_user1.user);
  await page.getByPlaceholder('username').press('Tab');
  await page.getByPlaceholder('Password').fill(matrix_user1.password || '');
  //await page.getByPlaceholder('Password').press('Enter');
  const [response] = await Promise.all([
    page.waitForResponse(
      (response) =>
        response.url().includes("/_matrix/client/r0/login") && response.ok()
    ),
    page.getByPlaceholder("Password").press("Enter"),
  ]);
  let json = await response.json();

 // await page.getByRole('button', { name: 'Sign in' }).click();
  await page.getByRole('button', { name: 'Skip verification for now' }).click();
  await page.getByRole('button', { name: 'I\'ll verify later' }).click();
  await page.getByRole('button', { name: 'Dismiss' }).click();
  await page.getByRole('treeitem', { name: 'Home' }).getByRole('button', { name: 'Home' }).click();
  await page.getByText('Town Square').click();
  //await page.getByText('Sports').click();
  let input=page.locator('div.mx_BasicMessageComposer_input.mx_BasicMessageComposer_input_shouldShowPillAvatar')
  await input.click()
  await input.type(`Playwright Test - Message from Element \nURL=${elementURL} risky Browser=${visible} \nTimestamp=`+Date.now().toString())
  await input.press('Enter')
  await page.getByRole('button', { name: 'User menu' }).click();
  await page.getByText('Sign out').click();
  await page.close()
});