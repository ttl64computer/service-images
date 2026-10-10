# syntax=docker/dockerfile:1
FROM wordpress:7.1.3-php8.4-apache@sha256:309307430abf80009378a63a79df73554a6449b700fac59a991b4959e6dda8ca

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="WordPress for ttl64 clusters: runs on SQLite, no separate database" \
      org.opencontainers.image.licenses="GPL-2.0-or-later"

ARG SQLITE_PLUGIN_VERSION=3.1.0

# Why: the weekly rebuild picks up Debian security fixes without waiting for a new upstream tag.
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get install -y --no-install-recommends unzip \
 && rm -rf /var/lib/apt/lists/*

# Why: on a short-lived cluster one container is enough; the SQLite integration (from
# WordPress.org) replaces MySQL. The official entrypoint copies /usr/src/wordpress into
# the volume on first start, so the plugin and its db.php drop-in go there.
RUN curl -fsSL -o /tmp/sqlite.zip "https://downloads.wordpress.org/plugin/sqlite-database-integration.${SQLITE_PLUGIN_VERSION}.zip" \
 && unzip -q /tmp/sqlite.zip -d /usr/src/wordpress/wp-content/plugins \
 && rm /tmp/sqlite.zip \
 && sed "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#/var/www/html/wp-content/plugins/sqlite-database-integration#; s#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#" \
      /usr/src/wordpress/wp-content/plugins/sqlite-database-integration/db.copy \
      > /usr/src/wordpress/wp-content/db.php \
 && chown -R www-data:www-data /usr/src/wordpress/wp-content

# Why: the entrypoint writes wp-config.php from WORDPRESS_* variables; these point it at SQLite.
ENV WORDPRESS_DB_HOST=localhost WORDPRESS_DB_NAME=wordpress WORDPRESS_DB_USER=wordpress WORDPRESS_DB_PASSWORD=unused

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
  CMD curl -fsS -o /dev/null http://127.0.0.1/wp-includes/images/blank.gif || exit 1
