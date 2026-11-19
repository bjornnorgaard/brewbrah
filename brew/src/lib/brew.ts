export interface BrewInput {
	/** Desired amount of finished coffee in ml/g. */
	yieldMl: number;
	/** Coffee-to-water ratio, expressed as 1:ratio. */
	ratio: number;
	/** Grams of water retained per gram of dry coffee. */
	absorption: number;
}

export interface BrewResult {
	/** Grams of ground coffee. */
	coffee: number;
	/** Grams of water to pour in total. */
	water: number;
}

export const LIMITS = {
	yieldMl: { min: 150, max: 1200, step: 10, default: 500 },
	ratio: { min: 3, max: 25, step: 0.5, default: 16 },
	absorption: { min: 0, max: 3, step: 0.1, default: 2 }
} as const;

export function round(value: number, decimals = 0): number {
	const factor = 10 ** decimals;
	return Math.round((value + Number.EPSILON) * factor) / factor;
}

export function clamp(value: number, min: number, max: number): number {
	if (!Number.isFinite(value)) return min;
	return Math.min(max, Math.max(min, value));
}

/**
 * coffee = yield / ratio
 * water  = yield + coffee * absorption (the grounds soak some up)
 */
export function calculate({ yieldMl, ratio, absorption }: BrewInput): BrewResult {
	const y = clamp(yieldMl, 0, Infinity);
	const r = clamp(ratio, 0.1, Infinity);
	const a = clamp(absorption, 0, Infinity);
	const coffee = y / r;
	return { coffee: round(coffee, 1), water: round(y + coffee * a, 0) };
}

export type VesselId = 'cup' | 'mug' | 'carafe' | 'pitcher';

export interface Vessel {
	id: VesselId;
	name: string;
	/** Inclusive lower and upper bound (ml) this vessel represents. */
	min: number;
	max: number;
}

export const VESSELS: readonly Vessel[] = [
	{ id: 'cup', name: 'Small cup', min: 0, max: 150 },
	{ id: 'mug', name: 'Mug', min: 150, max: 300 },
	{ id: 'carafe', name: 'Carafe', min: 300, max: 600 },
	{ id: 'pitcher', name: 'Thermo pitcher', min: 600, max: LIMITS.yieldMl.max }
] as const;

export function vesselFor(ml: number): Vessel {
	return VESSELS.find((v) => ml <= v.max) ?? VESSELS[VESSELS.length - 1];
}

/** 0..1 — how full the vessel is for this amount. */
export function fillWithin(ml: number, vessel: Vessel): number {
	return clamp((ml - vessel.min) / (vessel.max - vessel.min), 0, 1);
}
