# Aafiatak

Aafiatak is a university Flutter UI project for an Arabic patient application.
It uses local mock data and is intended for three students to build and explain
phone interfaces. It has no backend or production infrastructure.

## UI Baseline

- Flutter Material 3, light mode only
- Arabic locale and RTL-first layouts
- Burgundy Monochrome palette
- Bundled IBM Plex Sans Arabic typography at weights 400, 500, 600, and 700
- Native Material controls styled through `ThemeData`
- Ten shared UI components and seven patient-domain patterns
- Arabic strings written directly in Dart; no app gen-l10n or ARB layer
- `go_router` for navigation
- `StatefulWidget`, `setState`, or `ValueNotifier` for local demo state

The visual source of truth is
`Aafiatak_High_Fidelity_Prototype_v3.0/`. Its 430px browser frame is only a
prototype preview technique; the Flutter app uses the available phone width.

## Requirements

- Flutter `>=3.47.0`
- Dart `>=3.13.0 <4.0.0`

## Run

```bash
flutter pub get
flutter run
```

## Verify

```bash
dart format lib
flutter analyze
flutter build apk --debug
```

See `SETUP.md`, `DESIGN.md`, `architecture.md`,
`docs/design_system/README.md`, and `docs/ui_implementation_plan/README.md` for
the small set of project guides.
