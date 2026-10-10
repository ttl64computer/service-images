import { StrictMode, useState } from 'react';
import { createRoot } from 'react-dom/client';

function App() {
  const [count, setCount] = useState(0);
  return (
    <main style={{ minHeight: '100vh', display: 'grid', placeItems: 'center', padding: 24, fontFamily: 'ui-sans-serif, system-ui, sans-serif' }}>
      <div style={{ maxWidth: 520 }}>
        <div style={{ font: '600 13px ui-monospace, monospace', color: '#6b6b70' }}>ttl64 · React</div>
        <h1 style={{ margin: '12px 0 8px', fontSize: 28, letterSpacing: '-0.03em' }}>React is running.</h1>
        <button type="button" onClick={() => setCount((value) => value + 1)}>
          Clicked {count} times
        </button>
      </div>
    </main>
  );
}

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
