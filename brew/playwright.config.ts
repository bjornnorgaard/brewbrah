import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
	webServer: { command: 'npm run build && npm run preview -- --port 4173', port: 4173 },
	testDir: 'e2e',
	testMatch: '**/*.e2e.{ts,js}',
	fullyParallel: true,
	reporter: process.env.CI ? 'github' : 'list',
	use: { baseURL: 'http://localhost:4173', trace: 'on-first-retry' },
	// Mobile is first class: it is the primary project, desktop is secondary.
	projects: [
		{ name: 'mobile', use: { ...devices['Pixel 7'] } },
		{ name: 'iphone', use: { ...devices['iPhone 14'], browserName: 'chromium' } },
		{ name: 'desktop', use: { ...devices['Desktop Chrome'] } }
	]
});
