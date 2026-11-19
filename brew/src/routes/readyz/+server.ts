export const prerender = false;

// Readiness: the app has no dependencies (no DB, no upstream calls), so ready == process up.
export function GET() {
	return new Response('ok', { headers: { 'Cache-Control': 'no-store' } });
}
