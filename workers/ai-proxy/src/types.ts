import type { JWTPayload } from 'jose';

export type Bindings = {
  AI_RATE_LIMIT_KV: KVNamespace;
  GEMINI_API_KEY: string;
  GROQ_API_KEY: string;
  DEEPSEEK_API_KEY: string;
  SUPABASE_PROJECT_URL: string;
  DAILY_RATE_LIMIT?: string;
};

export type Variables = {
  userId: string;
  jwtPayload: JWTPayload;
};

export type AppEnv = {
  Bindings: Bindings;
  Variables: Variables;
};


