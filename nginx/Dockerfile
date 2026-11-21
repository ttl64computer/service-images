# syntax=docker/dockerfile:1
FROM nginx:1.31.8-alpine@sha256:fed7e14be83cbd2661a75cdc5b872d936cf155d46c327084d30b8df19ae88d72

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="Nginx for ttl64 clusters: hardened defaults, /healthz and a welcome page" \
      org.opencontainers.image.licenses="BSD-2-Clause"

# Why: the weekly rebuild picks up Alpine security fixes without waiting for a new upstream tag.
RUN apk upgrade --no-cache

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -q -O /dev/null http://127.0.0.1/healthz || exit 1
