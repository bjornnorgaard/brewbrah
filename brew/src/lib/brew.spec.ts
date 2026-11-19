import { describe, expect, it } from 'vitest';
import { calculate, clamp, fillWithin, round, vesselFor } from './brew';

describe('round', () => {
	it('rounds to the requested decimals', () => {
		expect(round(1.005, 2)).toBe(1.01);
		expect(round(2.449, 1)).toBe(2.4);
		expect(round(2.5)).toBe(3);
	});
});

describe('clamp', () => {
	it('keeps values within bounds and survives NaN', () => {
		expect(clamp(5, 1, 3)).toBe(3);
		expect(clamp(-1, 1, 3)).toBe(1);
		expect(clamp(Number.NaN, 1, 3)).toBe(1);
	});
});

describe('calculate', () => {
	it('computes coffee from yield and ratio', () => {
		expect(calculate({ yieldMl: 1000, ratio: 16, absorption: 0 })).toEqual({
			coffee: 62.5,
			water: 1000
		});
	});

	it('adds absorbed water on top of the desired yield', () => {
		const { coffee, water } = calculate({ yieldMl: 1000, ratio: 17, absorption: 2 });
		expect(coffee).toBe(58.8);
		expect(water).toBe(1118);
	});

	it('never divides by zero or goes negative', () => {
		const r = calculate({ yieldMl: 500, ratio: 0, absorption: -1 });
		expect(Number.isFinite(r.coffee)).toBe(true);
		expect(r.water).toBeGreaterThanOrEqual(0);
	});
});

describe('vessels', () => {
	it('picks the vessel by amount', () => {
		expect(vesselFor(100).id).toBe('cup');
		expect(vesselFor(150).id).toBe('cup');
		expect(vesselFor(151).id).toBe('mug');
		expect(vesselFor(300).id).toBe('mug');
		expect(vesselFor(500).id).toBe('carafe');
		expect(vesselFor(600).id).toBe('carafe');
		expect(vesselFor(601).id).toBe('pitcher');
		expect(vesselFor(5000).id).toBe('pitcher');
	});
	it('computes fill within a vessel', () => {
		expect(fillWithin(450, vesselFor(450))).toBeCloseTo(0.5);
		expect(fillWithin(150, vesselFor(150))).toBe(1);
	});
});
