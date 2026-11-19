import { expect, test, type Page } from '@playwright/test';

const ready = (page: Page) => page.locator('[data-ready="true"]').waitFor({ state: 'attached' });

test.describe('calculator', () => {
	test('shows default result and updates when ratio changes', async ({ page }) => {
		await page.goto('/');
		await ready(page);
		await expect(page.getByTestId('coffee')).toContainText('31.3');
		await expect(page.getByTestId('water')).toContainText('500');

		await page.getByRole('button', { name: 'Set Brew ratio to 15' }).click();
		await expect(page.getByTestId('coffee')).toContainText('33.3');
	});

	test('typing an amount recalculates', async ({ page }) => {
		await page.goto('/');
		await ready(page);
		await page.getByRole('spinbutton', { name: 'How much coffee?' }).fill('1000');
		await expect(page.getByTestId('coffee')).toContainText('62.5');
		await expect(page.getByTestId('water')).toContainText('1000');
	});

	test('stepper buttons adjust the amount', async ({ page }) => {
		await page.goto('/');
		await ready(page);
		await page.getByRole('button', { name: 'Increase How much coffee?' }).click();
		await expect(page.getByRole('spinbutton', { name: 'How much coffee?' })).toHaveValue('510');
	});

	test('tapping a slider marker jumps to that value', async ({ page }) => {
		await page.goto('/');
		await ready(page);
		await page.getByRole('button', { name: 'Set How much coffee? to 1000' }).click();
		await expect(page.getByRole('spinbutton', { name: 'How much coffee?' })).toHaveValue('1000');
		await page.getByRole('button', { name: 'Set Brew ratio to 10' }).click();
		await expect(page.getByRole('spinbutton', { name: 'Brew ratio' })).toHaveValue('10');
		await expect(page.getByTestId('coffee')).toContainText('100.0');
	});

	test('restores values from a share link', async ({ page }) => {
		await page.goto('/?y=1000&r=15');
		await ready(page);
		await expect(page.getByTestId('coffee')).toContainText('66.7');
	});

	test('remembers the last brew across reloads', async ({ page }) => {
		await page.goto('/');
		await ready(page);
		await page.getByRole('button', { name: 'Set Brew ratio to 10' }).click();
		await page.reload();
		await ready(page);
		await expect(page.getByRole('spinbutton', { name: 'Brew ratio' })).toHaveValue('10');
	});

	test('navigates to the guide', async ({ page }) => {
		await page.goto('/');
		await ready(page);
		await page.getByRole('link', { name: 'Guide' }).first().click();
		await expect(page).toHaveURL(/\/about$/);
		await expect(page.getByRole('heading', { level: 1, name: 'Coffee ratio guide' })).toBeVisible();
	});
});
