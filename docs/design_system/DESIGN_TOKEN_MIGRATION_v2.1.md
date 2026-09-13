# Aafiatak Design Token Migration — Burgundy Monochrome v2.1

## Purpose

This record documents the visual-token migration from the previous Mineral Bloom palette to the latest approved High-Fidelity direction: **Burgundy Monochrome v2.1**.

The migration intentionally updates the existing Aafiatak Design System rather than replacing it with the generator/scaffold project that accompanied the High-Fidelity token files.

## Source-of-truth decision

The useful source material from the latest High-Fidelity package is the visual token/theme handoff:

- Burgundy/neutral color roles;
- IBM Plex Sans Arabic typography contract;
- spacing/radius/elevation/motion tokens;
- component-level visual direction such as pill chips, 28dp search/sheet geometry, grey page canvas and white surfaces.

The following items that also existed in the package are **not** treated as Aafiatak architecture or product requirements and were deliberately not imported:

- unrelated Google/Facebook/Apple sign-in assets;
- email/password/Forgot Password assumptions;
- unrelated onboarding/travel localization copy;
- alternate localization stack;
- Supabase/Dio/fpdart/equatable/shared-preferences/environment dependencies from the scaffold;
- scaffold dark theme and generated accent families;
- wholesale replacement of the project's `pubspec.yaml` or feature structure.

Aafiatak remains Flutter + Material 3 + Riverpod 3 + go_router + `gen-l10n`, with the existing feature-first architecture.

## Token mapping

| Role | Previous baseline | Burgundy Monochrome v2.1 |
|---|---|---|
| Primary | Damson `#4A315D` | Burgundy `#800020` |
| Primary dark | Damson family | `#5C0016` |
| Primary container | Damson tint | `#F7E9EC` |
| Secondary accent | Sea Glass `#3F786E` | dark Burgundy `#5C0016` |
| Tertiary accent | Copper `#A85A41` | charcoal `#1A1A1A` |
| Canvas | warm porcelain `#F7F3EE` | neutral grey `#E5E5E5` |
| Surface | `#FFFDF9` | white `#FFFFFF` |
| Primary text | `#25232B` | charcoal `#1A1A1A` |
| Secondary text | `#6B666E` | `#6E6E6E` |
| Strong outline | warm neutral | `#B5B5B5` |
| Light outline | warm neutral | `#E5E5E5` |
| Hold attention | Copper | Burgundy |
| Success | green family | Burgundy + success icon/copy |
| Warning | amber family | charcoal + warning icon/copy |
| Error | red family | strong charcoal + error icon/copy |
| Info | blue family | charcoal + info icon/copy |

## Status semantics

Burgundy Monochrome intentionally avoids introducing separate green/yellow/red/blue status families.

This does **not** mean states become visually indistinguishable. A status presentation must use at least:

- explicit localized state copy;
- appropriate iconography;
- semantic/accessibility state information;
- layout/structure appropriate to the state;
- color only as a supporting cue.

Existing APIs such as `AafiatakFeedbackTone` are retained so feature/Pattern code continues to express semantic intent even when several tones map to the same monochrome family.

## Geometry

### Spacing

Canonical new scale:

```text
0, 2, 4, 8, 12, 16, 20, 24, 32, 48, 64
```

`40dp` remains available only as a compatibility token for existing authored code; new composition should use the canonical scale unless a reviewed layout calls for otherwise.

### Radii

```text
4, 8, 12, 16, 24, 28, 999
```

- card: 16
- dialog: 24
- search: 28
- bottom-sheet top: 28
- chip/pill: 999

## Typography

Canonical Flutter family key:

```text
IBMPlexSansArabic
```

Approved roles:

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

### Font assets

The approved font binaries are supplied separately to the development team. They are not committed by this migration automatically.

When the font files exist locally under the approved asset path, register them in `pubspec.yaml` using the exact family key:

```yaml
flutter:
  generate: true
  uses-material-design: true

  fonts:
    - family: IBMPlexSansArabic
      fonts:
        - asset: assets/fonts/IBMPlexSansArabic-Regular.ttf
        - asset: assets/fonts/IBMPlexSansArabic-Medium.ttf
          weight: 500
        - asset: assets/fonts/IBMPlexSansArabic-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/IBMPlexSansArabic-Bold.ttf
          weight: 700
```

Do not add the font registration until those files actually exist in the repository/worktree, otherwise Flutter asset resolution will fail.

## Motion

- instant: 80ms
- fast: 140ms
- standard: 220ms
- deliberate: 320ms
- shimmer: 1350ms
- standard curve: `Cubic(0.2, 0, 0, 1)`

The exact cubic token is retained rather than copying an approximate generic easing curve from scaffold code.

## Elevation

- e1 / interactive card: `0 2 10 rgba(26,26,26,.055)`
- e2 / overlays: `0 14 34 rgba(26,26,26,.11)`
- brand emphasis: `0 12 26 rgba(128,0,32,.20)`

Static cards remain primarily surface/border-led; interactive cards may use e1.

## Material 3 mapping

Aafiatak continues to use an explicit `ColorScheme` instead of `ColorScheme.fromSeed`. This prevents Material seed generation from introducing unapproved accent hues.

Notable component-theme mapping changes:

- white AppBar surface with centered titles;
- low-neutral input/search fills;
- white cards on grey canvas;
- pill chip geometry;
- 28dp search and modal-sheet geometry;
- Burgundy selected/primary states;
- monochrome feedback mapping while preserving semantic tone APIs.

## Accessibility review

The migrated canonical text/background pairs were checked for a minimum 4.5:1 contrast target. Examples:

- Burgundy / white: > 10:1
- dark Burgundy / Burgundy tint: > 12:1
- charcoal / white: > 17:1
- secondary text `#6E6E6E` / white: ~5.1:1
- secondary text / `#F7F7F7`: ~4.7:1

The scaffold's reduced-opacity label/hint treatment was deliberately not copied because it would materially reduce contrast.

## Architecture preserved

This migration does not change:

```text
app/
design_system/
features/
shared/
```

It also does not create Domain Patterns. Patterns remain team-owned and are built from the migrated primitives/tokens after this branch is validated and merged.

## Required validation before merge

Run on the approved Flutter SDK:

```bash
flutter pub get
flutter gen-l10n
python scripts/static_design_system_audit.py
python scripts/static_architecture_audit.py
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

Then perform a phone smoke test covering at minimum:

- grey canvas + white surfaces;
- AppBar title centering in Arabic RTL;
- Burgundy primary/selected states;
- pill chips;
- 28dp search geometry;
- input focus/error states;
- interactive card shadow;
- every feedback tone with icon + text, confirming no state relies on hue alone;
- OTP input;
- text scaling;
- reduced-motion behavior.

## Merge rule

Do not merge the token migration into `develop` until:

1. font assets are registered or a deliberate decision is made to defer the real font assets;
2. all static audits pass;
3. `flutter analyze` passes with zero issues;
4. all tests pass;
5. the phone smoke test visually matches the approved High-Fidelity direction.
