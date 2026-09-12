# Agent guide — Aafiatak Flutter v1.3

## Approved baseline

| Area | Decision |
|---|---|
| Product | Aafiatak Patient mobile application |
| Architecture | feature-first with explicit `app/`, `design_system/`, `features/`, `shared/` boundaries |
| Current phase | frontend UI + feature-local mock data; no real backend integration |
| SDK baseline | Flutter >=3.47.0, Dart >=3.13.0 <4.0.0 |
| State / DI | Riverpod 3 |
| Routing | go_router |
| Theme | Aafiatak Material 3, light only |
| Locale | Arabic (`ar`), RTL-first, Flutter `gen-l10n` |
| Design System | `lib/src/design_system/` |

## Product invariants that affect code

- Human-user authentication is passwordless phone + WhatsApp OTP.
- Do not create email/password, social-login, SMS-authentication, or Forgot Password flows.
- OTP length/expiry/resend/cooldown remain configuration-driven until approved.
- Do not invent payment-provider specifics, backend technology, reminder timing, or ReservationHold duration.
- `ReservationHold`, `Appointment`, `PaymentIntent`, `VisitInstance`, and `QueueEntry` are separate lifecycles.
- `PAY_AT_FACILITY` must not create a PaymentIntent.
- Patient does not self-check-in or self-reschedule.
- Arrival windows are not exact doctor-entry promises.
- User-facing Arabic copy belongs in localization resources, not inline Dart literals.

## Feature ownership

Product presentation work goes under `features/<feature>/`. During the UI/mock phase use only the layers actually needed:

```text
features/<feature>/
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── view_models/        # Riverpod Notifier/AsyncNotifier when useful
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

The next team-owned layer is `design_system/patterns/`. Domain Patterns are reusable visual compositions with product meaning (for example `DoctorCard`, `AppointmentCard`, `ArrivalWindowCard`, `ReservationHoldBanner`, `PaymentStatusBlock`). They:

- are composed from approved Aafiatak primitives;
- receive data/state/actions through explicit inputs;
- do not call APIs, repositories, or navigation directly;
- do not own business eligibility or lifecycle truth;
- have exactly one implementation owner when shared between developers;
- must not be duplicated under alternate names by another branch.

Screen-specific widgets that are not reusable remain inside the owning feature rather than being promoted to Patterns.

## `shared/` rule

`shared/` is only for proven cross-feature, domain-neutral technical infrastructure that is not a Design System primitive and not app-shell code. Current approved module: `shared/media/`.

Never place auth/session state, booking/payment models, feature mock data, feature widgets, or a generic `utils/` grab bag in `shared/` for convenience.

## Localization

- Add/modify visible copy in `lib/l10n/app_ar.arb`.
- Run `flutter gen-l10n` after localization changes.
- Do not hard-code visible Arabic strings in production Dart.
- Use directional layout APIs (`start`/`end`) for RTL safety.
- Isolate phone numbers, OTPs, references, and similar tokens as LTR when required.

## Riverpod 3

Use current `Notifier`/`AsyncNotifier` patterns. Do not add `flutter_riverpod/legacy.dart`, `StateNotifierProvider`, or `ChangeNotifierProvider` for new code.

## Routing

Routing is composed under `src/app/routing/`. Do not introduce a global `NavigatorState`, global `BuildContext`, or navigate from repositories/services/Domain Patterns.

## Team Git rule

- stable baseline: `main`;
- integration branch: `develop`;
- small feature/pattern branches from `develop`;
- PR back to `develop`;
- one owner per shared Domain Pattern;
- prefer small dependency-first PRs over one giant developer branch.

## Verification gate

Before a PR is considered ready:

```bash
flutter pub get
flutter gen-l10n
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

Before freezing the team baseline, also run a real debug device/simulator build. Never claim a Flutter CLI gate passed unless it actually ran.
