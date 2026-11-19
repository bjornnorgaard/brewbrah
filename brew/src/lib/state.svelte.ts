import { LIMITS, calculate, clamp } from './brew';

const KEY = 'brew:v1';

function num(v: unknown, min: number, max: number, fallback: number): number {
	const n = typeof v === 'string' ? Number(v) : typeof v === 'number' ? v : Number.NaN;
	return Number.isFinite(n) ? clamp(n, min, max) : fallback;
}

export class BrewState {
	yieldMl = $state<number>(LIMITS.yieldMl.default);
	ratio = $state<number>(LIMITS.ratio.default);

	result = $derived(calculate({ yieldMl: this.yieldMl, ratio: this.ratio }));

	/** Restore from ?y/r query params (deep links) or localStorage. */
	hydrate(search: string) {
		let source: Record<string, unknown>;
		const q = new URLSearchParams(search);
		if (q.has('y') || q.has('r')) {
			source = { yieldMl: q.get('y'), ratio: q.get('r') };
		} else {
			try {
				source = JSON.parse(localStorage.getItem(KEY) ?? '{}');
			} catch {
				source = {};
			}
		}
		const L = LIMITS;
		this.yieldMl = num(source.yieldMl, L.yieldMl.min, L.yieldMl.max, L.yieldMl.default);
		this.ratio = num(source.ratio, L.ratio.min, L.ratio.max, L.ratio.default);
	}

	persist() {
		if (typeof localStorage === 'undefined') return;
		try {
			localStorage.setItem(
				KEY,
				JSON.stringify({
					yieldMl: this.yieldMl,
					ratio: this.ratio
				})
			);
		} catch {
			/* storage may be unavailable (private mode) */
		}
	}
}
