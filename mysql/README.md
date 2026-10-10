# mysql

`ghcr.io/ttl64computer/mysql` — the official `mysql` 8.4 LTS with defaults for
small ttl64 nodes.

## What differs from upstream

- `utf8mb4` and `utf8mb4_0900_ai_ci` by default.
- Sized for 2 GB nodes: 128 MB buffer pool, no performance schema, 100
  connections. Near 300 MB of memory at rest.
- TLS 1.2 or newer. MySQL generates its certificate on the first start; clients
  can use `ssl-mode=REQUIRED`.
- `skip-name-resolve`.
- Oracle Linux packages upgraded on every (weekly) build.

Same environment variables as the official image (`MYSQL_ROOT_PASSWORD`,
`MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`).

## Tags

| Tag | Meaning |
|---|---|
| `latest` | Newest build of the current LTS |
| `8.4` | Newest build of MySQL 8.4 |
| `8.4.11` | Newest build of MySQL 8.4.11 |
| `8.4.11-YYYYMMDD` | One build, never moves |

## Connect

```
mysql://root:<password>@<host>:3306/
```
