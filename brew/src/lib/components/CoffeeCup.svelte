<script lang="ts">
	import { Tween } from 'svelte/motion';
	import { cubicOut } from 'svelte/easing';
	import { fade, fly } from 'svelte/transition';
	import { LIMITS, fillWithin, vesselFor, type VesselId } from '#lib/brew.ts';

	let { ml, ratio }: { ml: number; ratio: number } = $props();

	interface Shape {
		/** Interior outline: clips the liquid and is stroked as the vessel wall. */
		body: string;
		/** Liquid surface range (y). */
		top: number;
		bottom: number;
		/** How full (0..1) the vessel looks at the top of its range. */
		maxLevel: number;
		/** y of the bottom edge of the body path (stroke centre). */
		base: number;
		/** Extra strokes (handles, lids...). */
		handle?: string;
		/** How far the steam sits above/below its default position. */
		steamDy: number;
	}

	// Table line is at y=98. All shapes are drawn in a 120-wide box.
	const SHAPES: Record<VesselId, Shape> = {
		cup: {
			maxLevel: 0.78,
			base: 92,
			body: 'M32 52h56l-7 34a8 8 0 0 1-8 6H47a8 8 0 0 1-8-6z',
			top: 52,
			bottom: 92,
			handle: 'M87 58h3a8 8 0 0 1 0 16h-8',
			steamDy: 20
		},
		mug: {
			maxLevel: 0.78,
			base: 92,
			body: 'M20 34h68v34a24 24 0 0 1-24 24H44a24 24 0 0 1-24-24z',
			top: 34,
			bottom: 92,
			handle: 'M88 42h6a12 12 0 0 1 0 24h-8',
			steamDy: 0
		},
		carafe: {
			maxLevel: 0.95,
			base: 100,
			body: 'M47 20h26v16c0 6 17 8 17 20v34a10 10 0 0 1-10 10H40a10 10 0 0 1-10-10V56c0-12 17-14 17-20z',
			top: 30,
			bottom: 94,
			handle: 'M90 52h4a9 9 0 0 1 0 22h-4',
			steamDy: -12
		},
		pitcher: {
			maxLevel: 0.95,
			base: 98,
			body: 'M34 36h52v54a8 8 0 0 1-8 8H42a8 8 0 0 1-8-8z',
			top: 42,
			bottom: 92,
			handle: 'M86 46h6a10 10 0 0 1 10 10v18a10 10 0 0 1-10 10h-6',
			steamDy: -10
		}
	};

	const vessel = $derived(vesselFor(ml));
	const shape = $derived(SHAPES[vessel.id]);
	// Every vessel floats the same distance above the table line (top edge y=98):
	// outer bottom edge = stroke centre + 2 = 98 - GAP.
	const GAP = 5;
	const lift = $derived(96 - GAP - shape.base);

	const level = Tween.of(() => 0.5 + fillWithin(ml, vessel) * (shape.maxLevel - 0.5), {
		duration: 600,
		easing: cubicOut
	});
	const y = $derived(shape.bottom - (shape.bottom - shape.top) * level.current);

	// Lower ratio = stronger coffee = darker. the lowest ratio is darkest, the highest is pale tea-like.
	const weakness = Tween.of(
		() =>
			Math.min(1, Math.max(0, (ratio - LIMITS.ratio.min) / (LIMITS.ratio.max - LIMITS.ratio.min))),
		{
			duration: 600,
			easing: cubicOut
		}
	);
	const liquid = $derived(
		`oklch(${(0.3 + 0.42 * weakness.current).toFixed(3)} ${(0.05 + 0.08 * weakness.current).toFixed(3)} ${(50 + 28 * weakness.current).toFixed(1)})`
	);
	const crema = $derived(
		`oklch(${(0.45 + 0.35 * weakness.current).toFixed(3)} ${(0.07 + 0.06 * weakness.current).toFixed(3)} ${(55 + 25 * weakness.current).toFixed(1)})`
	);
</script>

<svg
	viewBox="0 -28 120 138"
	class="h-auto w-full overflow-visible"
	role="img"
	aria-label="{vessel.name} of coffee, {ml} millilitres"
	data-vessel={vessel.id}
>
	<g
		class="fill-none stroke-primary-500"
		stroke-width="3"
		stroke-linecap="round"
		style="transform: translateY({shape.steamDy +
			lift}px); transition: transform 0.5s cubic-bezier(0.2, 0.8, 0.2, 1)"
	>
		<path class="steam" d="M42 24c-6-8 6-12 0-22" />
		<path class="steam" d="M56 24c-6-8 6-12 0-22" />
		<path class="steam" d="M70 24c-6-8 6-12 0-22" />
	</g>

	{#key vessel.id}
		<g in:fly={{ y: 10, duration: 350, easing: cubicOut }} out:fade={{ duration: 120 }}>
			<g transform="translate(0 {lift})">
				<defs>
					<clipPath id="inside-{vessel.id}">
						<path d={shape.body} />
					</clipPath>
				</defs>
				{#if vessel.id === 'pitcher'}
					<path d={shape.body} class="fill-surface-200-800" />
				{/if}
				<g clip-path="url(#inside-{vessel.id})">
					<rect x="0" {y} width="120" height="100" style="fill: {liquid}" />
					<path
						d="M10 {y}q9-5 18 0t18 0t18 0t18 0t18 0t18 0v6H10z"
						style="fill: {crema}; transform: translateY(-2px)"
						opacity="0.8"
					/>
				</g>
				<path
					d={shape.body}
					class="fill-none stroke-surface-700-300"
					stroke-width="4"
					stroke-linejoin="round"
				/>
				{#if shape.handle}
					<path
						d={shape.handle}
						class="fill-none stroke-surface-700-300"
						stroke-width="4"
						stroke-linecap="round"
					/>
				{/if}
				{#if vessel.id === 'pitcher'}
					<!-- lid with knob -->
					<path d="M32 36q0-10 28-10t28 10z" class="fill-surface-700-300" />
					<circle cx="60" cy="22" r="4" class="fill-surface-700-300" />
				{/if}
			</g>
		</g>
	{/key}

	<path d="M12 98h96" class="stroke-surface-400-600" stroke-width="4" stroke-linecap="round" />
</svg>
