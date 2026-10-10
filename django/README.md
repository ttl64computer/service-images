# django

`ghcr.io/ttl64computer/django` — a Django 5.2 LTS starter served by gunicorn
on Python 3.13. One page and `GET /healthz`. Listens on 8000.

Set `DJANGO_SECRET_KEY` to keep sessions across restarts, and
`DJANGO_ALLOWED_HOSTS` / `DJANGO_CSRF_TRUSTED_ORIGINS` for your domain.
