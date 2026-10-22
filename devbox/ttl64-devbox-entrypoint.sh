#!/bin/sh
set -e

# The persistent volume is mounted at /workspace by the cluster (a PVC backed by
# the node's extra disk). It comes up owned by root; hand it to the dev user so
# code-server, git and the AI CLIs can write to it. API keys come from the pod's
# environment (a Secret), never from the volume.
WORKSPACE="${WORKSPACE:-/workspace}"
if [ -d "$WORKSPACE" ]; then
    chown dev:dev "$WORKSPACE" 2>/dev/null || true
fi

# Drop to the dev user for the server itself. setpriv keeps the environment, so
# HOME would stay /root (uid 0's) and code-server could not write its config;
# set it to the dev user's home explicitly.
if [ "$(id -u)" = "0" ] && command -v setpriv >/dev/null 2>&1; then
    exec setpriv --reuid=1000 --regid=1000 --init-groups \
        env HOME=/home/dev "$@"
fi
exec "$@"
