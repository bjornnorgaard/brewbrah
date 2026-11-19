import { page } from 'vitest/browser';
import { describe, expect, it } from 'vitest';
import { render } from 'vitest-browser-svelte';
import SliderField from './SliderField.svelte';

describe('SliderField', () => {
	it('renders its label and value', async () => {
		render(SliderField, {
			id: 'x',
			label: 'Amount',
			unit: 'ml',
			value: 250,
			min: 0,
			max: 500,
			step: 10
		});
		await expect.element(page.getByLabelText('Amount')).toHaveValue(250);
	});

	it('steps up and down within bounds', async () => {
		render(SliderField, {
			id: 'x',
			label: 'Amount',
			unit: 'ml',
			value: 495,
			min: 0,
			max: 500,
			step: 10
		});
		await page.getByRole('button', { name: 'Increase Amount' }).click();
		await expect.element(page.getByLabelText('Amount')).toHaveValue(500);
	});
});
