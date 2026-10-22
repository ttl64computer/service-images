# devbox

An AI-focused development environment for a ttl64 cluster: a browser IDE
(code-server) with git, Node + pnpm, Python + uv, and the **Claude Code** and
**Codex** CLIs, working on a `/workspace` that lives on a persistent volume.

Pull: `ghcr.io/ttl64computer/devbox`.

## How it is used

- Create a persistent volume, then a cluster with it attached:
  `ttl64 volumes create workspace --size 10`,
  then `ttl64 create --volume vol_… --mount /workspace`.
- The cluster mounts the volume's disk and binds it to a `workspace` PVC; the
  devbox Deployment claims it at `/workspace`. Deleting the cluster leaves the
  volume (and everything under `/workspace`) intact for the next one.
- code-server is published through the cluster's load balancer on port 8080.

## Secrets

API keys for the AI CLIs (e.g. `ANTHROPIC_API_KEY`) come from the pod's
environment, set from a Kubernetes Secret — never baked into the image and never
written to the volume.

## Build

Same as the other images in this repo: a push to `main` touching this directory
builds and publishes it; it is rebuilt weekly for OS patches, scanned with
Trivy, and the base digest is bumped by Dependabot.
