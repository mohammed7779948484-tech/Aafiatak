# Aafiatak Design System — Burgundy Monochrome v2.1

Approved current visual direction: **Burgundy Monochrome v2.1**.

This document supersedes the older Mineral Bloom visual-token section while keeping the same Flutter architecture and component boundaries.

## Location

```text
lib/src/design_system/
├── foundations/
├── theme/
└── components/
```

Domain Patterns remain the next team-owned layer; they are not part of this foundation migration.

## Material strategy

Material 3 supplies platform behavior and accessibility mechanics. Aafiatak owns semantic colors, typography, geometry, motion, and stable component APIs.

```text
Material primitive
→ Aafiatak theme/component theme
→ Aafiatak wrapper where a stable API is valuable
→ Domain Pattern
→ Feature screen
```

The Material `ColorScheme` is mapped explicitly. Do not use `ColorScheme.fromSeed` for the product theme because it can synthesize hues outside the approved monochrome system.

## Core visual tokens

### Color

- Primary Burgundy `#800020`
- Burgundy dark `#5C0016`
- Burgundy tint / primary container `#F7E9EC`
- Canvas `#E5E5E5`
- Surface `#FFFFFF`
- Surface low `#F7F7F7`
- Surface container `#EFEFEF`
- Surface highest `#D9D9D9`
- Ink / charcoal `#1A1A1A`
- Strong charcoal `#1F1F1F`
- Secondary text `#6E6E6E`
- Strong outline `#B5B5B5`

The current High-Fidelity direction deliberately avoids separate green/yellow/red/blue semantic color families. Status meaning must be communicated by **copy + iconography + structure**, with color as a supporting cue rather than the only cue.

### Spacing

Canonical scale:

```text
0, 2, 4, 8, 12, 16, 20, 24, 32, 48, 64
```

`40dp` remains a compatibility token for already-authored code but is not part of the canonical High-Fidelity scale for new work.

### Radii

```text
4, 8, 12, 16, 24, 28, 999
```

- standard cards: 16dp
- dialogs: 24dp
- search and bottom-sheet top geometry: 28dp
- pills/chips: full radius

### Motion

```text
80ms, 140ms, 220ms, 320ms
shimmer: 1350ms
```

Canonical standard curve is the exact `Cubic(0.2, 0, 0, 1)` token. Respect reduced-motion settings.

### Elevation

- e1 card shadow: `0 2 10 rgba(26,26,26,.055)`
- e2 overlay shadow: `0 14 34 rgba(26,26,26,.11)`
- brand emphasis shadow: `0 12 26 rgba(128,0,32,.20)`

Aafiatak remains surface-led rather than shadow-led. Interactive cards may use e1; static cards remain primarily border/surface driven.

## Typography

Canonical Flutter font-family key:

```text
IBMPlexSansArabic
```

Approved Arabic roles keep the established scale:

```text
32/40  w700
28/36  w700
24/32  w700
20/28  w600
18/30  w400
16/27  w400
16/24  w600
14/22  w600
14/23  w400
12/20  w500
```

The font binaries are project assets supplied separately by the development team. Do not rename the public typography-token API when registering them.

## Arabic / RTL / localization

- Arabic is the MVP locale and composition is RTL-first.
- Visible strings live in Flutter localization resources, not inline Dart literals.
- Directional layout uses start/end APIs.
- Back navigation uses Flutter platform behavior.
- Phone, OTP, references, times and codes may use LTR isolation inside RTL pages.
- Selected controls and status states must never rely on color alone.

## Component boundary

Core primitives are domain-neutral. Examples:
`AafiatakButton`, `AafiatakTextField`, `AafiatakCard`, `AafiatakListRow`,
`AafiatakStatusBlock`, and `AafiatakPrimaryActionBar`.

A component such as `AppointmentCard`, `ReservationHoldBanner`, or
`QueueStatusBlock` has domain semantics and belongs to the upcoming Domain
Patterns layer.

Business eligibility/state transitions remain in feature state/ViewModels, not inside visual components or patterns.

## Migration source and exclusions

The token migration is based on the approved High-Fidelity theme handoff. Generator/scaffold artifacts that happened to be present in that handoff are **not** project architecture and are not imported into Aafiatak. This includes unrelated social-login assets, password auth assumptions, alternate localization scaffolding, dark-theme color families, and unused application dependencies.

See `docs/design_system/DESIGN_TOKEN_MIGRATION_v2.1.md` for the migration record and validation gates.
