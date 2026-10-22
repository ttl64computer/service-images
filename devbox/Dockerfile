# syntax=docker/dockerfile:1
FROM debian:bookworm-slim@sha256:7ff6ba31527b9e336162fa061746c366c4b2032f4d2cff2078bea43f78efe3f8

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="AI dev environment for ttl64 clusters: code-server, git, Node, Python/uv, Claude Code and Codex CLI, on a persistent /workspace" \
      org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive \
    NODE_MAJOR=22 \
    WORKSPACE=/workspace \
    PNPM_HOME=/usr/local/share/pnpm \
    PATH=/usr/local/share/pnpm:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Why: the weekly rebuild picks up Debian security fixes without a new base tag.
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl git openssh-client less jq ripgrep \
      python3 python3-venv build-essential \
 && rm -rf /var/lib/apt/lists/*

# Node (NodeSource) + pnpm; Claude Code and Codex CLIs from npm.
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && npm install -g pnpm @anthropic-ai/claude-code @openai/codex \
 && npm cache clean --force \
 && rm -rf /var/lib/apt/lists/*

# uv (fast Python package manager), into /usr/local/bin.
RUN curl -fsSL https://astral.sh/uv/install.sh | env UV_INSTALL_DIR=/usr/local/bin sh

# code-server: the browser IDE, published to the volume-backed workspace.
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Why: a non-root user owns the workspace; the volume is chowned to it at start.
RUN useradd --create-home --shell /bin/bash --uid 1000 dev \
 && mkdir -p "$WORKSPACE" \
 && chown dev:dev "$WORKSPACE"

COPY ttl64-devbox-entrypoint.sh /usr/local/bin/ttl64-devbox-entrypoint.sh

WORKDIR /workspace
EXPOSE 8080
ENTRYPOINT ["ttl64-devbox-entrypoint.sh"]
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/workspace"]

HEALTHCHECK --interval=10s --timeout=5s --start-period=20s \
  CMD curl -fsS http://127.0.0.1:8080/healthz || exit 1
