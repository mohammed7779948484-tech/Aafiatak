# Aafiatak Flutter Starter — Team Baseline Candidate v1.3

This package is the audited Flutter starting point for the **Aafiatak Patient MVP**.
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

## What changed from v1.2

The full patient design-document chain was re-read against the Flutter starter.
The following gaps were closed before team handoff:

- added `AafiatakPrimaryActionBar`, required by transactional/form layouts;
- added `AafiatakListRow`, completing the documented Tier-A primitive set;
- rebuilt `AafiatakOtpInput` as a configuration-driven multi-cell presentation
  over one logical input, with paste/autofill and no hard-coded OTP length;
- expanded `AafiatakStatusBlock` to support optional supporting copy and next action;
- expanded `AafiatakPhoneField` without inventing country/normalization rules;
- externalized visible Arabic copy to Flutter localization resources;
- added explicit pre-team component-coverage and readiness audits.

## Design System import

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

Do not recreate a primitive inside a feature if the Design System already owns it.

## Domain Patterns

Domain Patterns are **intentionally not implemented in this baseline**. They are
the next team-owned layer and should be created from the approved High-Fidelity
screens using the existing components.

Examples to be assigned to one owner each include `DoctorCard`, `ServiceCard`,
`AppointmentCard`, `ArrivalWindowCard`, `ReservationHoldBanner`,
`PaymentStatusBlock`, `VisitStatusBlock`, `QueueStatusBlock`, and
`BookingSummary`.

## Required developer-machine gate

```bash
./scripts/verify_project.sh
```

This runs localization generation, static audits, formatting, `flutter analyze`,
and `flutter test`.

The delivery environment does not contain Flutter, so this archive deliberately
does **not** claim that those Flutter CLI gates passed here.

See:
- `docs/architecture/FINAL_REVIEW_v1.3.md`
- `docs/architecture/TEAM_READINESS_v1.3.md`
- `docs/design_system/COMPONENT_COVERAGE_AUDIT_v1.3.md`
- `docs/design_system/QA_REPORT.md`
