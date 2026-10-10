# syntax=docker/dockerfile:1
FROM postgres:17.11-alpine@sha256:b0f9560a2de083e2cc7382e75f808c7381a32852a7ec49117deedb300e552b24

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="Postgres for ttl64 clusters: TLS on by default with a self-signed certificate" \
      org.opencontainers.image.licenses="PostgreSQL"

# Why: the weekly rebuild picks up Alpine security fixes without waiting for a new upstream tag.
# gosu is a Go binary pinned to an old toolchain (scanners flag its stdlib); su-exec does the
# same job, is built by Alpine, and takes the same arguments, so the entrypoint calls it instead.
RUN apk upgrade --no-cache \
 && apk add --no-cache openssl su-exec \
 && rm -f /usr/local/bin/gosu \
 && sed -i 's/\bgosu\b/su-exec/g' /usr/local/bin/docker-entrypoint.sh

COPY ttl64-ssl.sh /usr/local/bin/ttl64-ssl.sh
COPY ttl64-entrypoint.sh /usr/local/bin/ttl64-entrypoint.sh
COPY 10-ttl64-ssl.sh /docker-entrypoint-initdb.d/10-ttl64-ssl.sh

ENTRYPOINT ["ttl64-entrypoint.sh"]
CMD ["postgres"]

EXPOSE 5432

HEALTHCHECK --interval=10s --timeout=5s --start-period=30s \
  CMD pg_isready -U "${POSTGRES_USER:-postgres}" -h 127.0.0.1 || exit 1
