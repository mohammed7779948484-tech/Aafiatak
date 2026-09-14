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

The project does not bundle IBM Plex Sans Arabic. Flutter therefore uses the
device's Arabic-capable system font.

Use named button constructors such as `AafiatakButton.primary(...)` and
`AafiatakButton.secondary(...)`. Application strings remain directly in Arabic
Dart code; `flutter_localizations` supplies framework localization and RTL
without an app gen-l10n or ARB layer.

## Team Conventions

- Choose one of `AafiatakButton.primary`, `.tonal`, `.secondary`, `.text`, or
  `.destructive`; pass `onPressed: null` for a disabled button.
- Use `AafiatakSearchField` for discovery and `AafiatakTextField` for forms. Its
  optional `label` is displayed above the Material field.
- `AafiatakEmptyState` requires an icon, title, and message. Its action label
  and callback are both optional but must be supplied together.
- Use `PatientShell(showBrand: true)` for the home root header. For root section
  screens use `showBrand: false` with `title`; detail screens use `root: false`.
