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

The project has no Flutter test suite and no Python QA scripts. Verification
uses Flutter and Dart tools directly.

Arabic application strings are written directly in Dart. There is no `l10n/`
directory, ARB file, or generated app-localization layer. The
`flutter_localizations` SDK dependency remains for Arabic Material and RTL
framework behavior.

No custom font asset is bundled. The app uses the device's Arabic-capable
system font.
