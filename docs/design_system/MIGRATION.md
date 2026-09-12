# Migration history — generated starter → Aafiatak foundation v1.3

## Initial visual migration

Generator theme/duplicate generic visual widgets were removed and `lib/src/design_system/` became the only visual source of truth.

## v1.1 architecture cleanup

Removed incorrect email/password/Forgot Password auth, unrelated generator onboarding/home content, global import barrels/navigation wrappers, premature config/services/utilities/hooks, and unused dependencies. Useful image infrastructure was retained as `shared/media/`.

## v1.2 module simplification

Moved the Design System from `lib/src/core/design_system/` to `lib/src/design_system/` and removed the now-empty architectural concept of `core/`.

## v1.3 documentation-alignment pass

The complete Patient design chain through High Fidelity was compared back to Flutter code. This added/fixed:

- `AafiatakListRow`;
- `AafiatakPrimaryActionBar`;
- configuration-driven accessible OTP input;
- StatusBlock optional copy/next action contract;
- expanded phone-field API without invented phone policy;
- Flutter `gen-l10n`/ARB localization and removal of reusable hard-coded Arabic copy;
- component-coverage and team-readiness audits.

No Domain Pattern was prebuilt. The next migration step is team-owned Pattern + screen implementation after the local freeze gates pass.
