# Architecture audit — Aafiatak Flutter v1.3

## Scope

The complete v1.2 Flutter source was re-audited against the supplied Patient MVP documentation chain through the final High-Fidelity handoff. The review covered the application shell, folders, dependencies, localization, Design System, `shared/`, tests, and the boundary between primitives and future Domain Patterns.

## Findings closed in v1.3

### Documentation/component drift

The design documentation explicitly calls for a domain-neutral `List row` and a stable `PrimaryActionBar`. v1.2 had neither. v1.3 adds `AafiatakListRow` and `AafiatakPrimaryActionBar` without adding product/business semantics.

### OTP contract

The approved PAT-20 specification keeps OTP length configuration-driven, requires coherent accessibility, and must remain compatible with paste/autofill without unexpected component-owned submission. `AafiatakOtpInput` was rebuilt around one logical `TextField` with generated visual cells and caller-supplied length.

### Status contract

The visual foundations define a status block as icon + concise state label + optional supporting copy + optional next action. `AafiatakStatusBlock` now models that contract directly.

### Localization contract

The detailed specifications require visible Arabic copy to live in localization resources so English can be added later without changing widget hierarchy. v1.3 adds Flutter `gen-l10n`, `app_ar.arb`, and removes visible Arabic literals from reusable production Dart.

### Architecture remains intentionally small

No generic `utils/`, `services/`, `extensions/`, `config/`, `core/`, or fake backend layer was reintroduced. The current boundaries remain:

```text
lib/src/
├── app/
├── design_system/
├── features/
└── shared/media/
```

## Domain Patterns decision

Tier-B/domain components are not missing primitives. They are deliberately the next team-owned layer. Each shared Pattern must have one owner and remain visual/compositional; lifecycle truth, API calls, navigation, and action eligibility stay in feature state/ViewModels.

## Result

The source architecture is suitable as the **team baseline candidate**, subject to the local developer-machine gates in `TEAM_READINESS_v1.3.md`. Static checks are repeatable in `scripts/`; Flutter CLI/build claims are intentionally deferred to a machine with the approved SDK.
