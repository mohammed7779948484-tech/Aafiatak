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

No custom font asset is bundled. The app uses the device's Arabic-capable
system font.
