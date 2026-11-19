// Renders PNG icons + the social card from inline SVG/HTML using Playwright.
import { chromium } from '@playwright/test';
import { readFileSync, mkdirSync } from 'node:fs';

const icon = readFileSync('static/favicon.svg', 'utf8');
mkdirSync('static/icons', { recursive: true });
const browser = await chromium.launch();

async function shot(html, w, h, out) {
	const page = await browser.newPage({ viewport: { width: w, height: h } });
	await page.setContent(`<body style="margin:0">${html}</body>`);
	await page.screenshot({ path: out });
	await page.close();
}
const svg = (size, pad = 0) =>
	`<div style="width:${size}px;height:${size}px;background:#e0a526;display:grid;place-items:center">
	<div style="width:${size - pad * 2}px;height:${size - pad * 2}px">${icon.replace('<svg ', '<svg width="100%" height="100%" ')}</div></div>`;

await shot(svg(192), 192, 192, 'static/icons/icon-192.png');
await shot(svg(512), 512, 512, 'static/icons/icon-512.png');
await shot(svg(512, 80), 512, 512, 'static/icons/icon-maskable-512.png');
await shot(svg(180), 180, 180, 'static/icons/apple-touch-icon.png');
await shot(
	`<div style="width:1200px;height:630px;background:linear-gradient(135deg,#fbf3dc,#f2c75c);font-family:system-ui,sans-serif;display:flex;align-items:center;gap:60px;padding:0 100px;box-sizing:border-box">
	<div style="width:240px;height:240px;border-radius:56px;overflow:hidden;box-shadow:0 20px 50px #0003">${icon.replace('<svg ', '<svg width="240" height="240" ')}</div>
	<div><div style="font-size:150px;font-weight:800;color:#3b2a10;letter-spacing:-4px">brew</div>
	<div style="font-size:42px;color:#5c4320;max-width:640px">The coffee ratio calculator. Grams of coffee and water, instantly.</div></div></div>`,
	1200,
	630,
	'static/og.png'
);
await browser.close();
