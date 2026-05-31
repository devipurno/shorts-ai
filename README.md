# Shorts AI Monorepo

Production scaffold for an AI YouTube Shorts automation MVP.

## Apps

- `apps/mobile` - Flutter mobile app based on the Figma screens 1-31.
- `apps/api` - Fastify API with Postgres repositories, typed MVP routes, BullMQ producers/runners, Socket.IO events, signed R2 uploads, FCM hooks, and YouTube OAuth/upload adapters.
- `workers/video` - Python video pipeline with isolated FFmpeg, Faster-Whisper, OpenAI, subtitle, thumbnail, R2, and callback adapters.
- `packages/shared` - Shared TypeScript contracts and status enums.
- `infra/database` - PostgreSQL migrations and RLS policy drafts.
- `infra/docker` - Local Postgres + Redis compose stack.

## Quick Start

```powershell
cd "D:\Project APP Mobile Android\shorts-ai"
npm install
npm run build:api
cd apps/mobile
flutter pub get
flutter test
```

No-Docker local app run:

```powershell
cd "D:\Project APP Mobile Android\shorts-ai"
npm run dev:api:local
```

Then open a second terminal:

```powershell
cd "D:\Project APP Mobile Android\shorts-ai"
npm run dev:mobile
```

For safe local runs, set `AUTH_BYPASS=true` and leave `WORKER_TRIGGER_URL` empty until a real worker endpoint is available. Production mode uses Supabase JWT, PostgreSQL, Redis/BullMQ, n8n webhooks, HMAC-signed internal callbacks, Cloudflare R2, FCM, OpenAI, Faster-Whisper, FFmpeg, and YouTube OAuth credentials from `.env`.

YouTube uploads require a connected YouTube account and backend OAuth credentials. `YOUTUBE_UPLOAD_DRY_RUN=true` is available only for explicit local dry-run testing; keep it `false` for production-like runs so the queue fails clearly instead of creating fake upload success.

## Supabase

Supabase project wiring is documented in `docs/supabase.md`. The project ref is `ebayydlldqdnvrhgzxfe`; migrations, storage bucket policies, realtime publication, and generated DB types are included in `supabase/` and `packages/shared/src/database.types.ts`.

### Supabase Setup

The Flutter app uses `supabase_flutter` when `SUPABASE_URL` and
`SUPABASE_ANON_KEY` or `SUPABASE_PUBLISHABLE_KEY` are present. Set
`USE_SUPABASE=false` to force local mock repositories.

```powershell
cd "D:\Project APP Mobile Android\shorts-ai"
$env:SUPABASE_URL="https://<project-ref>.supabase.co"
$env:SUPABASE_ANON_KEY="<public-anon-or-publishable-key>"
npm run supabase:db:push
flutter pub get
flutter test
```

If the Supabase CLI is not linked, run the SQL in
`supabase/migrations/20260601000001_initial_schema.sql` through the Supabase
Dashboard SQL editor. The migration creates the mobile `profiles`, project
asset tables, RLS policies, and storage buckets: `avatars`, `videos`,
`thumbnails`, and `brand_assets`.
