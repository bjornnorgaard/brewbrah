<script lang="ts">
	import { fly } from 'svelte/transition';
	import Seo from '#lib/components/Seo.svelte';
	const GUIDE = [
		{ name: 'Pour over', hint: 'V60, Kalita, Chemex', ratio: 16 },
		{ name: 'AeroPress', hint: 'Short and punchy', ratio: 16 },
		{ name: 'French press', hint: 'Full immersion', ratio: 15 },
		{ name: 'Moka pot', hint: 'Stovetop', ratio: 10 }
	];

	const faqs = [
		{
			q: 'What is a good coffee to water ratio?',
			a: 'A good starting point for filter coffee is 1:16 — one gram of coffee for every sixteen grams of water. Go lower (1:15) for a stronger cup, higher (1:17) for a lighter one.'
		},
		{
			q: 'Is it grams or millilitres?',
			a: 'For water, one millilitre weighs one gram, so you can use either. Weighing on a scale is more accurate and less messy.'
		}
	];

	const jsonLd = [
		{
			'@context': 'https://schema.org',
			'@type': 'FAQPage',
			mainEntity: faqs.map((f) => ({
				'@type': 'Question',
				name: f.q,
				acceptedAnswer: { '@type': 'Answer', text: f.a }
			}))
		}
	];
</script>

<Seo
	path="/about"
	title="Coffee ratio guide — brew"
	description="How to pick a coffee to water ratio for pour over, French press, AeroPress and moka pot."
	{jsonLd}
/>

<article class="space-y-8 pt-4" in:fly={{ y: 16, duration: 400 }}>
	<header class="space-y-2">
		<h1 class="h2">Coffee ratio guide</h1>
		<p class="text-surface-700-300">
			A ratio of 1:16 means 1 g of coffee for every 16 g of water. Pick a starting point, taste, and
			adjust.
		</p>
	</header>

	<section aria-labelledby="ratios">
		<h2 id="ratios" class="mb-3 h4">Starting ratios</h2>
		<ul class="space-y-2">
			{#each GUIDE as m, i (m.name)}
				<li
					class="flex items-center justify-between card preset-outlined-surface-200-800 p-4"
					in:fly={{ y: 12, delay: 60 * i, duration: 350 }}
				>
					<div>
						<p class="font-semibold">{m.name}</p>
						<p class="text-sm text-surface-600-400">{m.hint}</p>
					</div>
					<a class="chip h-9 preset-filled-surface-200-800 px-3 font-mono" href="/?r={m.ratio}">
						1:{m.ratio}
					</a>
				</li>
			{/each}
		</ul>
	</section>

	<section aria-labelledby="faq" class="space-y-3">
		<h2 id="faq" class="h4">FAQ</h2>
		{#each faqs as f (f.q)}
			<details class="group card preset-tonal p-4">
				<summary class="cursor-pointer list-none font-medium">{f.q}</summary>
				<p class="pt-2 text-sm text-surface-700-300">{f.a}</p>
			</details>
		{/each}
	</section>
</article>
