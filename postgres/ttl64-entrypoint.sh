#!/bin/sh
# Later starts: a data directory from an older image, or a certificate close to
# expiry, gets TLS before Postgres starts. Then the official entrypoint runs.
set -eu

if [ "${1:-}" = "postgres" ] && [ -s "${PGDATA:-/var/lib/postgresql/data}/PG_VERSION" ]; then
    export PGDATA="${PGDATA:-/var/lib/postgresql/data}"
    if [ "$(id -u)" = "0" ]; then
        su-exec postgres /usr/local/bin/ttl64-ssl.sh
    else
        /usr/local/bin/ttl64-ssl.sh
    fi
fi

exec docker-entrypoint.sh "$@"
