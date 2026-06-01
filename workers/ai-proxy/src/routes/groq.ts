import { Hono } from 'hono';
import type { AppEnv } from '../types';
import { proxyOpenAiCompatible } from '../lib/providers';

export const groqRoutes = new Hono<AppEnv>();

groqRoutes.post('/chat', async (c) => {
  if (!c.env.GROQ_API_KEY) {
    return c.json({ error: { code: 'server_misconfigured', message: 'GROQ_API_KEY is not configured.' } }, 500);
  }
  const body = await c.req.json();
  const result = await proxyOpenAiCompatible({
    provider: 'groq',
    endpoint: 'https://api.groq.com/openai/v1/chat/completions',
    apiKey: c.env.GROQ_API_KEY,
    defaultModel: 'llama-3.3-70b-versatile',
    body,
  });
  return c.json(result);
});
