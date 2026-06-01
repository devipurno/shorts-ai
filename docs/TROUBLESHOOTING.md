# Troubleshooting

## Build Runner Conflicts

Symptom: generated files are stale or build_runner reports conflicting outputs.

```powershell
dart run build_runner build --delete-conflicting-outputs
```

## Supabase Connection Fails

Check `.env.local`:

```env
SUPABASE_URL=https://<project-ref>.supabase.co
SUPABASE_ANON_KEY=<public-key>
```

Set `USE_SUPABASE=false` to force mock repositories for local UI work.

## AI Quota Exhausted

Symptoms: hook generation or metadata generation returns a provider exhaustion error.

- Check `QuotaTracker` logs.
- Confirm provider API keys are configured.
- Wait for the Asia/Bangkok midnight reset.
- Use cached results where possible.

## Golden Tests Fail

If the UI changed intentionally:

```powershell
flutter test --update-goldens test/golden --run-skipped
```

If not intentional, inspect the diff artifacts and revert the UI regression.

## Android Emulator Issues

- Cold boot the emulator.
- Increase RAM and storage.
- Confirm Android SDK and system image are installed.
- Run `flutter doctor -v`.
- Use a physical device for release smoke tests when emulator graphics are unstable.

## Android Build Cannot Resolve FFmpeg Kit

`ffmpeg_kit_flutter_min` depends on `com.arthenica:ffmpeg-kit-min:6.0-2`, which may not resolve from Maven Central. The repo adds the Arthenica and Aliyun Maven repositories. If it still fails, verify network/DNS access or consider replacing the package in a future maintenance task.

## Flutter v1 Embedding Error

New Flutter versions may reject old plugin APIs. CI pins Flutter 3.24.0. If local Flutter is newer and `ffmpeg_kit_flutter_min` fails to compile, use the pinned SDK for release builds or replace the plugin.

## Coverage Gate Fails

```powershell
flutter test --coverage --reporter expanded
dart tool/coverage_check.dart --min=70 --file=coverage/lcov.info
```

Add targeted tests for changed modules instead of lowering the gate.

## GitHub Actions Release Skips Build

Release build on `main` skips when signing secrets are missing. Add:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

See [CI/CD setup](CI_CD_SETUP.md).
