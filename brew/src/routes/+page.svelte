<script lang="ts">
	import { onMount } from 'svelte';
	import { fly } from 'svelte/transition';
	import Seo from '#lib/components/Seo.svelte';
	import AnimatedNumber from '#lib/components/AnimatedNumber.svelte';
	import CoffeeCup from '#lib/components/CoffeeCup.svelte';
	import SliderField from '#lib/components/SliderField.svelte';
	import { BrewState } from '#lib/state.svelte.ts';
	import { LIMITS } from '#lib/brew.ts';
	import { SITE } from '#lib/config.ts';

	// Amounts line up with where the vessel changes shape.
	const AMOUNT_MARKS = [
		{ value: 150, label: '150' },
		{ value: 300, label: '300' },
		{ value: 600, label: '600' },
		{ value: 1000, label: '1000' },
		{ value: 1200, label: '1200' }
	];
	const RATIO_MARKS = [4, 8, 12, 16, 20, 24].map((value) => ({ value, label: String(value) }));

	const brew = new BrewState();
	let ready = $state(false);

	onMount(() => {
		brew.hydrate(location.search);
		ready = true;
	});

	$effect(() => {
		// track every field, then persist
		void [brew.yieldMl, brew.ratio];
		if (ready) brew.persist();
	});

	const jsonLd = [
		{
			'@context': 'https://schema.org',
			'@type': 'WebApplication',
			name: 'brew',
			url: SITE.url,
			description: SITE.description,
			applicationCategory: 'LifestyleApplication',
			operatingSystem: 'Any',
			offers: { '@type': 'Offer', price: '0', priceCurrency: 'USD' }
		}
	];
</script>

<Seo path="/" {jsonLd} />

<div hidden data-ready={ready}></div>
<h1 class="sr-only">Coffee to water ratio calculator</h1>

<section class="grid items-center gap-2 md:grid-cols-2 md:gap-8" in:fly={{ y: 16, duration: 450 }}>
	<div class="mx-auto w-44 md:w-64">
		<CoffeeCup ml={brew.yieldMl} ratio={brew.ratio} />
	</div>

	<div class="grid grid-cols-2 gap-3" aria-live="polite">
		<div class="card preset-filled-primary-500 p-4 text-center shadow-lg">
			<p class="text-xs font-semibold tracking-wider uppercase">Coffee</p>
			<p class="text-4xl font-bold sm:text-5xl" data-testid="coffee">
				<AnimatedNumber value={brew.result.coffee} decimals={1} /><span class="text-xl">g</span>
			</p>
		</div>
		<div class="card preset-filled-surface-200-800 p-4 text-center">
			<p class="text-xs font-semibold tracking-wider uppercase">Water</p>
			<p class="text-4xl font-bold sm:text-5xl" data-testid="water">
				<AnimatedNumber value={brew.result.water} /><span class="text-xl">g</span>
			</p>
		</div>
		<p class="col-span-2 text-center text-sm text-surface-700-300">
			Ratio <strong>1:{brew.ratio}</strong>
		</p>
	</div>
</section>

<section
	class="mt-4 space-y-8 md:card md:preset-outlined-surface-200-800 md:p-5"
	aria-label="Settings"
>
	<SliderField
		id="amount"
		label="How much coffee?"
		unit="ml"
		bind:value={brew.yieldMl}
		marks={AMOUNT_MARKS}
		min={LIMITS.yieldMl.min}
		max={LIMITS.yieldMl.max}
		step={LIMITS.yieldMl.step}
	/>
	<SliderField
		id="ratio"
		label="Brew ratio"
		prefix="1:"
		unit=""
		bind:value={brew.ratio}
		marks={RATIO_MARKS}
		min={LIMITS.ratio.min}
		max={LIMITS.ratio.max}
		step={LIMITS.ratio.step}
	/>
</section>
