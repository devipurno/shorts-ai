import { Hono } from 'hono';
import type { AppEnv } from '../types';
import { proxyOpenAiCompatible } from '../lib/providers';

export const deepseekRoutes = new Hono<AppEnv>();

deepseekRoutes.post('/chat', async (c) => {
  if (!c.env.DEEPSEEK_API_KEY) {
    return c.json({ error: { code: 'server_misconfigured', message: 'DEEPSEEK_API_KEY is not configured.' } }, 500);
  }
  const body = await c.req.json();
  const result = await proxyOpenAiCompatible({
    provider: 'deepseek',
    endpoint: 'https://api.deepseek.com/v1/chat/completions',
    apiKey: c.env.DEEPSEEK_API_KEY,
    defaultModel: 'deepseek-chat',
    body,
  });
  return c.json(result);
});
