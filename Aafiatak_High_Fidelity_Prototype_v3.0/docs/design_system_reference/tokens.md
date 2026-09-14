# Aafiatak Canonical Token Reference — v2.1 (Burgundy Monochrome)

Machine-readable source: `tokens/aafiatak.tokens.json`
Flutter mapping: `flutter/aafiatak_theme.dart`

## Three source colors

- Brand (primary action & positive accent): `#800020`
- Base surface: `#FFFFFF`
- Sub neutral (canvas / borders / secondary fills): `#E5E5E5`

Every UI value is one of these three colors or a tonal mix/shade of them. No fourth hue is permitted anywhere in the UI.

## Semantic color anchors

- `color.action.primary` → `#800020`
- `color.action.onPrimary` → `#FFFFFF`
- `color.action.primaryContainer` → `#F7E9EC` (brand @ ~8% on white)
- `color.action.onPrimaryContainer` → `#5C0016`
- `color.surface.canvas` → `#E5E5E5`
- `color.surface.default` → `#FFFFFF`
- `color.surface.container` → `#EFEFEF`
- `color.text.primary` → `#1A1A1A` (charcoal shade of the neutral axis)
- `color.text.secondary` → `#6E6E6E`
- `color.border.default` → `#E5E5E5`
- `color.border.strong` → `#B5B5B5`

## Monochrome status semantics

Hue never carries status meaning. Positive states use the brand burgundy; caution and critical states use charcoal
(neutral axis); the meaning is carried by the icon glyph, the label, and the copy.

- `color.status.success` → `#800020` (container `#F7E9EC`, on-container `#5C0016`)
- `color.status.hold` → `#800020` (container `#F7E9EC`, on-container `#5C0016`)
- `color.status.info` → `#1A1A1A` (container `#EFEFEF`)
- `color.status.warning` → `#1A1A1A` (container `#EFEFEF`)
- `color.status.error` → `#1F1F1F` — solid charcoal icon chip / badge with white content; notices use the light container with charcoal text

## Spacing

`0, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64`

## Radius

- `radius.sm` 8
- `radius.md` 12
- `radius.lg` 16
- `radius.xl` 24
- `radius.full` 999 (only when shape semantics warrant it)

## Typography

Primary: IBM Plex Sans Arabic / IBM Plex Sans.

- Display 32/40, 700
- H1 28/36, 700
- H2 24/32, 700
- H3 20/28, 600
- Body Large 18/30, 400
- Body 16/27, 400
- Label Large 16/24, 600
- Label 14/22, 600
- Body Small 14/23, 400
- Caption 12/20, 500

## Motion

- `instant` 80ms
- `fast` 140ms
- `standard` 220ms
- `deliberate` 320ms

## Rule

Production components reference semantic/component tokens; the three source colors are not hard-coded inside feature widgets.
