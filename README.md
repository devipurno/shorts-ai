# AutoShort

![AutoShort logo](docs/assets/logo.png)

AI-powered short video creation - from idea to YouTube/TikTok in minutes.

[![CI](https://github.com/purnomodevi606/shorts-ai/actions/workflows/ci.yml/badge.svg)](https://github.com/purnomodevi606/shorts-ai/actions/workflows/ci.yml)
[![Coverage](https://codecov.io/gh/purnomodevi606/shorts-ai/branch/main/graph/badge.svg)](https://codecov.io/gh/purnomodevi606/shorts-ai)
![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B)
[![License](https://img.shields.io/badge/license-Proprietary-red.svg)](LICENSE)
![Release](https://img.shields.io/github/v/release/purnomodevi606/shorts-ai?display_name=tag)

AutoShort is an Android-first Flutter app for Indonesian creators who want a practical AI workflow for short-form video. The canonical app currently lives in root `lib/`; older workspace folders are kept separate until the mobile transplant cleanup is complete.

## Screenshots

| Home | Editor | Subtitle Studio | Thumbnail Editor |
| --- | --- | --- | --- |
| ![Home](docs/screenshots/home_screen.png) | ![Editor](docs/screenshots/editor.png) | ![Subtitle Studio](docs/screenshots/subtitle_studio.png) | ![Thumbnail Editor](docs/screenshots/thumbnail_editor.png) |

Replace these placeholders with emulator screenshots before public beta. Recommended size: 1080 x 2400 PNG.

## Features

- AI Hook Generator with five ranked hook variants.
- Mini Editor with timeline, trim, split, speed, music, watermark, filter, and export tabs.
- Subtitle Studio Pro with ASS, SRT, VTT export and karaoke-style animation controls.
- Thumbnail Editor with A/B variants, mock CTR prediction, and AI-generated options.
- Template Library with seeded templates and premium tier gating.
- Brand Kit for logo, palette, typography, watermark, intro, and outro assets.
- Content Calendar with scheduled post planning.
- Creator Analytics dashboard with KPI, chart, heatmap, and demographic panels.
- Four pricing tiers: Free, Standard, Premium, Lifetime.
- Free-first AI stack: Gemini, Groq, DeepSeek overflow, Edge TTS, Pollinations, Upstash cache.
- Offline-first repository pattern with sync queue foundations.
- Premium dark design system: gold `#D4AF37` on obsidian `#0B0C10`.

## Tech Stack

| Layer | Technology |
| --- | --- |
| Frontend | Flutter 3.24+, Dart 3.4+, Android only Phase 0-2 |
| State | Riverpod 3.x patterns, generated providers, legacy StateNotifier where practical |
| Routing | go_router 17.x with route guards and shell tabs |
| Backend | Supabase Auth, DB, Storage, Realtime plus Fastify API |
| AI | Gemini 2.0 Flash, Groq Llama/Whisper, DeepSeek overflow, Edge TTS, Pollinations |
| Cache | Upstash Redis with in-memory fallback for tests/local |
| Codegen | freezed, json_serializable, build_runner |
| Testing | flutter_test, mocktail, http_mock_adapter, golden_toolkit, integration_test |
| CI/CD | GitHub Actions lint, test, coverage, Android build, release |
| Monitoring | Sentry and Firebase Crashlytics deferred to Phase 1.5 |

## Getting Started

### Prerequisites

- Flutter 3.24 or newer.
- Dart 3.4 or newer.
- Android SDK and one Android emulator/device.
- Java 17.
- Git.

### Install

```powershell
cd "D:\Project APP Mobile Android\shorts-ai"
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Environment

```powershell
Copy-Item .env.example .env.local
```

Fill only local development keys in `.env.local`. Never commit local secrets.

Required or supported keys:

| Provider | Variables | Link |
| --- | --- | --- |
| Supabase | `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY` | <https://supabase.com/dashboard> |
| Gemini | `GEMINI_API_KEY` | <https://aistudio.google.com/app/apikey> |
| Groq | `GROQ_API_KEY` | <https://console.groq.com/keys> |
| Upstash Redis | `UPSTASH_REDIS_REST_URL`, `UPSTASH_REDIS_REST_TOKEN` | <https://console.upstash.com/redis> |
| DeepSeek | `DEEPSEEK_API_KEY` | <https://platform.deepseek.com/api_keys> |
| Pollinations | none for Phase 0 mock/free path | <https://pollinations.ai> |

### Run

```powershell
flutter devices
flutter run -d <android-emulator-id>
```

## Project Structure

```text
shorts-ai/
|-- lib/
|   |-- core/            # env, logger, network, AI router, theme, utilities
|   |-- features/        # auth, home, editor, subtitle, pricing, profile, etc.
|   |-- shared/          # widgets, models, repositories, services
|   |-- routing/         # go_router config and route constants
|   |-- app.dart
|-- test/                # unit, widget, golden, performance, helpers
|-- integration_test/    # end-to-end flows for Android emulator runs
|-- tool/                # coverage gate and generated coverage helper
|-- docs/                # extended architecture, release, DB, tier docs
|-- .github/             # GitHub Actions, templates, CODEOWNERS
|-- supabase/            # migrations and RLS policies
|-- apps/                # legacy/workspace package area, not canonical mobile app
```

## Development Commands

| Command | Purpose |
| --- | --- |
| `flutter pub get` | Install Dart and Flutter dependencies. |
| `dart run build_runner build --delete-conflicting-outputs` | Regenerate freezed/json/riverpod outputs. |
| `dart format lib test integration_test tool` | Format changed Dart sources. |
| `flutter analyze --fatal-infos --fatal-warnings` | Static analysis gate used by CI. |
| `flutter test` | Default test suite, excluding golden/perf tags by default. |
| `flutter test --coverage --reporter expanded` | Generate coverage/lcov.info. |
| `dart tool/coverage_check.dart --min=70 --file=coverage/lcov.info` | Enforce coverage gate. |
| `flutter test test/golden --run-skipped` | Run golden checks. |
| `flutter test --update-goldens test/golden --run-skipped` | Regenerate golden baselines after intentional UI changes. |
| `flutter build apk --debug --target-platform android-arm64` | Build debug APK artifact. |

## Documentation

- [Contributing](CONTRIBUTING.md)
- [Architecture](ARCHITECTURE.md)
- [API Reference](API_REFERENCE.md)
- [Deployment](DEPLOYMENT.md)
- [Security](SECURITY.md)
- [Release Process](docs/RELEASE_PROCESS.md)
- [AI Provider Strategy](docs/AI_PROVIDER_STRATEGY.md)
- [Database Schema](docs/DATABASE_SCHEMA.md)
- [Tier Feature Matrix](docs/TIER_FEATURE_MATRIX.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a PR. Minimum local gate: format, analyze, tests, and coverage check.

## License

AutoShort is proprietary software. See [LICENSE](LICENSE).

## Acknowledgments

Created by Devi Purnomo. Thanks to the free-tier providers that make the Phase 0 stack realistic: Google AI, Groq, Microsoft Edge TTS, Pollinations.ai, Upstash, and Supabase.

Support: [purnomodevi606@gmail.com](mailto:purnomodevi606@gmail.com). Brand domain target: <https://autoshort.id> in Phase 1.5.
