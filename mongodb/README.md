# mongodb

`ghcr.io/ttl64computer/mongodb` — the official `mongo` with defaults for small
ttl64 nodes.

## What differs from upstream

- WiredTiger cache capped at 256 MB (the default takes half the node).
- Listens on all interfaces. Authentication is on whenever
  `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD` are set, as the
  ttl64 catalog does.
- `gosu` rebuilt with a current Go; Ubuntu packages upgraded on every (weekly)
  build.

## Connect

```
mongodb://root:<password>@<host>:27017/?authSource=admin
```
