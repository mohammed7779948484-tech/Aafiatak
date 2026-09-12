# Folder contracts — Aafiatak Flutter v1.3

## Root

| Path | Responsibility |
|---|---|
| `lib/` | production Dart and localization sources |
| `test/` | unit/widget/accessibility/architecture-facing tests |
| `docs/` | architectural and Design System decisions/audits |
| `scripts/` | repeatable verification |
| `pubspec.yaml` | approved SDK/dependency surface |
| `l10n.yaml` | Flutter localization generation contract |

## `lib/main.dart`

Composition entry point only: Flutter binding initialization, Riverpod `ProviderScope`, then `AafiatakApp`. No feature bootstrapping, fake API configuration, or global navigation state.

## `lib/l10n/`

Owns localizable product/system copy. `app_ar.arb` is the current Arabic source bundle; generated Dart goes to `lib/l10n/generated/` and is not hand-edited.

## `lib/src/app/`

Application composition and routing. `MaterialApp.router`, theme, locale/delegates and route graph live here. Business logic does not.

## `lib/src/design_system/`

The visual source of truth.

- `foundations/`: palette, semantic anchors, typography, spacing, geometry, motion, sizes and icon vocabulary.
- `theme/`: Material 3 `ColorScheme`, semantic ThemeExtension and component themes.
- `components/`: domain-neutral reusable primitives.
- future `patterns/`: team-owned reusable domain compositions; not present in this baseline.

A Pattern may compose primitives but may not call an API/repository, perform navigation, or decide lifecycle truth.

## `lib/src/features/`

Primary team ownership boundary. Current `starter/` is development-only and should recede when real Patient features land.

UI/mock phase shape:

```text
features/<feature>/
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── view_models/
└── data/mock/
```

Only create folders that have real code.

## `lib/src/shared/`

Strict cross-feature technical-infrastructure boundary. Current approved module: `media/`. See `SHARED_GUIDE.md`.

It is not a home for feature models, Domain Patterns, mock data, repositories, or a generic helper collection.

## Future backend/data layers

When integration begins, add repositories/services around actual approved contracts and sources of truth. Introduce a separate domain/use-case layer only when client-side business complexity demonstrably needs it; do not pre-create empty architecture.
