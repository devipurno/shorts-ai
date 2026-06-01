# AutoShort AI Proxy Worker

Thin Cloudflare Worker gateway for AutoShort AI text generation. The mobile app sends Supabase JWT-authenticated requests to this Worker, and the Worker forwards them to Gemini, Groq, or DeepSeek with server-side API keys.

## Architecture

```text
Flutter App
  | Authorization: Bearer <supabase_jwt>
  v
Cloudflare Worker (Hono)
  |-- verifies Supabase JWT via JWKS
  |-- rate limits per user in KV (50 requests/day by default)
  |-- injects provider API key from Worker secrets
  v
Gemini / Groq / DeepSeek
```

## Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| GET | `/health` | Status check |
| POST | `/ai/gemini/generate` | Gemini `generateContent` proxy |
| POST | `/ai/groq/chat` | Groq OpenAI-compatible chat proxy |
| POST | `/ai/deepseek/chat` | DeepSeek OpenAI-compatible chat proxy |

## Local Setup

```powershell
cd workers/ai-proxy
npm install
```

Create KV namespaces in Cloudflare and replace the placeholder IDs in `wrangler.toml`:

```powershell
npx wrangler kv namespace create AI_RATE_LIMIT_KV
npx wrangler kv namespace create AI_RATE_LIMIT_KV --preview
```

Set secrets. Do not commit these values.

```powershell
npx wrangler secret put GEMINI_API_KEY
npx wrangler secret put GROQ_API_KEY
npx wrangler secret put DEEPSEEK_API_KEY
npx wrangler secret put SUPABASE_PROJECT_URL
```

For local dev, Wrangler can also read a local `.dev.vars` file. Keep it untracked.

```env
GEMINI_API_KEY=...
GROQ_API_KEY=...
DEEPSEEK_API_KEY=...
SUPABASE_PROJECT_URL=https://your-project-ref.supabase.co
```

## Run Locally

```powershell
npm run dev
```

Health check:

```powershell
curl http://localhost:8787/health
```

Authenticated Gemini smoke:

```powershell
curl -X POST http://localhost:8787/ai/gemini/generate `
  -H "Authorization: Bearer <supabase_jwt>" `
  -H "Content-Type: application/json" `
  -d '{"prompt":"test"}'
```

## Deploy

Preview:

```powershell
npm run deploy:preview
```

Production:

```powershell
npm run deploy -- --env production
```

## Rate Limiting

Rate limit state is stored in Cloudflare KV using this key shape:

```text
ratelimit:{user_id}:{YYYY-MM-DD}
```

Default limit is `50` requests per UTC day. Override with `DAILY_RATE_LIMIT` in `wrangler.toml`. KV increments are eventually consistent, so this is suitable for free-tier abuse control but not billing-grade quota enforcement.

## Error Codes

| HTTP | Code | Meaning |
| --- | --- | --- |
| 401 | `unauthorized` | Missing, invalid, or expired Supabase JWT |
| 429 | `rate_limit_exceeded` | User exceeded daily AI limit |
| 502 | `upstream_error` | Provider API returned an error |
| 502 | `invalid_upstream_response` | Provider response was missing expected text |
| 500 | `server_misconfigured` | Required Worker secret or env binding missing |
| 500 | `internal_error` | Unexpected Worker error |
