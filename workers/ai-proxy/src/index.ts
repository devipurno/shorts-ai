import { Hono } from 'hono';
import { deepseekRoutes } from './routes/deepseek';
import { geminiRoutes } from './routes/gemini';
import { groqRoutes } from './routes/groq';
import { authMiddleware } from './middleware/auth';
import { rateLimitMiddleware } from './middleware/ratelimit';
import type { AppEnv } from './types';

const app = new Hono<AppEnv>();

app.get('/health', (c) => c.json({ ok: true, service: 'shorts-ai-ai-proxy' }));

app.use('/ai/*', authMiddleware);
app.use('/ai/*', rateLimitMiddleware);
app.route('/ai/gemini', geminiRoutes);
app.route('/ai/groq', groqRoutes);
app.route('/ai/deepseek', deepseekRoutes);

app.notFound((c) => c.json({ error: { code: 'not_found', message: 'Route not found.' } }, 404));

app.onError((error, c) => {
  if (error instanceof Response) return error;
  console.error('[ai-proxy] unhandled error:', error);
  return c.json({ error: { code: 'internal_error', message: 'Unexpected error.' } }, 500);
});

export default app;
