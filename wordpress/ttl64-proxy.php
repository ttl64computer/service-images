<?php
// Included from wp-config.php (WORDPRESS_CONFIG_EXTRA).
if (($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '') === 'https') {
    $_SERVER['HTTPS'] = 'on';
}
if (!empty($_SERVER['HTTP_HOST'])) {
    define('WP_HOME', (empty($_SERVER['HTTPS']) ? 'http' : 'https') . '://' . $_SERVER['HTTP_HOST']);
    define('WP_SITEURL', WP_HOME);
}
