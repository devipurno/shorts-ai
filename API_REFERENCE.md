# API Reference

## Base URL

| Environment | Base URL |
| --- | --- |
| Phase 0 | `https://api.dayscent.com` |
| Phase 1.5+ | `https://api.autoshort.id` |
| Local | `Env.apiBaseUrl`, default `http://localhost:8000` |

## Authentication

All user-scoped endpoints require a Supabase JWT:

```http
Authorization: Bearer <supabase-access-token>
Content-Type: application/json
```

The Flutter app injects this header through the Dio auth interceptor. Internal worker callbacks are HMAC-signed and are not public mobile API endpoints.

## Rate Limits

Phase 0 target: 100 requests per minute per authenticated user. API responses should include rate limit headers when the Fastify backend is active.

## Error Envelope

```json
{
  "ok": false,
  "error": {
    "code": "validation_error",
    "message": "Title is required"
  }
}
```

## Endpoint Catalog

### Auth

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| POST | `/auth/login` | No | Email/password login proxy when backend auth is enabled. |
| GET | `/auth/session` | Yes | Validate current user session. |
| POST | `/auth/refresh` | Yes | Refresh backend session metadata. |

Example:

```bash
curl -H "Authorization: Bearer $TOKEN" https://api.dayscent.com/auth/session
```

### Projects

| Method | Path | Auth | Body |
| --- | --- | --- | --- |
| GET | `/projects?user_id={userId}` | Yes | None |
| POST | `/projects` | Yes | `Project` JSON |
| GET | `/projects/{id}` | Yes | None |
| PATCH | `/projects/{id}` | Yes | Partial `Project` JSON |
| DELETE | `/projects/{id}` | Yes | None |

Request body:

```json
{
  "id": "project-id",
  "user_id": "user-id",
  "title": "Podcast highlights",
  "description": "Short clips from episode 12",
  "status": "draft",
  "tags": ["podcast", "shorts"]
}
```

### Scripts

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| GET | `/scripts?project_id={projectId}` | Yes | List project scripts. |
| POST | `/scripts` | Yes | Create generated script. |
| PATCH | `/scripts/{id}` | Yes | Update selected hook or script text. |

### Subtitles

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| GET | `/subtitles?project_id={projectId}` | Yes | List subtitles. |
| POST | `/subtitles` | Yes | Save subtitle segments/style. |
| PATCH | `/subtitles/{id}` | Yes | Update segments, style, or format. |
| DELETE | `/subtitles/{id}` | Yes | Delete subtitle asset. |

### Thumbnails

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| GET | `/thumbnails?project_id={projectId}` | Yes | List variants. |
| POST | `/thumbnails` | Yes | Create thumbnail record. |
| PATCH | `/thumbnails/{id}` | Yes | Update CTR, selected variant, or URLs. |
| DELETE | `/thumbnails/{id}` | Yes | Delete thumbnail. |

### Templates

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| GET | `/templates` | Optional | List public and allowed templates. |
| GET | `/templates/{id}` | Optional | Read template details. |
| POST | `/templates/{id}/use` | Yes | Create a project from a template. |

### Brand Kits

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| GET | `/brand-kits?user_id={userId}` | Yes | List brand kits. |
| POST | `/brand-kits` | Yes | Create brand kit. |
| PATCH | `/brand-kits/{id}` | Yes | Update logo, palette, fonts, watermark. |
| DELETE | `/brand-kits/{id}` | Yes | Delete brand kit. |

### Subscriptions and Referrals

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| GET | `/subscriptions/current` | Yes | Current tier and billing state. |
| POST | `/subscriptions/checkout` | Yes | Start mock/real checkout. |
| GET | `/subscriptions/lifetime-slots` | Optional | Remaining lifetime slots. |
| GET | `/referrals` | Yes | List referral relationships. |
| POST | `/referrals` | Yes | Register referral code usage. |

### Analytics and Notifications

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| POST | `/analytics/events` | Yes | Track user event. |
| GET | `/analytics/summary?period=30d` | Yes | Dashboard metrics. |
| GET | `/notifications` | Yes | List notifications. |
| PATCH | `/notifications/{id}/read` | Yes | Mark notification read. |

### Source Videos and Processing

| Method | Path | Auth | Purpose |
| --- | --- | --- | --- |
| POST | `/sources` | Yes | Create source video metadata. |
| POST | `/sources/{id}/upload-url` | Yes | Create signed upload URL. |
| POST | `/sources/{id}/ready` | Yes | Mark source ready for processing. |
| POST | `/processing/jobs` | Yes | Start processing batch. |
| GET | `/processing/jobs/{id}` | Yes | Read processing status. |
| GET | `/generated-shorts?project_id={projectId}` | Yes | List generated shorts. |
| POST | `/upload-queue` | Yes | Queue YouTube/TikTok upload. |

## Realtime Channels

| Channel | Source | Payload |
| --- | --- | --- |
| `processing_jobs` | Supabase realtime | Job status, progress, current step. |
| `generated_shorts` | Supabase realtime | New short clip rows. |
| `notification_events` | Supabase realtime | User notification rows. |

## Webhook Events

Phase 1.5+ public webhook events:

- `processing.completed`
- `processing.failed`
- `payment.success`
- `payment.failed`
- `upload.completed`

## Internal AI Services

AI provider calls are internal to the app/server and should not be exposed as public endpoints. See [ARCHITECTURE.md](ARCHITECTURE.md) and [docs/AI_PROVIDER_STRATEGY.md](docs/AI_PROVIDER_STRATEGY.md).
