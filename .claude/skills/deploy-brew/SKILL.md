---
name: deploy-brew
description: Manually deploy the brew app (brew.bybear.dk) — verify, build the linux/amd64 image locally, push it to GHCR, pin the prod tag and push main. There is deliberately no GitHub CI for brew. Use when asked to deploy, release, ship or push the brew image.
---

# Deploy brew (manual)

brew has **no CI**. A deploy = a tested image in GHCR + the tag pinned in `brew/deploy/mimir/services.prod.yaml`
on `main` (the cluster picks the pin up from there). Run everything from the **repo root**.

Pushing an image and pushing `main` are outward-facing: only run this when the user asked to deploy. Never force-push.
Never type registry credentials yourself: if a push is unauthorized, ask the user to run `docker login ghcr.io`.

## 1. Preconditions
```bash
git checkout main && git pull --rebase origin main
git status --short        # only .claude/launch.json may be untracked; commit everything else FIRST
```
The image tag contains the commit SHA, so the code being deployed must already be committed (no `-dirty` tags).

## 2. Verify
```bash
cd brew && npm run lint && npm run check && npx vitest run && npm run test:e2e && cd ..
```
Stop and report if anything fails.

## 3. Build (amd64!)
The cluster is linux/amd64 but Apple-silicon Macs build arm64 by default, so **always** pass `--platform`.
```bash
IMAGE=ghcr.io/bjornnorgaard/brewbrah/brew
TAG=$(bash .github/scripts/image-tag.sh "$(git rev-parse HEAD)")   # e.g. 26.11.19-09.26-4b1c21c
docker buildx build --platform linux/amd64 -t "$IMAGE:$TAG" --load brew
docker image inspect --format '{{.Os}}/{{.Architecture}}' "$IMAGE:$TAG"   # must print linux/amd64
```
Optional smoke test:
`docker run --rm -d --name brew-smoke -p 3081:3000 -e ORIGIN=http://localhost:3081 "$IMAGE:$TAG"`, check
`curl -s -o /dev/null -w '%{http_code}' localhost:3081/readyz` is `200`, then `docker stop brew-smoke`.

## 4. Push the image
```bash
docker push "$IMAGE:$TAG"
docker manifest inspect "$IMAGE:$TAG" >/dev/null && echo "image is in GHCR"
```

## 5. Pin prod and push main
```bash
bash .github/scripts/pin-image-tag.sh brew/deploy/mimir/services.prod.yaml brew "$TAG"
git add brew/deploy/mimir/services.prod.yaml
git commit -m "chore: pin prod brew to $TAG"
git push origin main            # also publishes any code commits made earlier
```
Pin only **after** the image push succeeded, so prod never points at a missing image.

## 6. Verify
- `git log --oneline -3` shows the pin commit on `origin/main`.
- Once the cluster has rolled out: `curl -s -o /dev/null -w '%{http_code}\n' https://brew.bybear.dk/readyz` → `200`.

## Rollback
Re-pin an older tag that still exists in GHCR (`bash .github/scripts/pin-image-tag.sh --print brew/deploy/mimir/services.prod.yaml brew`
shows the current one), commit and push `main`.
