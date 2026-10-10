/** @type {import('next').NextConfig} */
export default {
  // Why: a standalone server is a few MB and needs no node_modules at runtime.
  output: 'standalone',
  poweredByHeader: false,
};
