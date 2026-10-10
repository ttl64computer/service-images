# redis

`ghcr.io/ttl64computer/redis` — the official `redis:*-alpine` with a required
password and defaults for small ttl64 nodes.

## What differs from upstream

- Does not start without `REDIS_PASSWORD`. The password goes into a config
  file, not the command line.
- Listens on all interfaces, always behind the password.
- `maxmemory 256mb` with `allkeys-lru`: evicts instead of failing writes.
- No persistence (`save ""`, no AOF): a cache on an ephemeral cluster.
- Alpine packages upgraded on every (weekly) build.

## Tags

| Tag | Meaning |
|---|---|
| `latest` | Newest build of the current major |
| `8.10` | Newest build of Redis 8.10 |
| `8.10.2` | Newest build of Redis 8.10.2 |
| `8.10.2-YYYYMMDD` | One build, never moves |

## Connect

```
redis://:<password>@<host>:6379
```

Redis 8 is licensed AGPLv3 (among others); this image runs it unmodified.
