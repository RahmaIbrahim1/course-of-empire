import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

export default defineConfig({
  base: '/course-of-empire/',
  plugins: [react()],
  build: { target: 'es2022', assetsDir: 'app' },
});
