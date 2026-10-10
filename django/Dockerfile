# syntax=docker/dockerfile:1
FROM python:3.13.16-alpine@sha256:2d9aefe2fef018a7eb2c13064c89c71929800fd2e5dccdbf52ea5da5bb8d929a

LABEL org.opencontainers.image.source="https://github.com/ttl64computer/service-images" \
      org.opencontainers.image.description="Django starter for ttl64 clusters, served by gunicorn" \
      org.opencontainers.image.licenses="BSD-3-Clause"

# Why: the weekly rebuild picks up Alpine security fixes without waiting for a new upstream tag.
RUN apk upgrade --no-cache && adduser -D -H app

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PORT=8000
WORKDIR /srv
COPY requirements.txt .
# Why: the base ships old pip/setuptools wheels for ensurepip that scanners flag; nothing here needs them.
RUN pip install --no-cache-dir --upgrade pip setuptools \
 && rm -rf /usr/local/lib/python3.13/ensurepip \
 && pip install --no-cache-dir -r requirements.txt
COPY --chown=app:app . .
USER app

EXPOSE 8000

HEALTHCHECK --interval=10s --timeout=3s --start-period=10s \
  CMD wget -q -O /dev/null http://127.0.0.1:8000/healthz || exit 1

CMD ["sh", "-c", "exec gunicorn app.wsgi --bind 0.0.0.0:${PORT} --workers 2 --access-logfile -"]
