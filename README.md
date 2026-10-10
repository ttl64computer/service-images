# service-images

Container images behind the **Add service** catalog on ttl64 clusters.

Each directory is one image, built on the official upstream image pinned by
digest, with defaults that fit a small, short-lived Kubernetes cluster. Images
are public on GitHub Container Registry:

| Image | Upstream | Pull |
|---|---|---|
| [nginx](nginx/) | `nginx:*-alpine` | `ghcr.io/ttl64computer/nginx` |
| [postgres](postgres/) | `postgres:*-alpine` | `ghcr.io/ttl64computer/postgres` |
| [mysql](mysql/) | `mysql:8.4` | `ghcr.io/ttl64computer/mysql` |
| [redis](redis/) | `redis:*-alpine` | `ghcr.io/ttl64computer/redis` |

## How images are built

- A push to `main` that touches an image's directory builds and publishes it.
- Every image is rebuilt weekly, so OS patches land without a version change.
- Each build is scanned with Trivy; a fixable critical or high CVE fails it.
- Dependabot opens a pull request when an upstream digest changes.

## Branches

Gitflow: work on `feature/*` from `develop`, merge into `develop`, release to
`main`. Only `main` publishes.
