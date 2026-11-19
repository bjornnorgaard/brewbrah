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
healthcheck on `/readyz` (liveness: `/healthz`). Set `ORIGIN` to the public URL when deploying (`https://brew.bybear.dk` is the image default).

## Deploy

There is no CI for brew. Deploys are manual: ask Claude to run the `deploy-brew` skill
(`.claude/skills/deploy-brew/SKILL.md`) — verify, build a `linux/amd64` image, push it to
`ghcr.io/bjornnorgaard/brewbrah/brew`, pin the tag in `deploy/mimir/services.prod.yaml` and push `main`.

## Notes

- Share links: `/?y=<ml>&r=<ratio>`; last brew is kept in `localStorage`.
- SEO: per-page title/description/canonical/OpenGraph/Twitter, JSON-LD (WebApplication), `sitemap.xml`, `robots.txt`, web manifest. The page is prerendered.
- Imports use Kit 3's `#lib/...` alias (with the file extension).
