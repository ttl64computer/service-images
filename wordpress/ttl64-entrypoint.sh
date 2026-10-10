#!/bin/sh
# Starts WordPress as the official image does and, when WORDPRESS_ADMIN_PASSWORD
# is set, installs it in the background once the database answers, so the site
# opens ready to log in instead of on the setup screen.
set -eu

if [ -n "${WORDPRESS_ADMIN_PASSWORD:-}" ]; then
    (
        for _ in $(seq 1 120); do
            sleep 5
            [ -f /var/www/html/wp-config.php ] || continue
            if wp --allow-root --path=/var/www/html core is-installed >/dev/null 2>&1; then
                exit 0
            fi
            if wp --allow-root --path=/var/www/html core install \
                --url="${WORDPRESS_URL:-http://localhost}" \
                --title="${WORDPRESS_TITLE:-WordPress}" \
                --admin_user="${WORDPRESS_ADMIN_USER:-admin}" \
                --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
                --admin_email="${WORDPRESS_ADMIN_EMAIL:-admin@example.com}" \
                --skip-email >/dev/null 2>&1; then
                echo "ttl64: WordPress installed; log in as ${WORDPRESS_ADMIN_USER:-admin}"
                exit 0
            fi
        done
        echo "ttl64: WordPress could not be installed; is the database up?" >&2
    ) &
fi

exec docker-entrypoint.sh "$@"
