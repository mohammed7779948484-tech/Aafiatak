# Aafiatak Flutter Starter Setup v2.1 (Burgundy Monochrome)

## 1. SDK Baseline

Required baseline for this repository:

- Flutter `>=3.24.0`
- Dart `>=3.0.0 <4.0.0`

Verify your environment:

```bash
flutter --version
dart --version
```

## 2. Dependencies

Install required dependencies:

```bash
flutter pub get
```

## 3. Typography Contract

The approved visual system targets IBM Plex Sans Arabic / IBM Plex Sans with system fallbacks to Noto Sans Arabic and Noto Sans.

```dart
AafiatakTypography.fontFamily = 'IBM Plex Sans';
AafiatakTypography.fontFamilyFallback = ['Noto Sans Arabic', 'Noto Sans'];
```

## 4. Verification Gate

Run all verification scripts and tests before starting feature development:

```bash
./scripts/verify_project.sh
```

Or execute commands individually:

```bash
flutter pub get
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

