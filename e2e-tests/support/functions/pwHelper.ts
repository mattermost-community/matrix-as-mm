import {
    expect,
    Locator,
    Page,
    TestInfo,
    ViewportSize,
} from '@playwright/test';
import { v4 as uuidv4 } from 'uuid';

//First options is not valid  for selection in TicketMonster
export async function selectRandomOption(
    select: Locator,
    firstNotValid: boolean = true,
) {
    await expect(select).toBeEditable();
    let options = select.locator('option');
    let count = await options.count();
    let offset = firstNotValid ? 1 : 0;
    expect(count).toBeGreaterThan(offset);

    let randIndex = Math.floor(Math.random() * (count - offset) + offset);
    await select.selectOption({ index: randIndex });
}

export async function randomChildClick(
    page: Page,
    selector: string,
): Promise<number> {
    let locator = page.locator(selector);
    //await locator.first().isVisible()
    let count = await locator.count();
    expect(count).toBeGreaterThanOrEqual(1);
    let randomIdx = Math.floor(Math.random() * count);
    await locator.nth(randomIdx).click();
    return randomIdx;
}
export async function takeScreenshot(
    locator: Locator,
    info: TestInfo,
    name: string = 'Screenshot',
) {
    let buff = await locator.screenshot();
    await info.attach(name, { body: buff, contentType: 'image/png' });
}

export async function takePageScreenshot(info: TestInfo, page: Page) {
    let screen = await page.screenshot();
    await info.attach('screenshot', { body: screen, contentType: 'image/png' });
}

export function infoAnnotation(info: TestInfo, description: string) {
    info.annotations.push({ type: 'info', description: description });
}

const second = 1000;
const minute = 60 * 1000;

export const duration = {
    half_sec: second / 2,
    one_sec: second,
    two_sec: second * 2,
    four_sec: second * 4,
    ten_sec: second * 10,
    half_min: minute / 2,
    one_min: minute,
    two_min: minute * 2,
    four_min: minute * 4,
};

/**
 * Explicit `wait` should not normally used but made available for special cases.
 * @param {number} ms - duration in millisecond
 * @return {Promise} promise with timeout
 */
export const wait = async (ms = 0) => {
    return new Promise(resolve => setTimeout(resolve, ms));
};

export function getRandomId(length = 7): string {
    const MAX_SUBSTRING_INDEX = 27;

    return uuidv4()
        .replace(/-/g, '')
        .substring(MAX_SUBSTRING_INDEX - length, MAX_SUBSTRING_INDEX);
}

// Default team is meant for sysadmin's primary team,
// selected for compatibility with existing local development.
// It should not be used for testing.
export const defaultTeam = { name: 'ad-1', displayName: 'eligendi', type: 'O' };

export const illegalRe = /[/?<>\\:*|":&();]/g;

export function isSmallScreen(
    viewport?: ViewportSize | { width: number; height: number } | null,
) {
    return viewport?.width ? Boolean(viewport?.width <= 390) : true;
}
