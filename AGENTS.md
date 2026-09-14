# Aafiatak Contributor Guide

## Scope

Aafiatak is a university Flutter UI project for three students. It uses Arabic
RTL screens, local mock data, light Material 3, and no backend or production
infrastructure. Prefer the solution that is easiest to build, understand,
explain, and maintain.

## Baseline

- Flutter `>=3.47.0`
- Dart `>=3.13.0 <4.0.0`
- `go_router` for routing
- `StatefulWidget`, `setState`, and occasional `ValueNotifier` for UI state
- Burgundy Monochrome colors from `lib/src/design_system/`
- 10 shared components and 7 shared domain patterns
- High-Fidelity reference: `Aafiatak_High_Fidelity_Prototype_v3.0/`

Treat the High-Fidelity package as read-only. Translate its visual design into
Flutter; do not copy browser-only implementation details such as a 430px phone
simulation constraint.

## Material First

Use Flutter Material controls and style them through `ThemeData`. Keep Aafiatak
wrappers thin. Do not rebuild buttons, text fields, cards, app bars, icon
buttons, or navigation bars from `Container`, `Material`, and `InkWell`.

Use the named `AafiatakButton` constructors for shared button consistency and
`AafiatakSearchField` for repeated discovery/search inputs.

Normal layout widgets such as `Row`, `Column`, `Padding`, `Expanded`, `Wrap`,
and `Stack` are appropriate for compositions.

## Product Rules

- Authentication is passwordless phone plus WhatsApp OTP.
- Do not add email/password, social login, SMS authentication, or Forgot Password.
- OTP and reservation-hold timing remain configuration-driven.
- `ReservationHold`, `Appointment`, `PaymentIntent`, `VisitInstance`, and
  `QueueEntry` are separate lifecycles.
- `PAY_AT_FACILITY` must not create a `PaymentIntent`.
- Patients do not self-check-in or self-reschedule.
- Arrival windows are not exact doctor-entry promises.
- Use directional layout APIs where direction matters.
- Isolate phone numbers, OTPs, references, timestamps, and identifiers as LTR
  only when needed.

## Structure

Features may contain `screens/`, `widgets/`, and `mock_data.dart`. Add only what
the feature needs. Do not create empty domain/data/repository/service layers.

Write application strings directly in Arabic Dart code. Keep
`flutter_localizations` for framework RTL behavior, but do not add app gen-l10n,
ARB files, or an `l10n/` directory.

Import the shared design system with:

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

## Verification

```bash
flutter pub get
dart format lib
flutter analyze
flutter build apk --debug
```

The project intentionally has no Flutter tests and no Python audit tooling.
