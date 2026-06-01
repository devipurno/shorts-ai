import { createMiddleware } from 'hono/factory';
import type { AppEnv } from '../types';

function utcDayKey(now = new Date()): string {
  return now.toISOString().slice(0, 10);
}

function secondsUntilTomorrow(now = new Date()): number {
  const tomorrow = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1));
  return Math.max(60, Math.ceil((tomorrow.getTime() - now.getTime()) / 1000));
}

export const rateLimitMiddleware = createMiddleware<AppEnv>(async (c, next) => {
  const userId = c.get('userId');
  const limit = Number.parseInt(c.env.DAILY_RATE_LIMIT || '50', 10);
  const key = `ratelimit:${userId}:${utcDayKey()}`;
  const current = Number.parseInt((await c.env.AI_RATE_LIMIT_KV.get(key)) || '0', 10);

  if (current >= limit) {
    return c.json({
      error: {
        code: 'rate_limit_exceeded',
        message: `Daily AI limit exceeded (${limit} requests/day).`,
      },
      limit,
      remaining: 0,
    }, 429);
  }

  await c.env.AI_RATE_LIMIT_KV.put(key, String(current + 1), {
    expirationTtl: secondsUntilTomorrow(),
  });
  c.header('X-RateLimit-Limit', String(limit));
  c.header('X-RateLimit-Remaining', String(Math.max(0, limit - current - 1)));
  await next();
});
