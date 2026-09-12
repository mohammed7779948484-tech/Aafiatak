# Aafiatak Flutter starter setup v1.3

## 1. SDK baseline

Required baseline for this archive:

- Flutter `>=3.47.0`
- Dart `>=3.13.0 <4.0.0`

```bash
flutter --version
dart --version
```

The currently selected package line includes dependencies requiring Dart 3.12+
(e.g. Riverpod 3.4.x, go_router 18.x, cached_network_image 4.x). Standardize all
team members on the approved Flutter baseline before parallel work.

## 2. Localization

Visible Arabic copy is stored in `lib/l10n/app_ar.arb`.

```bash
flutter pub get
flutter gen-l10n
```

Generated files are written to `lib/l10n/generated/` and are git-ignored. English
can be added later by adding an ARB bundle without changing screen hierarchy.

## 3. Native shells

The supplied starter source did not include `android/`, `ios/`, or `.metadata`.
Do **not** invent package identifiers.

Before device builds, approve the Android application ID and iOS bundle ID, then
generate/restore native shells consistently for the repository.

## 4. Typography

The approved visual system targets IBM Plex Sans Arabic / IBM Plex Sans. Font
binaries are intentionally not bundled. Add the approved licensed assets on the
development repository and run real-device typography QA.

## 5. Verification

```bash
./scripts/verify_project.sh
```

Equivalent manual commands:

```bash
flutter --version
flutter pub get
flutter gen-l10n
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```
