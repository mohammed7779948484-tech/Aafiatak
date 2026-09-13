# Aafiatak Flutter Starter — Team Baseline Candidate v1.3

This repository is the audited Flutter starting point for the **Aafiatak Patient MVP**.
It aligns the application shell and domain-neutral Design System with the approved
21-screen / 142-state High-Fidelity documentation before the team starts building
feature screens and Domain Patterns.

## Baseline

- Flutter `>=3.47.0`
- Dart `>=3.13.0 <4.0.0`
- Material 3
- Riverpod 3 (`flutter_riverpod ^3.4.3`)
- `go_router ^18.0.1`
- Arabic-first, RTL
- Flutter `gen-l10n` localization resources
- feature-first UI/mock-data phase
- phone-only current product target

## Active visual system

The latest High-Fidelity handoff updates the visual-token direction to **Burgundy Monochrome v2.1** while keeping the existing Flutter architecture and public component APIs.

Primary anchors are Burgundy `#800020`, dark Burgundy `#5C0016`, Burgundy tint `#F7E9EC`, grey canvas `#E5E5E5`, white surfaces and charcoal `#1A1A1A`. Status meaning is not encoded by hue alone; iconography, copy and semantics remain mandatory.

The migration is documented in `docs/design_system/DESIGN_TOKEN_MIGRATION_v2.1.md`.

## Source structure

```text
lib/
├── main.dart
├── l10n/
│   └── app_ar.arb             # generated Dart goes to l10n/generated/
└── src/
    ├── app/                   # app composition + routing
    ├── design_system/         # foundations + theme + domain-neutral components
    ├── features/              # team-owned patient features
    └── shared/
        └── media/             # approved cross-feature media infrastructure
```

`core/` is intentionally absent. `design_system/` is a first-class subsystem.

## Foundation readiness

The documentation-to-code review closed the known Tier-A primitive gaps before team handoff:

- `AafiatakPrimaryActionBar` for transactional/form layouts;
- `AafiatakListRow` for domain-neutral repeated rows;
- configuration-driven `AafiatakOtpInput` over one logical field;
- `AafiatakStatusBlock` with optional supporting copy and next action;
- `AafiatakPhoneField` without invented phone policy;
- Flutter localization resources instead of visible hard-coded Arabic copy.

The subsequent Burgundy Monochrome v2.1 migration changes visual tokens/theme mapping, not the architecture or Domain Pattern boundary.

## Design System import

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

Do not recreate a primitive inside a feature if the Design System already owns it.

## Domain Patterns

Domain Patterns are **intentionally not implemented in the baseline**. They are the next team-owned layer and should be created from the approved High-Fidelity screens using the existing components.

Examples assigned to one owner each include `DoctorCard`, `ServiceCard`, `AppointmentCard`, `ArrivalWindowCard`, `ReservationHoldBanner`, `PaymentStatusBlock`, `VisitStatusBlock`, `QueueStatusBlock`, and `BookingSummary`.

## Required validation gate

After any foundation/theme migration, run:

```bash
flutter pub get
flutter gen-l10n
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

Then perform a real phone smoke test before freezing/merging the baseline.

See:
- `DESIGN.md`
- `docs/design_system/DESIGN_TOKEN_MIGRATION_v2.1.md`
- `docs/architecture/TEAM_READINESS_v1.3.md`
- `docs/design_system/COMPONENT_USAGE_CONTRACTS_v1.3.md`
