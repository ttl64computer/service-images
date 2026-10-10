from datetime import datetime, timezone

from django.http import HttpResponse
from django.urls import path


def home(request):
    now = datetime.now(timezone.utc).isoformat()
    return HttpResponse(
        "<!doctype html><title>Django on ttl64</title>"
        "<main style='min-height:100vh;display:grid;place-items:center;font-family:system-ui'>"
        "<div><div style='font:600 13px monospace;color:#6b6b70'>ttl64 · Django</div>"
        f"<h1>Django is running.</h1><p style='color:#6b6b70'>Server time {now}.</p></div></main>"
    )


def healthz(request):
    return HttpResponse("ok\n", content_type="text/plain")


urlpatterns = [path("", home), path("healthz", healthz)]
