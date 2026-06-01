# Contributing to AutoShort

Welcome. AutoShort is a premium Android-first Flutter product, so contributions should keep the codebase understandable for future maintainers and safe for beta users.

## Code of Conduct

All contributors must follow [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Reporting Bugs

Use the GitHub bug report template in `.github/ISSUE_TEMPLATE/bug_report.md`. Include device, Android version, reproduction steps, logs, and screenshots if possible.

## Requesting Features

Use `.github/ISSUE_TEMPLATE/feature_request.md`. Describe the creator problem first, then propose the product behavior.

## Development Setup

```powershell
git clone <repo-url>
cd shorts-ai
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
```

Branch naming:

- `feat/<scope>-<short-desc>` for features.
- `fix/<scope>-<short-desc>` for bug fixes.
- `docs/<scope>-<short-desc>` for documentation.
- `chore/<scope>-<short-desc>` for maintenance.

## Branch Strategy

| Branch | Purpose |
| --- | --- |
| `main` | Protected release branch. Tags trigger release automation. |
| `develop` | Optional Phase 1.5 integration branch. |
| `feat/*` | Feature branches. |
| `fix/*` | Bug-fix branches. |
| `docs/*` | Documentation branches. |

## Commit Conventions

Use Conventional Commits:

```text
feat(editor): add split marker controls
fix(auth): handle expired Supabase refresh token
docs(api): document project endpoints
test(thumbnail): add CTR predictor regression test
ci(android): cache Gradle dependencies
```

Breaking changes use a footer:

```text
BREAKING CHANGE: project status enum renamed from ready to completed.
```

## Code Style

- Run `dart format`; there are no formatting exceptions.
- Run `flutter analyze --fatal-infos --fatal-warnings` before PR.
- Prefer composition over inheritance.
- Keep one public widget per file unless helpers are private and small.
- Use Riverpod generated providers where possible.
- Keep UI aligned with `AppColors`, `AppTypography`, `AppSpacing`, and `AppRadius`.
- Do not commit `.env.local`, `android/key.properties`, keystores, or generated secret payloads.

## Testing Requirements

| Change type | Required tests |
| --- | --- |
| New feature logic | Unit/provider tests. |
| New UI | Widget test and golden test when layout is stable. |
| E2E flow | Integration test under `integration_test/flows`. |
| Bug fix | Regression test that fails before the fix. |
| Public API change | Repository/service tests and API docs update. |

Coverage must remain at or above 70 percent.

## PR Process

1. Open PR using `.github/PULL_REQUEST_TEMPLATE.md`.
2. Confirm local format, analyze, tests, and coverage gate.
3. Attach screenshots for UI changes.
4. Wait for required checks: lint, test, and debug APK build.
5. Request at least one reviewer. Devi is the default CODEOWNER.
6. Use squash merge into `main` unless release management requires otherwise.

## Release Process

See [docs/RELEASE_PROCESS.md](docs/RELEASE_PROCESS.md).
