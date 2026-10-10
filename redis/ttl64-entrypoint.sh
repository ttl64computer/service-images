#!/bin/sh
# Refuses to start without REDIS_PASSWORD, then writes it where redis.conf
# includes it, so it never shows on the command line.
set -eu

if [ "${1:-}" = "" ] || [ "${1#-}" != "$1" ] || [ "$1" = "redis-server" ]; then
    if [ -z "${REDIS_PASSWORD:-}" ]; then
        echo "ttl64: set REDIS_PASSWORD; this image does not run without a password" >&2
        exit 1
    fi
    mkdir -p /run/redis
    umask 077
    printf 'requirepass "%s"\n' "$(printf '%s' "$REDIS_PASSWORD" | sed 's/["\\]/\\&/g')" > /run/redis/auth.conf
    chown -R redis:redis /run/redis 2>/dev/null || true
    [ "${1:-}" = "redis-server" ] && shift
    set -- redis-server /usr/local/etc/redis/redis.conf "$@"
fi

exec docker-entrypoint.sh "$@"
