# Aafiatak Design System

This university Flutter UI project uses a small Material 3 design system for
Arabic RTL phone screens. The Burgundy Monochrome visual reference is
`Aafiatak_High_Fidelity_Prototype_v3.0/`.

## Layers

1. Flutter Material widgets provide controls and interaction behavior.
2. `ThemeData` applies Aafiatak colors, type scale, radii, and component styles.
3. Nine small Aafiatak components reduce repeated UI code.
4. Seven domain patterns compose those pieces for patient screens.

Import the public API with:

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

## Core Components

- `AafiatakButton`
- `AafiatakTextField`
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
