# Aafiatak Design System

This university Flutter UI project uses a small Material 3 design system for
Arabic RTL phone screens. The Burgundy Monochrome visual reference is
`Aafiatak_High_Fidelity_Prototype_v3.0/`.

## Layers

1. Flutter Material widgets provide controls and interaction behavior.
2. `ThemeData` applies Aafiatak colors, type scale, radii, and component styles.
3. Ten small Aafiatak components reduce repeated UI code.
4. Seven domain patterns compose those pieces for patient screens.

Import the public API with:

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

Screens that use the shared patient scaffold also import it explicitly:

```dart
import 'package:aafiatak/src/app/patient_shell.dart';
```

## Core Components

- `AafiatakButton`
- `AafiatakTextField`
- `AafiatakSearchField`
- `AafiatakCard`
- `AafiatakInfoRows`
- `AafiatakBadge`
- `AafiatakNotice`
- `AafiatakStatusBlock`
- `AafiatakSectionHeading`
- `AafiatakEmptyState`

## Domain Patterns

- `DoctorCard`
- `ServiceCard`
- `FacilitySummary`
- `AppointmentSummary`
- `ReservationHoldBanner`
- `ArrivalWindowCard`
- `PolicyCard`

`AafiatakColors` keeps one canonical definition for each physical Burgundy
Monochrome value. `AafiatakTheme` explicitly maps those values to Material
roles without `ColorScheme.fromSeed`. The stronger `inputBoundary` is an
intentional WCAG 1.4.11 deviation from the lighter prototype field border.

IBM Plex Sans Arabic is bundled under `assets/fonts/` at weights 400, 500, 600,
and 700. The public typography roles are `display`, `h1`, `h2`, `h3`,
`bodyLarge`, `body`, `labelLarge`, `label`, `bodySmall`, and `caption`.

The application feedback tones are `primary`, `secondary`, `success`,
`warning`, `info`, and `hold`. There is no custom feedback `error` tone;
Material `ColorScheme.error*` remains available for validation and destructive
controls.

Use named button constructors such as `AafiatakButton.primary(...)` and
`AafiatakButton.secondary(...)`. Application strings remain directly in Arabic
Dart code; `flutter_localizations` supplies framework localization and RTL
without an app gen-l10n or ARB layer.

## Team Conventions

- Choose one of `AafiatakButton.primary`, `.tonal`, `.secondary`, `.text`, or
  `.destructive`; pass `onPressed: null` for a disabled button.
- Pass an explicit `AafiatakFeedbackTone` to every `AafiatakBadge`.
- Use `AafiatakSearchField` for discovery and `AafiatakTextField` for forms. Its
  optional `label` is displayed above the Material field.
- `AafiatakEmptyState` requires an icon, title, and message. Its action label
  and callback are both optional but must be supplied together.
- Use `PatientShell.root` with an empty title for the branded home header, and
  pass a title for other root sections. Use `PatientShell.detail` for internal
  screens.
