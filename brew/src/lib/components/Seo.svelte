<script lang="ts">
	import { SITE } from '#lib/config.ts';

	let {
		title = SITE.title,
		description = SITE.description,
		path = '/',
		jsonLd = []
	}: { title?: string; description?: string; path?: string; jsonLd?: object[] } = $props();

	const url = $derived(`${SITE.url}${path === '/' ? '' : path}`);
	const image = `${SITE.url}/og.png`;
	const tags = $derived(
		jsonLd.map(
			(ld) =>
				'<script type="application/ld+json">' +
				JSON.stringify(ld).replace(/</g, '\\u003c') +
				'<' +
				'/script>'
		)
	);
</script>

<svelte:head>
	<title>{title}</title>
	<meta name="description" content={description} />
	<link rel="canonical" href={url} />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content={SITE.name} />
	<meta property="og:title" content={title} />
	<meta property="og:description" content={description} />
	<meta property="og:url" content={url} />
	<meta property="og:image" content={image} />
	<meta property="og:image:width" content="1200" />
	<meta property="og:image:height" content="630" />
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:title" content={title} />
	<meta name="twitter:description" content={description} />
	<meta name="twitter:image" content={image} />
	{#each tags as tag, i (i)}
		<!-- eslint-disable-next-line svelte/no-at-html-tags -- static, escaped JSON-LD -->
		{@html tag}
	{/each}
</svelte:head>
