# postgres

`ghcr.io/ttl64computer/postgres` — the official `postgres:*-alpine` with TLS on
by default.

## What differs from upstream

- TLS is on: a self-signed certificate is created in the data directory on the
  first start and renewed when it has less than 30 days left. Minimum TLS 1.2.
- Clients pick: `sslmode=require` encrypts; plain connections inside the
  cluster keep working. Use `sslmode=require` through a public load balancer.
- Alpine packages upgraded on every (weekly) build.

Everything else is the official image: same environment variables
(`POSTGRES_PASSWORD`, `POSTGRES_USER`, `POSTGRES_DB`, `PGDATA`), same
`/docker-entrypoint-initdb.d`.

## Tags

| Tag | Meaning |
|---|---|
| `latest` | Newest build of the current major |
| `17` | Newest build of Postgres 17 |
| `17.11` | Newest build of Postgres 17.11 |
| `17.11-YYYYMMDD` | One build, never moves |

## Connect

```
postgres://postgres:<password>@<host>:5432/postgres?sslmode=require
```
