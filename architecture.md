# Aafiatak Flutter Architecture v2.1 (Burgundy Monochrome)

## Current Goal

Provide a clean, focused, team-splittable frontend baseline for the 3-student university team, strictly aligned with the High-Fidelity Prototype (`Aafiatak_High_Fidelity_Prototype_v3.0`).

```text
lib/
├── main.dart
└── src/
    ├── app/                         # composition, routing, patient shell
    │   ├── patient_shell.dart       # PatientShell, AppBars, BottomNav, BottomAction
    │   └── routing/                 # GoRouter configuration
    ├── design_system/               # visual source of truth
    │   ├── foundations/             # colors, typography, spacing, radii
    │   ├── theme/                   # Material 3 light theme mapping
    │   ├── components/              # 9 core primitives
    │   └── patterns/                # 7 domain patterns
    └── features/                    # patient feature ownership
        └── starter/                 # QA showcase gallery
```

## UI/Mock Feature Shape

```text
features/<feature>/
├── presentation/
│   ├── screens/
│   └── widgets/
└── data/
    └── mock/                    # feature-local deterministic fixtures
```

Pure Flutter `StatefulWidget` / `ValueNotifier` is used where state is needed. Heavy state management abstractions (like Riverpod 3) and codegen have been removed.

## Dependency Direction

```text
app ───────────→ features + design_system
features ──────→ design_system
design_system ─→ Flutter / Material 3
```

Forbidden:
- `design_system` importing a feature;
- one feature importing another feature's private implementation;
- repositories/services using `BuildContext` or visual feedback APIs;
- global navigator/root `BuildContext` singletons.

## Design System & Domain Patterns

The Design System is organized into:
1. **Foundations**: Tokens for colors, radii, spacing, and typography.
2. **Theme**: Material 3 theme mapping with `CardThemeData`, `OutlineInputBorder`, component themes.
3. **Components (9)**: Domain-neutral primitives (`AafiatakButton`, `AafiatakTextField`, `AafiatakCard`, `AafiatakInfoRows`, `AafiatakBadge`, `AafiatakNotice`, `AafiatakStatusBlock`, `AafiatakSectionHeading`, `AafiatakEmptyState`).
4. **Patterns (7)**: Reusable domain compositions (`DoctorCard`, `ServiceCard`, `FacilitySummary`, `AppointmentSummary`, `ReservationHoldBanner`, `ArrivalWindowCard`, `PolicyCard`).

## Verification Gate

Before any branch or PR is merged:

```bash
flutter pub get
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

