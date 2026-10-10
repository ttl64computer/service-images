# syntax=docker/dockerfile:1
FROM mysql:8.4.11@sha256:6ea90827b1100f8f2ae306a539f86d2c264a26ed435a2a9f75551dd5c3aeb242

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="MySQL 8.4 LTS for ttl64 clusters: utf8mb4, TLS, sized for small nodes" \
      org.opencontainers.image.licenses="GPL-2.0-only"

# Why: the weekly rebuild picks up Oracle Linux security fixes without waiting for a new upstream tag.
RUN microdnf -y update && microdnf clean all

COPY ttl64.cnf /etc/mysql/conf.d/ttl64.cnf

EXPOSE 3306

HEALTHCHECK --interval=10s --timeout=5s --start-period=60s \
  CMD mysqladmin ping -h 127.0.0.1 --silent || exit 1
