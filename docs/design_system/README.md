# Aafiatak Flutter Design System — Foundation v1.3

## Scope

This module implements the approved visual foundations, Material 3 theme, and domain-neutral primitives required before the team builds Domain Patterns and Patient screens.

```text
Flutter / Material 3
        ↓
foundations/
        ↓
theme/
        ↓
components/
        ↓
Domain Patterns   # next team-owned layer
        ↓
feature screens
```

## Public import

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

## Foundation groups

- `AafiatakPalette`
- `AafiatakColors`
- `AafiatakTypography`
- `AafiatakSpacing`
- `AafiatakRadii`
- `AafiatakBorders`
- `AafiatakElevation`
- `AafiatakMotion`
- `AafiatakSizes`
- `AafiatakIcons`

## Theme

- explicit Material 3 `ColorScheme`;
- `AafiatakSemanticColors` ThemeExtension;
- `AafiatakTheme.light` and component themes;
- no dark theme in the current approved scope.

## Component boundary

Primitives are domain-neutral and may be used by features or Domain Patterns. Product-specific compositions (Doctor, Appointment, Payment, ReservationHold, Visit/Queue, etc.) are not primitives and are intentionally deferred to team-owned Patterns.

Visible strings are localization inputs/ARB resources rather than hard-coded reusable Arabic copy.

Cross-feature non-visual infrastructure is documented separately in `docs/architecture/SHARED_GUIDE.md`.

## Team usage contract

See `COMPONENT_USAGE_CONTRACTS_v1.3.md` for per-component purpose, variants, states, token/RTL/text-scaling/accessibility rules, demo states and do/don’t guidance.
