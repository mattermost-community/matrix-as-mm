// Copyright (c) 2015-present Mattermost, Inc. All Rights Reserved.
// See LICENSE.txt for license information.

import { expect, Page } from '@playwright/test';

import { duration, wait } from '@e2e-support/functions/pwHelper';

export default class SignupPage {
    readonly page: Page;

    readonly title;
    readonly subtitle;
    readonly bodyCard;
    readonly emailInput;
    readonly usernameInput;
    readonly passwordInput;
    readonly createAccountButton;
    readonly loginLink;
    readonly emailError;
    readonly usernameError;
    readonly passwordError;

    constructor(page: Page) {
        this.page = page;

        this.title = page.locator('h1:has-text("Let’s get started")');
        this.subtitle = page.locator(
            'text=Create your Mattermost account to start collaborating with your team',
        );
        this.bodyCard = page.locator('.signup-body-card');
        this.emailInput = page.locator('#input_email');
        this.usernameInput = page.locator('#input_name');
        this.passwordInput = page.locator('#input_password-input');
        this.createAccountButton = page.locator(
            'button:has-text("Create Account")',
        );
        this.loginLink = page.locator('text=Click here to sign in.');
        this.emailError = page.locator(
            'text=Please enter a valid email address',
        );
        this.usernameError = page.locator(
            'text=Usernames have to begin with a lowercase letter and be 3-22 characters long. You can use lowercase letters, numbers, periods, dashes, and underscores.',
        );
        this.passwordError = page.locator('text=Must be 5-64 characters long.');
    }

    async toBeVisible() {
        await this.page.waitForLoadState('networkidle');
        await this.page.waitForLoadState('domcontentloaded');
        await wait(duration.half_sec);
        await expect(this.title).toBeVisible();
        await expect(this.emailInput).toBeVisible();
        await expect(this.usernameInput).toBeVisible();
        await expect(this.passwordInput).toBeVisible();
    }

    async goto() {
        await this.page.goto('/signup_email');
    }

    async create(
        user: { email: string; username: string; password: string },
        waitForRedirect = true,
    ) {
        await this.emailInput.fill(user.email);
        await this.usernameInput.fill(user.username);
        await this.passwordInput.fill(user.password);
        await this.createAccountButton.click();

        if (waitForRedirect) {
            await this.page.waitForNavigation();
        }
    }
}

export { SignupPage };
