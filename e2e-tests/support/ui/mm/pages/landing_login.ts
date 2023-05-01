// Copyright (c) 2015-present Mattermost, Inc. All Rights Reserved.
// See LICENSE.txt for license information.

import {expect, Page,Locator} from '@playwright/test';

export default class LandingLoginPage {
    readonly page: Page;

    readonly isMobile?: boolean;

    readonly viewInAppButton;
    readonly viewInDesktopAppButton;
    readonly viewInBrowserButton;
    private  waitButton:Locator

    constructor(page: Page, isMobile?: boolean) {
        this.page = page;
        this.isMobile = isMobile;

        this.viewInAppButton = page.locator('text=View in App');
        this.viewInDesktopAppButton = page.locator('text=View in Desktop App');
        this.viewInBrowserButton = page.locator('text=View in Browser');
        this.waitButton= this.isMobile ? this.viewInAppButton:this.viewInBrowserButton
    }

    async toBeVisible() {
        await this.page.waitForLoadState('networkidle');
        await expect(this.waitButton).toBeVisible();
    }

    async toLogin() {
        await this.waitButton.click()
        
    }

    async goto(timeout=10000) {
        await this.page.goto(`/landing#/login`,{ timeout: timeout });
    }
}

export {LandingLoginPage};
