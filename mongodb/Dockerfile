# syntax=docker/dockerfile:1
# Why: upstream's gosu is built with an old Go; rebuild the same release with a current toolchain.
FROM golang:1.27.2-alpine@sha256:f92b6ef800e499660581efdabdf25d9d817a9d124eaf900924f0504e7e27e12d AS gosu
ARG GOSU_VERSION=1.19
RUN CGO_ENABLED=0 GOBIN=/out go install -trimpath -ldflags=-s github.com/tianon/gosu@${GOSU_VERSION}

FROM mongo:8.3.13@sha256:0e900a3364da37b76d642b73b0bba56bd4c6c509ab470cf700436fd866bee3ff

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="MongoDB for ttl64 clusters: auth on, sized for small nodes" \
      org.opencontainers.image.licenses="SSPL-1.0"

# Why: the weekly rebuild picks up Ubuntu security fixes without waiting for a new upstream tag.
# The database tools (mongodump and friends) are Go binaries built with an old toolchain and the
# server doesn't use them; clients that need backups run them from their own machine.
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y purge mongodb-database-tools \
 && rm -rf /var/lib/apt/lists/*

# Why: the official entrypoint reads the config with js-yaml from /opt/js-yaml; upstream pins
# 3.13.1, which has known DoS bugs. 3.15.2 has the fixes and the same API and layout.
ADD --checksum=sha256:7f005cf0b8ee639b4557e0e321dc067c1f2aa0a442d096e03f2ab53353738794 \
    https://registry.npmjs.org/js-yaml/-/js-yaml-3.15.2.tgz /tmp/js-yaml.tgz
RUN rm -rf /opt/js-yaml \
 && mkdir -p /opt/js-yaml \
 && tar -xzf /tmp/js-yaml.tgz -C /opt/js-yaml --strip-components=1 \
 && rm /tmp/js-yaml.tgz

COPY --from=gosu /out/gosu /usr/local/bin/gosu
COPY mongod.conf /etc/mongod.conf

EXPOSE 27017

CMD ["mongod", "--config", "/etc/mongod.conf"]

HEALTHCHECK --interval=10s --timeout=5s --start-period=30s \
  CMD mongosh --quiet --eval "db.adminCommand('ping').ok" | grep -q 1 || exit 1
