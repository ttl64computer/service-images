# nginx

`ghcr.io/ttl64computer/nginx` — the official `nginx:*-alpine` with defaults for
ttl64 clusters.

## What differs from upstream

- `server_tokens off`, `X-Content-Type-Options` and `Referrer-Policy` headers.
- `GET /healthz` answers `200 ok`, outside the access log, for probes.
- Access log includes `CF-Connecting-IP`: public HTTP endpoints on ttl64 go
  through Cloudflare.
- gzip for text, `client_max_body_size 16m`.
- A ttl64 welcome page instead of the stock one.
- Alpine packages upgraded on every (weekly) build.

## Tags

| Tag | Meaning |
|---|---|
| `latest` | Newest build of the current stable line |
| `1.30` | Newest build of nginx 1.30 |
| `1.30.5` | Newest build of nginx 1.30.5 |
| `1.30.5-YYYYMMDD` | One build, never moves |

## Use

```dockerfile
FROM ghcr.io/ttl64computer/nginx:1.30
COPY ./site /usr/share/nginx/html
```

Listens on port 80.
