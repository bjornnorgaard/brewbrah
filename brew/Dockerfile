# syntax=docker/dockerfile:1

FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json .npmrc ./
RUN npm ci --ignore-scripts
COPY . .
RUN npm run build

# Runtime: adapter-node bundles everything it needs, so no node_modules.
FROM node:22-alpine AS run
WORKDIR /app
ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=3000 \
    ORIGIN=https://brew.bybear.dk \
    NODE_OPTIONS="--max-old-space-size=64"
COPY --from=build --chown=node:node /app/build ./build
COPY --chown=node:node package.json ./
USER 1000
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD node -e "fetch('http://127.0.0.1:3000/readyz').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"
CMD ["node", "build"]
