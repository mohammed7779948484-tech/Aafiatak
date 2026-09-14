# Aafiatak Flutter Design System — Foundation v2.1 (Burgundy Monochrome)

## Scope

This module implements the approved visual foundations, Material 3 theme, 9 domain-neutral primitives, and 7 domain patterns derived directly from the High-Fidelity Prototype (`Aafiatak_High_Fidelity_Prototype_v3.0`).

```text
Flutter / Material 3
        ↓
foundations/         # Colors, Spacing, Radii, Typography
        ↓
theme/               # Material 3 Theme mapping
        ↓
components/          # 9 Core primitives
        ↓
patterns/            # 7 Domain patterns
        ↓
features / shell     # Patient shell & feature screens
```

## Public Import

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

## Foundation Groups

- `AafiatakColors` — Burgundy monochrome tokens (`#800020`, `#FFFFFF`, `#E5E5E5`, `#EFEFEF`, `#F7E9EC`, `#1A1A1A`, `#6E6E6E`) and feedback tones (`success`, `warning`, `error`, `info`, `neutral`, `hold`).
- `AafiatakTypography` — Arabic scale (Display, H1, H2, H3, Body, BodySmall, Caption, Button) with system font fallbacks.
- `AafiatakSpacing` — Spacing scale (`0, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64`) with t-shirt and numeric aliases.
- `AafiatakRadii` — Corner radii (`8, 12, 16, 24, 999`) with t-shirt and numeric aliases.

## 9 Core Primitives

- `AafiatakButton`
- `AafiatakTextField`
- `AafiatakCard`
- `AafiatakInfoRows`
- `AafiatakBadge`
- `AafiatakNotice`
- `AafiatakStatusBlock`
- `AafiatakSectionHeading`
- `AafiatakEmptyState`

## 7 Domain Patterns

- `DoctorCard`
- `ServiceCard`
- `FacilitySummary`
- `AppointmentSummary`
- `ReservationHoldBanner`
- `ArrivalWindowCard`
- `PolicyCard`

