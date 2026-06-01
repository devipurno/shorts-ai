# AutoShort CI/CD Setup

## Overview

AutoShort uses GitHub Actions for Android-only CI/CD on free Linux runners. The pipeline runs formatting, static analysis, unit/widget tests, coverage gate, debug APK builds, signed release APK/AAB builds, nightly Android integration tests, and golden regression checks.

## Workflow Files

- `.github/workflows/ci.yml`: pull request and main branch CI. Jobs: lint, test with coverage, debug APK, signed release artifacts on `main` when signing secrets exist.
- `.github/workflows/release.yml`: semver tag release flow. It validates the tag, builds signed Android artifacts, generates changelog notes with `git-cliff`, and creates a GitHub Release.
- `.github/workflows/nightly.yml`: scheduled Android emulator integration tests and golden regression checks at 23:00 Asia/Bangkok.
- `.github/workflows/pr_size.yml`: non-blocking PR size labels and warning comments for very large diffs.

## Required GitHub Secrets

Add these in GitHub: Settings -> Secrets and variables -> Actions.

| Secret | Required For | Rationale |
| --- | --- | --- |
| `ANDROID_KEYSTORE_BASE64` | Release APK/AAB signing | Encoded upload keystore, never committed. |
| `ANDROID_KEYSTORE_PASSWORD` | Release APK/AAB signing | Unlocks the keystore file. |
| `ANDROID_KEY_ALIAS` | Release APK/AAB signing | Selects the upload signing key alias, usually `upload`. |
| `ANDROID_KEY_PASSWORD` | Release APK/AAB signing | Unlocks the upload key entry. |
| `CODECOV_TOKEN` | Coverage upload | Optional for public repos, usually required for private repos. |
| `SLACK_WEBHOOK_URL` | Build notifications | Optional future Phase 1.5 integration. |

## Generate Android Upload Keystore

Run this once on a secure local machine. Keep the `.jks`, passwords, and generated base64 file private.

```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

Create a base64 payload for the GitHub secret:

```bash
openssl base64 -in upload-keystore.jks | tr -d '\n' > keystore.b64.txt
```

On Windows PowerShell, you can use:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks")) | Set-Content keystore.b64.txt -NoNewline
```

## Local Signing File

For local release builds, create `android/key.properties`. This file is ignored by git.

```properties
storePassword=your-keystore-password
keyPassword=your-key-password
keyAlias=upload
storeFile=upload-keystore.jks
```

Place `upload-keystore.jks` in `android/upload-keystore.jks`. The Gradle config uses this signing config when `android/key.properties` exists and falls back to debug signing only for local unsigned release experiments.

## Local CI Commands

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze --fatal-infos --fatal-warnings
flutter test --coverage --reporter expanded
dart tool/coverage_check.dart --min=70 --file=coverage/lcov.info
flutter build apk --debug --target-platform android-arm64
```

## Golden Tests

Golden tests are skipped by default through `dart_test.yaml`. Run them explicitly when UI changes intentionally:

```powershell
flutter test test/golden --run-skipped
flutter test --update-goldens test/golden --run-skipped
```

Nightly CI runs the golden check and uploads diff artifacts when a regression occurs.

## Integration Tests

Integration tests require an Android emulator. Nightly CI uses `reactivecircus/android-emulator-runner@v2` with API level 34, `google_apis`, and `x86_64`.

Local example:

```powershell
flutter devices
flutter test integration_test/flows -d <android-emulator-id> --reporter expanded
```

## Coverage Gate

The minimum line coverage is 70%. The gate is enforced in CI by:

```bash
dart tool/coverage_check.dart --min=70 --file=coverage/lcov.info
```

Task 26 last measured coverage: 72.20%.

## Release Flow

1. Ensure `pubspec.yaml` version matches the intended tag without the `v` prefix, for example `0.1.0+1` for tag `v0.1.0`.
2. Push a semver tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

3. The release workflow builds signed APK splits and AAB, generates release notes, and publishes a GitHub Release.

Prerelease tags such as `v0.1.0-beta.1` are marked as prerelease automatically.

## Local `act` Usage (Optional)

Install [`act`](https://github.com/nektos/act), then dry-run selected jobs:

```bash
act pull_request -W .github/workflows/ci.yml -j lint
act workflow_dispatch -W .github/workflows/ci.yml -j test
```

Android builds under `act` can be slow and may need a larger runner image. Treat GitHub-hosted runners as the source of truth.

## Cache Strategy

- Flutter SDK cache: handled by `subosito/flutter-action`.
- Pub cache: `~/.pub-cache` keyed by `pubspec.lock`.
- Dart tool cache: `.dart_tool` keyed by `pubspec.lock`.
- Gradle cache: `~/.gradle/caches` and `~/.gradle/wrapper` keyed by Gradle files.
- Build runner outputs are regenerated for correctness.

Expected runtime: cold cache about 12 minutes; warm cache about 5 minutes for CI. Nightly emulator runs can take 20-35 minutes.

## Phase 2 Notes

- iOS builds are deferred because they require macOS runners or a self-hosted builder.
- Matrix testing across multiple Flutter versions is deferred until the beta stability window.
- Slack notifications are deferred until Phase 1.5.
