# Team readiness gate — Aafiatak Flutter v1.3

## Current verdict

The source/code architecture and domain-neutral Design System are ready to become the team baseline. Before three developers branch in parallel, complete the following repository-wide gates once and commit the result centrally.

## Gate 1 — standardize SDK

All developers use the same approved baseline:

- Flutter >=3.47.0
- Dart >=3.13.0 <4.0.0

Do not mix the current 3.41/Dart 3.11 workstation line with this dependency set.

## Gate 2 — native application identity

Approve the Android application ID and iOS bundle ID, then generate/restore `android/`, `ios/`, and Flutter metadata once in the canonical repository. Do not let each developer independently generate different identifiers/settings.

## Gate 3 — approved fonts

Add properly licensed IBM Plex Sans Arabic / IBM Plex Sans assets and wire them into `pubspec.yaml`, then visually verify Arabic typography on real Flutter rendering. Font binaries are intentionally absent from this delivery.

## Gate 4 — full Flutter verification

From project root:

```bash
flutter --version
flutter clean
flutter pub get
flutter gen-l10n
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
```

On macOS, also validate the iOS simulator build when the iOS shell is present.

Required result: no dependency-resolution failure, no analyzer error/warning that violates the project lint gate, all tests pass, and a real debug build succeeds.

## Gate 5 — runtime Design System smoke review

Run on at least one Android phone/emulator (and iOS simulator when available) and visually check:

- Arabic RTL and directional navigation;
- IBM Plex Arabic typography once installed;
- text scaling/long Arabic strings;
- OTP paste/autofill/caller-configured length;
- keyboard + bottom action-bar interaction;
- status/banner/dialog/sheet behavior;
- loading/error/empty states;
- touch targets and overflow on phone sizes.

## Freeze / Git strategy

After all gates pass:

1. commit the baseline to `main`;
2. tag it (example: `ui-baseline-v1.3`);
3. create/use `develop` as integration branch;
4. each developer branches from current `develop`;
5. shared Domain Patterns get one named owner;
6. merge small dependency-first PRs back into `develop`.

Only after this freeze should the 21-screen / Domain-Pattern ownership plan be executed in parallel.
