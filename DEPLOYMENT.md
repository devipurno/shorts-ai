# Deployment

## Pre-Deployment Checklist

- All GitHub Actions checks are green.
- `flutter test --coverage` passes locally.
- Coverage is at least 70 percent.
- `pubspec.yaml` version has been bumped.
- `CHANGELOG.md` is updated manually or by release automation.
- Android signing secrets exist in GitHub Actions.
- No `.env.local`, keystore, or local signing files are staged.

## Release Steps

```bash
# Example bump: 0.1.0+1 -> 0.1.1+2
git checkout main
git pull
git checkout -b chore/release-0.1.1
# edit pubspec.yaml and CHANGELOG.md if needed
git commit -am "chore(release): bump version to 0.1.1"
git tag v0.1.1
git push origin main --tags
```

The release workflow validates that tag `v0.1.1` matches `pubspec.yaml` version `0.1.1+N`, builds release APK splits and AAB, generates notes with git-cliff, and creates a GitHub Release.

## Beta Distribution

| Phase | Channel |
| --- | --- |
| Phase 0-1 | Firebase App Distribution for Android testers. |
| Phase 2 | Google Play Internal Testing track. |
| iOS | Deferred; TestFlight is not applicable in Phase 0-2. |

## Production Release

- Google Play production release starts after beta validation.
- Lifetime offer is limited to the first 100 slots.
- AAB upload is manual in Phase 0-1 through Play Console.
- fastlane automation is deferred to Phase 2+.

## Rollback Strategy

1. Stop staged rollout in Play Console.
2. Create hotfix branch from last known good tag.
3. Revert or patch the offending commit.
4. Bump patch version and tag a new release.
5. Promote the fixed AAB after smoke testing.

## Environment Matrix

| Environment | Config source | Notes |
| --- | --- | --- |
| Local dev | `.env.local` | Developer-owned, ignored by git. |
| Staging | `.env.staging` / GitHub secrets | Phase 1.5. |
| Production | GitHub secrets / Doppler | Doppler planned for Phase 1.5+. |

## Domain and DNS

| Phase | Domain |
| --- | --- |
| Phase 0-1 | `autoshort.id` bootstrap. |
| Phase 1.5+ | `autoshort.id` brand domain. |

Cloudflare Email Routing aliases: `hello@`, `support@`, `noreply@`, `devi@`, `admin@`.

## Android Signing

See [docs/CI_CD_SETUP.md](docs/CI_CD_SETUP.md) for keystore generation, GitHub secrets, and local `android/key.properties` setup.
