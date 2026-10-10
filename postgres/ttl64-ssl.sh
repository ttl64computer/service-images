#!/bin/sh
# Turns TLS on in an initialized data directory: a self-signed certificate
# (renewed when it has less than 30 days left) and the ssl settings. Runs as
# the postgres user. Clients choose: sslmode=require encrypts, the default
# (prefer) uses TLS when offered, plain connections still work in-cluster.
set -eu

data="${PGDATA:?PGDATA is not set}"
cert="$data/server.crt"
key="$data/server.key"
conf="$data/postgresql.conf"

if [ ! -s "$cert" ] || ! openssl x509 -checkend 2592000 -noout -in "$cert" >/dev/null 2>&1; then
    openssl req -new -x509 -days 825 -nodes -newkey rsa:2048 \
        -subj "/CN=${TTL64_SSL_CN:-postgres}" \
        -keyout "$key" -out "$cert" >/dev/null 2>&1
    chmod 600 "$key"
    echo "ttl64: generated a self-signed TLS certificate"
fi

if ! grep -q '^# ttl64 ssl' "$conf"; then
    cat >> "$conf" <<CONF

# ttl64 ssl
ssl = on
ssl_cert_file = 'server.crt'
ssl_key_file = 'server.key'
ssl_min_protocol_version = 'TLSv1.2'
CONF
fi
