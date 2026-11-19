# brew

Coffee ratio calculator — [brew.bybear.dk](https://brew.bybear.dk). SvelteKit 3 · Svelte 5 · Skeleton UI (Sahara theme) · Tailwind 4. Mobile first.

```bash
npm install
npm run dev            # dev server on :5173
npm run check          # svelte-check
npm run lint
npm run test:unit -- --run   # vitest (logic + component tests in a real browser)
npm run test:e2e       # playwright: mobile, iPhone, desktop · SEO · axe a11y
npm run assets         # regenerate PNG icons + og.png from static/favicon.svg
```

## Docker

```bash
docker compose up --build   # http://localhost:3080
```

Node 22 alpine, ~20 MiB RSS idle, heap capped at 64 MiB (`NODE_OPTIONS`), non-root, read-only filesystem,
healthcheck on `/healthz`. Set `ORIGIN` to the public URL when deploying (`https://brew.bybear.dk` is the image default).

## Notes

- Share links: `/?y=<ml>&r=<ratio>&a=<absorption>`; last brew is kept in `localStorage`.
- SEO: per-page title/description/canonical/OpenGraph/Twitter, JSON-LD (WebApplication, FAQPage), `sitemap.xml`, `robots.txt`, web manifest. All pages are prerendered.
- Imports use Kit 3's `#lib/...` alias (with the file extension).
