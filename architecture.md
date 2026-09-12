# Aafiatak Flutter architecture v1.3

## Current goal

Provide a stable, team-splittable frontend baseline for the Patient MVP without
inventing backend architecture or unresolved product decisions.

```text
lib/src/
├── app/                         # composition, routing
├── design_system/               # visual source of truth
├── features/                    # patient feature ownership
└── shared/
    └── media/                    # cross-feature technical infrastructure
```

Localization resources live under `lib/l10n/` and are generated through Flutter
`gen-l10n`.

## UI/mock feature shape

```text
features/<feature>/
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── view_models/             # Riverpod Notifier/AsyncNotifier when needed
└── data/
    └── mock/                    # feature-local deterministic fixtures
```

Do not create empty layers merely for architectural symmetry.

## Dependency direction

```text
app ───────────→ features + design_system + shared + generated localizations
features ──────→ design_system + shared + generated localizations
shared ────────→ design_system + generated localizations where needed
design_system ─→ Flutter/Material + generated localizations + approved DS packages
```

Forbidden:
- `design_system` importing a feature;
- `shared` importing a feature;
- one feature importing another feature's private implementation;
- repositories/services using `BuildContext` or visual feedback APIs;
- global navigator/root `BuildContext` singletons.

## Domain Patterns

The team will add a layer such as:

```text
design_system/
└── patterns/
    ├── doctor/
    ├── booking/
    ├── appointment/
    ├── payment/
    └── visit_queue/
```

A Domain Pattern is a reusable visual composition with domain meaning. It may
compose Design System primitives, but it must not own backend truth or perform
API calls. Feature/ViewModel logic decides what state/actions are allowed.

Every shared Pattern gets exactly one implementation owner to prevent duplicate
`DoctorCard`/`PaymentStatusCard` variants across branches.

## Backend evolution

When real integration starts, introduce repositories/services around approved
real data sources. App-wide sources of truth may then justify explicit `data/`
and, only where useful, `domain/` layers. Do not place them in `shared/`.
