# syntax=docker/dockerfile:1
FROM redis:8.10.2-alpine@sha256:3811787313eba226a2ef38658c6ccb91cd5e110edc89c37767de373120a0e5a0

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="Redis for ttl64 clusters: password required, sized for small nodes" \
      org.opencontainers.image.licenses="AGPL-3.0-only"

# Why: the weekly rebuild picks up Alpine security fixes without waiting for a new upstream tag.
RUN apk upgrade --no-cache

COPY redis.conf /usr/local/etc/redis/redis.conf
COPY ttl64-entrypoint.sh /usr/local/bin/ttl64-entrypoint.sh

ENTRYPOINT ["ttl64-entrypoint.sh"]

EXPOSE 6379

# Why: REDISCLI_AUTH keeps the password out of the process list.
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
  CMD REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 ping | grep -q PONG || exit 1
