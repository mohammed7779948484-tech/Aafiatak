# Aafiatak Flutter Design System — Burgundy Monochrome v2.1

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

## Current visual direction

The active visual-token source is **Burgundy Monochrome v2.1** from the latest High-Fidelity handoff.

Core anchors:

- Burgundy `#800020`
- Burgundy dark `#5C0016`
- Burgundy tint `#F7E9EC`
- canvas `#E5E5E5`
- surface `#FFFFFF`
- ink `#1A1A1A`
- secondary text `#6E6E6E`

The system intentionally does not introduce separate green/yellow/red/blue status palettes. Status communication uses text, iconography, semantics and structure in addition to color.

The migration intentionally preserves Aafiatak's existing architecture and component APIs; the generator/scaffold code found beside the High-Fidelity tokens is not imported into the application.

See `DESIGN_TOKEN_MIGRATION_v2.1.md` for the migration record.

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
- no seed-generated accent leakage;
- no dark theme in the current approved scope.

## Typography

Canonical Flutter family key: `IBMPlexSansArabic`.

The approved font files are supplied/registered by the development team. Typography tokens consume the family key rather than referencing asset paths directly.

## Component boundary

Primitives are domain-neutral and may be used by features or Domain Patterns. Product-specific compositions (Doctor, Appointment, Payment, ReservationHold, Visit/Queue, etc.) are not primitives and remain intentionally deferred to team-owned Patterns.

Visible strings are localization inputs/ARB resources rather than hard-coded reusable Arabic copy.

Cross-feature non-visual infrastructure is documented separately in `docs/architecture/SHARED_GUIDE.md`.

## Team usage contract

See `COMPONENT_USAGE_CONTRACTS_v1.3.md` for per-component purpose, variants, states, token/RTL/text-scaling/accessibility rules, demo states and do/don't guidance.

Before merging any Design System token change, run the static audits and Flutter gates documented in `DESIGN_TOKEN_MIGRATION_v2.1.md`.
