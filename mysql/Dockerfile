# syntax=docker/dockerfile:1
# Why: upstream's gosu is built with an old Go; rebuild the same release with a current toolchain.
FROM golang:1.27.2-alpine@sha256:f92b6ef800e499660581efdabdf25d9d817a9d124eaf900924f0504e7e27e12d AS gosu
ARG GOSU_VERSION=1.19
RUN CGO_ENABLED=0 GOBIN=/out go install -trimpath -ldflags=-s github.com/tianon/gosu@${GOSU_VERSION}

FROM mysql:8.4.11@sha256:24989179f58856db763f418010c1169fecc944e3ec1ea7e921572d83eb070f70

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="MySQL 8.4 LTS for ttl64 clusters: utf8mb4, TLS, sized for small nodes" \
      org.opencontainers.image.licenses="GPL-2.0-only"

# Why: the weekly rebuild picks up Oracle Linux security fixes without waiting for a new upstream tag.
# MySQL Shell is a client tool with its own Python stack; the server doesn't need it.
RUN microdnf -y remove mysql-shell \
 && microdnf -y update \
 && microdnf clean all

COPY --from=gosu /out/gosu /usr/local/bin/gosu

COPY ttl64.cnf /etc/mysql/conf.d/ttl64.cnf

EXPOSE 3306

HEALTHCHECK --interval=10s --timeout=5s --start-period=60s \
  CMD mysqladmin ping -h 127.0.0.1 --silent || exit 1
