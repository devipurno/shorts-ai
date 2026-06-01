# Security Policy

## Supported Versions

Phase 0-1 supports only the latest `main` branch and the latest tagged beta release.

## Reporting Vulnerabilities

Email [purnomodevi606@gmail.com](mailto:purnomodevi606@gmail.com). Phase 1.5 target: [security@autoshort.id](mailto:security@autoshort.id).

Do not open a public issue for vulnerabilities, leaked credentials, or account takeover risks.

## Response SLA

| Severity | Acknowledge | Target fix |
| --- | --- | --- |
| Critical | 7 days | 30 days |
| High / Medium / Low | 7 days | 90 days |

## Secret Handling

- Never commit `.env.local`, `.env.prod`, `android/key.properties`, `upload-keystore.jks`, `.pem`, `.key`, or `.tfstate` files.
- Use GitHub Actions secrets for CI/CD.
- Use Doppler for production secret management in Phase 1.5+.
- Rotate any key that appears in git history, chat logs, screenshots, or CI output.

## RLS Policy Summary

Full SQL lives in `supabase/migrations/`.

| Table | Policy summary |
| --- | --- |
| `profiles` | Users can read/write only their own row. |
| `projects` | Users can read/write own projects where `user_id = auth.uid()`. |
| `templates` | Users can read public templates and own custom templates. |
| `subscriptions` | Users can read own subscription; writes are backend controlled. |
| `analytics_events` | Users can insert own events and read aggregated own metrics. |
| `notifications` | Users can read and mark own notifications. |

## Authentication

- Supabase JWT with short-lived access token and refresh token.
- OTP verification for signup is Phase 0 scope.
- Two-factor authentication is deferred to Phase 2+.
- Mobile tokens are stored with `flutter_secure_storage`.

## Data Privacy

AutoShort is designed with Indonesia UU PDP and GDPR-like principles in mind.

| Area | Policy |
| --- | --- |
| Consent | Explicit consent for analytics and uploads before production launch. |
| Retention | 90 days for inactive accounts; 30 days after account deletion request. |
| Export | `/me/export` planned for Phase 1.5+. |
| Deletion | Account deletion endpoint and UI required before public launch. |
| Data residency | Prefer Singapore/Indonesia regions where providers support them. |

## Encryption

- In transit: TLS for Supabase, API, R2, and AI provider calls.
- At rest: Supabase and Cloudflare R2 server-side encryption.
- On device: secure storage for tokens and API keys.

## Audit Log

- `analytics_events` captures product usage events.
- Sentry breadcrumbs and Firebase Crashlytics are planned for Phase 1.5.
- Admin audit logs are planned once production admin tooling exists.

## Dependencies

- Dependabot checks pub, GitHub Actions, and Gradle weekly.
- Snyk or equivalent dependency scanning is deferred to Phase 1.5.
