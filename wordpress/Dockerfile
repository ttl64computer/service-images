# syntax=docker/dockerfile:1
FROM wordpress:7.1.3-php8.4-apache@sha256:309307430abf80009378a63a79df73554a6449b700fac59a991b4959e6dda8ca

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="WordPress for ttl64 clusters: installs itself on first start, works behind the ttl64 HTTPS edge" \
      org.opencontainers.image.licenses="GPL-2.0-or-later"

# Why: the weekly rebuild picks up Debian security fixes without waiting for a new upstream tag.
RUN apt-get update \
 && apt-get -y upgrade \
 && rm -rf /var/lib/apt/lists/*

ADD --checksum=sha256:ce34ddd838f7351d6759068d09793f26755463b4a4610a5a5c0a97b68220d85c \
    https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar /usr/local/bin/wp
RUN chmod 755 /usr/local/bin/wp

COPY ttl64-entrypoint.sh /usr/local/bin/ttl64-entrypoint.sh

# Why: public HTTP on ttl64 ends TLS at Cloudflare and reaches Apache as plain HTTP; WordPress
# must still build https:// links, on whatever hostname the load balancer gives it. The PHP lives
# in a file because Docker would expand its $_SERVER in an ENV value.
COPY ttl64-proxy.php /usr/local/etc/ttl64-proxy.php
ENV WORDPRESS_CONFIG_EXTRA="require '/usr/local/etc/ttl64-proxy.php';"

ENTRYPOINT ["ttl64-entrypoint.sh"]
CMD ["apache2-foreground"]

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
  CMD curl -fsS -o /dev/null http://127.0.0.1/wp-includes/images/blank.gif || exit 1
