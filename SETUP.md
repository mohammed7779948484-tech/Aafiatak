# Setup

## Requirements

- Flutter `>=3.47.0`
- Dart `>=3.13.0 <4.0.0`
- Android tooling for an APK build, or another Flutter-supported run target

## Commands

```bash
flutter pub get
flutter run
```

Before sharing a branch, run:

```bash
dart format lib
flutter analyze
flutter build apk --debug
```

The Flutter implementation has no test suite and does not require Python QA
scripts. Its verification workflow uses Flutter and Dart tools directly; any
scripts inside the read-only High-Fidelity package belong to that reference.

Arabic application strings are written directly in Dart. There is no `l10n/`
directory, ARB file, or generated app-localization layer. The
`flutter_localizations` SDK dependency remains for Arabic Material and RTL
framework behavior.

IBM Plex Sans Arabic is bundled in `assets/fonts/` and registered in
`pubspec.yaml` at weights 400, 500, 600, and 700. It requires no font package or
platform-specific setup.
