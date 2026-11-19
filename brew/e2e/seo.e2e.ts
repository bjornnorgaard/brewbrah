import { expect, test } from '@playwright/test';

test('home page has complete SEO metadata', async ({ page }) => {
	await page.goto('/');
	await expect(page).toHaveTitle(/brew/);
	await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', /.{60,}/);
	await expect(page.locator('link[rel="canonical"]')).toHaveAttribute(
		'href',
		'https://brew.bybear.dk'
	);
	await expect(page.locator('meta[property="og:image"]')).toHaveAttribute(
		'content',
		'https://brew.bybear.dk/og.png'
	);
	await expect(page.locator('meta[name="twitter:card"]')).toHaveAttribute(
		'content',
		'summary_large_image'
	);
	const ld = await page.locator('script[type="application/ld+json"]').first().textContent();
	expect(JSON.parse(ld!)['@type']).toBe('WebApplication');
	await expect(page.locator('h1')).toHaveCount(1);
});

test('robots, sitemap and manifest are served', async ({ request }) => {
	const robots = await request.get('/robots.txt');
	expect(await robots.text()).toContain('Sitemap: https://brew.bybear.dk/sitemap.xml');
	const sitemap = await request.get('/sitemap.xml');
	expect(sitemap.headers()['content-type']).toContain('xml');
	expect(await sitemap.text()).toContain('<loc>https://brew.bybear.dk</loc>');
	const manifest = await request.get('/manifest.webmanifest');
	expect((await manifest.json()).short_name).toBe('brew');
});
