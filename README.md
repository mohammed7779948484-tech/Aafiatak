# Aafiatak Flutter Starter — Design System v2.1 (Burgundy Monochrome)

This repository provides the refactored, production-quality Flutter Design System for the **Aafiatak Patient Mobile App**, perfectly aligned with the Burgundy Monochrome High-Fidelity Prototype (`Aafiatak_High_Fidelity_Prototype_v3.0`).

## Baseline

- Flutter `>=3.24.0`
- Dart `>=3.0.0 <4.0.0`
- Material 3 (Burgundy Monochrome light theme)
- `go_router` routing
- Arabic-only (`ar`), RTL-first
- Pure Flutter state (`StatefulWidget`, `ValueNotifier`)
- Centered 430px max-width patient phone container
- 9 Core Primitives & 7 Domain Patterns

## Source Structure

```text
lib/
├── main.dart
└── src/
    ├── app/                         # App shell, root routing, patient phone container
    │   ├── aafiatak_app.dart        # MaterialApp entry point
    │   ├── patient_shell.dart       # Centered phone canvas, app bars, bottom nav
    │   └── routing/                 # GoRouter configuration
    ├── design_system/               # Visual source of truth
    │   ├── foundations/             # Colors, spacing, radii, typography
    │   ├── theme/                   # Material 3 theme mapping
    │   ├── components/              # 9 core primitives
    │   └── patterns/                # 7 domain patterns
    └── features/
        └── starter/                 # Interactive QA gallery showcase
```

## What Was Refactored from v1.3

1. **Eliminated Over-Engineering**:
   - Removed unused/heavy dependencies: `flutter_riverpod`, `hugeicons`, `cached_network_image`, `flutter_svg`, `skeletonizer`, `intl`.
   - Removed `shared/media/` and legacy Mineral Bloom palette (`#4A315D`, `#3F786E`, `#A85A41`).
   - Removed complex `gen-l10n` build codegen overhead in favor of direct, clean Arabic typography and strings.

2. **Adopted Burgundy Monochrome Palette**:
   - Brand: Burgundy `#800020`
   - Primary Container: Light Burgundy `#F7E9EC`
   - Canvas / Background: Cool Grey `#E5E5E5`
   - Surface: Clean White `#FFFFFF`
   - Surface Container: Soft Off-White `#EFEFEF`
   - Text Primary: `#1A1A1A`, Text Secondary: `#6E6E6E`
   - Outline / Border: `#E5E5E5`

3. **Implemented 9 Core Components & 7 Domain Patterns**:
   - 9 Primitives: `AafiatakButton`, `AafiatakTextField`, `AafiatakCard`, `AafiatakInfoRows`, `AafiatakBadge`, `AafiatakNotice`, `AafiatakStatusBlock`, `AafiatakSectionHeading`, `AafiatakEmptyState`.
   - 7 Domain Patterns: `DoctorCard`, `ServiceCard`, `FacilitySummary`, `AppointmentSummary`, `ReservationHoldBanner`, `ArrivalWindowCard`, `PolicyCard`.

4. **Added Patient Shell**:
   - Centered 430px max-width viewport with `PatientShell`.
   - `AafiatakRootAppBar` with brand mark and notification bell.
   - `AafiatakDetailAppBar` with screen ID kicker and RTL back navigation.
   - `AafiatakBottomNav` with active Burgundy pill containers.
   - `AafiatakBottomAction` for sticky actions.

## Design System Import

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

## Verification Gate

Run the complete verification suite before merging:

```bash
flutter pub get
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

