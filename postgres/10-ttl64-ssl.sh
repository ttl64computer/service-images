#!/bin/sh
# First start: initdb just made the data directory; turn TLS on before Postgres starts for real.
set -eu
/usr/local/bin/ttl64-ssl.sh
