import { createRemoteJWKSet, jwtVerify, jwksCache, type ExportedJWKSCache, type JWKSCacheInput } from 'jose';
import { createMiddleware } from 'hono/factory';
import type { AppEnv } from '../types';

const memoryJwks = new Map<string, ReturnType<typeof createRemoteJWKSet>>();
const jwksCacheKey = 'jwks:supabase:cache';
const jwksCacheTtlSeconds = 60 * 60;

function bearerToken(header: string | undefined): string | null {
  if (!header) return null;
  const match = header.match(/^Bearer\s+(.+)$/i);
  return match?.[1]?.trim() || null;
}

function jwksUrl(projectUrl: string): URL {
  return new URL('/auth/v1/.well-known/jwks.json', projectUrl);
}

async function remoteJwks(env: AppEnv['Bindings']) {
  const url = jwksUrl(env.SUPABASE_PROJECT_URL).toString();
  const cached = await env.AI_RATE_LIMIT_KV.get(jwksCacheKey, 'json') as ExportedJWKSCache | null;
  const cacheInput: JWKSCacheInput = cached || {};
  const before = cacheInput.uat;

  let jwks = memoryJwks.get(url);
  if (!jwks) {
    jwks = createRemoteJWKSet(new URL(url), { [jwksCache]: cacheInput });
    memoryJwks.set(url, jwks);
  }

  return {
    jwks,
    persist: async () => {
      if (cacheInput.uat !== before) {
        await env.AI_RATE_LIMIT_KV.put(jwksCacheKey, JSON.stringify(cacheInput), {
          expirationTtl: jwksCacheTtlSeconds,
        });
      }
    },
  };
}

export const authMiddleware = createMiddleware<AppEnv>(async (c, next) => {
  const token = bearerToken(c.req.header('authorization'));
  if (!token) {
    return c.json({ error: { code: 'unauthorized', message: 'Missing bearer token.' } }, 401);
  }

  if (!c.env.SUPABASE_PROJECT_URL) {
    return c.json({ error: { code: 'server_misconfigured', message: 'SUPABASE_PROJECT_URL is not configured.' } }, 500);
  }

  try {
    const { jwks, persist } = await remoteJwks(c.env);
    const { payload } = await jwtVerify(token, jwks, {
      issuer: `${c.env.SUPABASE_PROJECT_URL.replace(/\/$/, '')}/auth/v1`,
    });
    await persist();

    if (!payload.sub) {
      return c.json({ error: { code: 'unauthorized', message: 'JWT subject is missing.' } }, 401);
    }

    c.set('userId', payload.sub);
    c.set('jwtPayload', payload);
    await next();
  } catch {
    return c.json({ error: { code: 'unauthorized', message: 'Invalid or expired JWT.' } }, 401);
  }
});

