import { Hono } from 'hono';
import type { AppEnv } from '../types';
import { proxyGemini } from '../lib/providers';

export const geminiRoutes = new Hono<AppEnv>();

geminiRoutes.post('/generate', async (c) => {
  if (!c.env.GEMINI_API_KEY) {
    return c.json({ error: { code: 'server_misconfigured', message: 'GEMINI_API_KEY is not configured.' } }, 500);
  }
  const body = await c.req.json();
  const result = await proxyGemini(body, c.env.GEMINI_API_KEY);
  return c.json(result);
});
