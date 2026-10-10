package main

import (
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"time"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	mux := http.NewServeMux()
	mux.HandleFunc("GET /healthz", func(w http.ResponseWriter, _ *http.Request) {
		fmt.Fprintln(w, "ok")
	})
	mux.HandleFunc("GET /", func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		fmt.Fprintf(w, `<!doctype html><title>Go on ttl64</title>
<main style="min-height:100vh;display:grid;place-items:center;font-family:system-ui">
<div><div style="font:600 13px monospace;color:#6b6b70">ttl64 · Go</div>
<h1>Go is running.</h1><p style="color:#6b6b70">Server time %s.</p></div></main>`, time.Now().UTC().Format(time.RFC3339))
	})

	server := &http.Server{Addr: ":" + port, Handler: mux, ReadHeaderTimeout: 10 * time.Second}
	slog.Info("listening", "port", port)
	if err := server.ListenAndServe(); err != nil {
		slog.Error("server stopped", "error", err)
		os.Exit(1)
	}
}
