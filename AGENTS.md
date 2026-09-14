# Agent guide — Aafiatak Flutter v2.1 (Burgundy Monochrome)

## Approved baseline

| Area | Decision |
|---|---|
| Product | Aafiatak Patient mobile application |
| Visual Prototype | `Aafiatak_High_Fidelity_Prototype_v3.0` (read-only reference) |
| Architecture | feature-first with explicit `app/`, `design_system/`, `features/` boundaries |
| Current phase | frontend UI + feature-local mock data; no real backend integration |
| SDK baseline | Flutter >=3.24.0, Dart >=3.0.0 <4.0.0 |
| State / DI | Pure Flutter (`StatefulWidget`, `ValueNotifier`) — zero external state libraries |
| Routing | `go_router` |
| Theme | Aafiatak Material 3, light only, Burgundy Monochrome palette |
| Palette | `brand = #800020`, `canvas = #E5E5E5`, `surface = #FFFFFF`, `surfaceContainer = #EFEFEF`, `textPrimary = #1A1A1A`, `textSecondary = #6E6E6E`, `outline = #E5E5E5`, `primaryContainer = #F7E9EC` |
| Locale | Arabic (`ar`), RTL-first |
| Design System | `lib/src/design_system/` (9 core primitives + 7 domain patterns) |
| App Shell | `lib/src/app/patient_shell.dart` (Centered 430px max-width, app bars, bottom nav, bottom action) |

## Product invariants that affect code

- Human-user authentication is passwordless phone + WhatsApp OTP.
- Do not create email/password, social-login, SMS-authentication, or Forgot Password flows.
- OTP length/expiry/resend/cooldown remain configuration-driven until approved.
- Do not invent payment-provider specifics, backend technology, reminder timing, or ReservationHold duration.
- `ReservationHold`, `Appointment`, `PaymentIntent`, `VisitInstance`, and `QueueEntry` are separate lifecycles.
- `PAY_AT_FACILITY` must not create a PaymentIntent.
- Patient does not self-check-in or self-reschedule.
- Arrival windows are not exact doctor-entry promises.
- Use directional layout APIs (`start`/`end`) for RTL safety.
- Isolate phone numbers, OTPs, references, and similar tokens as LTR when required.

## Feature ownership

Product presentation work goes under `features/<feature>/`. During the UI/mock phase use only the layers actually needed:

```text
features/<feature>/
├── presentation/
│   ├── screens/
│   └── widgets/
└── data/
    └── mock/               # deterministic feature-local fixtures
```

Do not create empty repository/domain/service layers merely for symmetry.

## Design System and Domain Patterns

Import the foundation with:

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

Do not recreate a Design System primitive inside a feature.

### 9 Core Design System Components
1. `AafiatakButton` (variants: primary, tonal, secondary, destructive, text; block & compact)
2. `AafiatakTextField` (input shell with hint, icons, error/helper text)
3. `AafiatakCard` (surface container with elevation & tap handler)
4. `AafiatakInfoRows` (key-value summary rows with LTR isolation support)
5. `AafiatakBadge` (status pill with 7px dot bullet and feedback tones)
6. `AafiatakNotice` (contextual banner with feedback tones)
7. `AafiatakStatusBlock` (status card with 48x48 icon chip, tag, title, and copy)
8. `AafiatakSectionHeading` (section title with optional action/badge)
9. `AafiatakEmptyState` (empty state with 48x48 icon, title, copy, action button)

### 7 Domain Patterns (`design_system/patterns/`)
1. `DoctorCard` (`doctor/doctor_card.dart`)
2. `ServiceCard` (`service/service_card.dart`)
3. `FacilitySummary` (`facility/facility_summary.dart`)
4. `AppointmentSummary` (`appointment/appointment_summary.dart`)
5. `ReservationHoldBanner` (`booking/reservation_hold_banner.dart`)
6. `ArrivalWindowCard` (`booking/arrival_window_card.dart`)
7. `PolicyCard` (`booking/policy_card.dart`)

Domain Patterns are reusable visual compositions with product meaning. They:
- are composed from approved Aafiatak primitives;
- receive data/state/actions through explicit inputs;
- do not call APIs, repositories, or navigation directly;
- do not own business eligibility or lifecycle truth;
- have exactly one implementation owner when shared between developers;
- must not be duplicated under alternate names by another branch.

## Routing

Routing is composed under `src/app/routing/`. Do not introduce a global `NavigatorState`, global `BuildContext`, or navigate from repositories/services/Domain Patterns.

## Verification gate

Before a PR is considered ready:

```bash
flutter pub get
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

Never claim a Flutter CLI gate passed unless it actually ran.
