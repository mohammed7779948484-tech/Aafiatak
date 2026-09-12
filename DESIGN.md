# Aafiatak Design System — Flutter rules v1.3

Approved direction: **Quiet Vitality / Mineral Bloom**.

## Location

```text
lib/src/design_system/
├── foundations/
├── theme/
└── components/
```

Domain Patterns are intentionally the next team-owned layer, not part of this
baseline archive.

## Material strategy

Material 3 supplies platform behavior and accessibility mechanics. Aafiatak owns
semantic colors, typography, geometry, motion, and stable component APIs.

```text
Material primitive
→ Aafiatak theme/component theme
→ Aafiatak wrapper where a stable API is valuable
→ Domain Pattern
→ Feature screen
```

## Core visual rules

- Primary Damson `#4A315D`
- Secondary Sea Glass semantic `#3F786E`
- Hold/Copper `#A85A41`
- Canvas/Warm Porcelain `#F7F3EE`
- Surface `#FFFDF9`
- Ink `#25232B`
- minimum touch target: 48dp
- spacing scale: `0,4,8,12,16,20,24,32,40,48,64`
- radii: `8,12,16,24,999`
- motion: `80,140,220,320ms`

Features consume `ColorScheme`, `TextTheme`, Aafiatak tokens, or
`AafiatakSemanticColors`; no screen-local raw palette literals.

## Typography

Approved family contract:
- IBM Plex Sans Arabic
- IBM Plex Sans

Font binaries are not included in this archive.

## Arabic / RTL / localization

- Arabic is the MVP locale and composition is RTL-first.
- Visible strings live in Flutter localization resources, not inline Dart literals.
- Directional layout uses start/end APIs.
- Back navigation uses Flutter platform behavior.
- Phone, OTP, references, times and codes may use LTR isolation inside RTL pages.
- Selected controls must not rely on color alone.

## Component boundary

Core primitives are domain-neutral. Examples:
`AafiatakButton`, `AafiatakTextField`, `AafiatakCard`, `AafiatakListRow`,
`AafiatakStatusBlock`, and `AafiatakPrimaryActionBar`.

A component such as `AppointmentCard`, `ReservationHoldBanner`, or
`QueueStatusBlock` has domain semantics and belongs to the upcoming Domain
Patterns layer.

Business eligibility/state transitions remain in feature state/ViewModels, not
inside visual components or patterns.
