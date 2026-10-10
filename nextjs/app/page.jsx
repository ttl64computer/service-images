export const dynamic = 'force-dynamic';

export default function Page() {
  return (
    <main style={{ minHeight: '100vh', display: 'grid', placeItems: 'center', padding: 24 }}>
      <div style={{ maxWidth: 520 }}>
        <div style={{ font: '600 13px ui-monospace, monospace', color: '#6b6b70' }}>ttl64 · Next.js</div>
        <h1 style={{ margin: '12px 0 8px', fontSize: 28, letterSpacing: '-0.03em' }}>Next.js is running.</h1>
        <p style={{ color: '#6b6b70' }}>
          Rendered on the server at {new Date().toISOString()}. Replace <code>app/page.jsx</code> with your app.
        </p>
      </div>
    </main>
  );
}
