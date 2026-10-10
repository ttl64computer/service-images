# wordpress

`ghcr.io/ttl64computer/wordpress` — the official WordPress (PHP 8.4, Apache)
that installs itself on the first start and works behind the ttl64 HTTPS edge.

## What differs from upstream

- With `WORDPRESS_ADMIN_PASSWORD` set, WordPress installs itself as soon as the
  database answers: admin `WORDPRESS_ADMIN_USER` (default `admin`), email
  `WORDPRESS_ADMIN_EMAIL`, title `WORDPRESS_TITLE`. No setup screen.
- Links follow the request's host and `X-Forwarded-Proto`, so the site works on
  whatever address its load balancer gets, over HTTPS.
- wp-cli included (`wp --allow-root`).
- Debian packages upgraded on every (weekly) build.

The database is MySQL, as upstream: `WORDPRESS_DB_HOST`, `WORDPRESS_DB_USER`,
`WORDPRESS_DB_PASSWORD`, `WORDPRESS_DB_NAME`. On ttl64, Add service creates a
MySQL next to it and fills these in. Listens on 80; data in `/var/www/html`.
