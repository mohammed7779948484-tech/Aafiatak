# Design

## Direction

Aafiatak follows the read-only visual reference in
`Aafiatak_High_Fidelity_Prototype_v3.0/`:

- Arabic RTL
- phone UI
- light Material 3
- calm Burgundy Monochrome styling
- clear spacing, cards, status blocks, and navigation

The Flutter implementation translates visual intent into native Material
widgets. Browser-preview techniques such as the reference's 430px maximum
width are not application constraints.

## Palette

| Role | Value |
|---|---|
| Primary | `#800020` |
| Canvas | `#E5E5E5` |
| Surface | `#FFFFFF` |
| Surface container | `#EFEFEF` |
| Primary container | `#F7E9EC` |
| Primary text | `#1A1A1A` |
| Secondary text | `#6E6E6E` |
| Outline | `#E5E5E5` |

Feedback remains monochrome. Burgundy communicates positive and held states;
neutral charcoal and gray communicate information, warnings, and errors.
Icons and Arabic copy carry meaning instead of unrelated green, orange, or
blue status colors.

## Typography

`AafiatakTypography` defines a compact type scale. No custom font file is
bundled, so Flutter uses the platform's Arabic-capable system font.

## Material First

- Buttons use `FilledButton`, `OutlinedButton`, and `TextButton`.
- Inputs use `TextFormField` and `InputDecorationTheme`.
- Cards use `Card` and add `InkWell` only when tappable.
- App bars use `AppBar` and `IconButton`.
- Bottom navigation uses `NavigationBar` and `NavigationDestination`.
