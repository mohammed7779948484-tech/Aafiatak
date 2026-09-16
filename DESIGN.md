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

`AafiatakColors` defines each physical color once. `AafiatakTheme` maps those
canonical values explicitly to Material `ColorScheme`; it does not use
`ColorScheme.fromSeed` or duplicate a source constant for every Material role.

| Foundation role | Value |
|---|---|
| Primary | `#800020` |
| Canvas | `#E5E5E5` |
| Surface | `#FFFFFF` |
| Surface low | `#F7F7F7` |
| Surface container | `#EFEFEF` |
| Primary container | `#F7E9EC` |
| On primary container | `#5C0016` |
| Primary text | `#1A1A1A` |
| Secondary text | `#6E6E6E` |
| Critical Material error | `#1F1F1F` |

The enabled input boundary intentionally uses `#909090` instead of the
prototype's lighter `#E5E5E5`, giving 3.19:1 contrast against white for WCAG
1.4.11. Do not replace it with the prototype boundary during visual cleanup.

Application feedback remains monochrome and exposes six meanings: `primary`,
`secondary`, `success`, `warning`, `info`, and `hold`. The removed custom
`error` tone does not remove Material error semantics: destructive buttons,
validation, and `ColorScheme.error*` remain explicitly supported. Icons and
Arabic copy carry meaning instead of unrelated green, orange, or blue colors.

## Typography

IBM Plex Sans Arabic is bundled under `assets/fonts/` at weights 400, 500, 600,
and 700. `AafiatakTypography` preserves the High-Fidelity metrics through the
CSS-like roles `display`, `h1`, `h2`, `h3`, `bodyLarge`, `body`, `labelLarge`,
`label`, `bodySmall`, and `caption`. Its `textTheme` maps the same definitions
to Material roles without maintaining a second legacy API.

## Material First

- Buttons use `FilledButton`, `OutlinedButton`, and `TextButton`.
- `AafiatakButton` exposes named constructors for consistent team usage.
- Inputs use `TextFormField` and `InputDecorationTheme`.
- Search uses `SearchBar` and `SearchBarThemeData`.
- Cards use `Card` and add `InkWell` only when tappable.
- App bars use `AppBar` and `IconButton`.
- Bottom navigation uses `NavigationBar` and `NavigationDestination`.
