# Aafiatak Design System — QA status

## Current status

The `develop` baseline was previously validated on Flutter 3.47.4 / Dart 3.13.3 with the pre-migration v1.3 visual tokens.

The active Design System migration branch changes the visual-token contract to **Burgundy Monochrome v2.1**. Therefore the old v1.3 static report must be treated as historical until the migration branch is validated again.

Do **not** interpret the existing generated `STATIC_QA_REPORT.json` as proof that the new token migration has passed unless it was regenerated from the current branch.

## Review scope for the migration

- Burgundy/neutral foundations and explicit Material 3 ColorScheme mapping;
- typography family key and approved type scale;
- canonical spacing, radius, border, elevation and motion tokens;
- Arabic/RTL/localization mechanics;
- every domain-neutral component affected by theme propagation;
- status communication without hue-only meaning;
- input/hint contrast;
- documentation-to-component coverage;
- Design System dependency isolation;
- widget/RTL/accessibility tests;
- public barrel/export coverage.

Domain Patterns and production Patient screens remain outside this foundation migration.

## Required static Design System QA

Run:

```bash
python scripts/static_design_system_audit.py
```

The migration-aware audit checks, among other gates:

- Burgundy Monochrome v2.1 canonical anchors;
- absence of the old Mineral Bloom accent values from active Design System Dart;
- canonical spacing/motion/touch-target contracts;
- canonical contrast pairs;
- localization setup;
- OTP/StatusBlock/ListRow/PrimaryActionBar contracts;
- RTL-safe core component layout;
- no raw component-local hex colors;
- public export coverage.

## Whole-project architecture QA

```bash
python scripts/static_architecture_audit.py
```

The architecture audit continues to enforce the agreed folder boundaries, `shared/` discipline, auth/scaffold cleanup, dependency hygiene, localization resources and import integrity.

Approved project font assets are now allowed under `assets/`; the audit specifically rejects the irrelevant social-login asset residue instead of banning the entire assets directory.

## Flutter gates

Run after localization generation and after approved font assets are registered:

```bash
flutter pub get
flutter gen-l10n
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

## Runtime/visual smoke gate

Test on a real/emulated phone before merge:

- Arabic RTL and centered AppBar titles;
- grey canvas with approved neutral surfaces;
- Burgundy primary and selected states;
- input/focus/error readability;
- pill chips;
- 28dp search and bottom-sheet geometry;
- card shadow behavior;
- all feedback tones with explicit icon/copy/state meaning;
- OTP interaction;
- text scaling;
- reduced motion.

## Merge criterion

The Burgundy Monochrome v2.1 PR remains **not ready to merge** until the current branch produces passing static audits, zero analyzer issues, passing Flutter tests, and an approved phone visual smoke test.

See `DESIGN_TOKEN_MIGRATION_v2.1.md` for the source decision and token mapping.
