# Aafiatak — High-Fidelity UI Skill Inspection v1.0

**Date:** 2026-09-04  
**Phase:** High-Fidelity Patient UI Design  
**Repositories inspected:**  
- `Owl-Listener/designer-skills`
- `julianoczkowski/designer-skills`

## Verification result

All selected High-Fidelity skills were fetched from their current GitHub source and their complete `SKILL.md` files were read. The source directory of every selected skill was also inspected. For this selected set, each directory contains `SKILL.md` only; no adjacent `references/`, `scripts/`, templates, or supplementary files were present.

## Selected skills

### Core High-Fidelity construction
- `frontend-design` — Julian
- `component-spec`
- `visual-hierarchy`
- `aesthetic-usability`
- `interfaces-that-feel`
- `color-system`
- `typography-scale`
- `readable-measure`
- `spacing-system`
- `layout-grid`
- `responsive-design`
- `platform-conventions`
- `localization-design`

### Screen-specific interaction
- `form-design`
- `search-ux`
- `loading-states`
- `error-handling-ux`
- `feedback-patterns`
- `animation-principles`
- `micro-interaction-spec`
- `fitts-law`
- `hicks-law`
- `jakobs-law`

### Prototype / UX validation
- `prototype-strategy`
- `heuristic-evaluation`

### Visual critique
- `critique-affordance`
- `critique-information-density`
- `critique-brand-consistency`
- `critique-color`
- `critique-composition`
- `critique-typography`
- `critique-visual-hierarchy`

### Reserved for coded-build review
- `design-review` — Julian

`design-review` explicitly requires visual screenshots of a running built interface, so it is intentionally reserved for the coded Flutter/prototype review rather than falsely claiming it during static Figma high-fidelity design.

## Important methodological decisions

- Existing Aafiatak Design System v1.1 remains the visual source of truth; High-Fidelity does not regenerate the brand palette.
- High-frequency/high-risk interactions follow platform/category conventions (`jakobs-law`, `platform-conventions`); differentiation comes from visual identity, not novel booking/payment mechanics.
- Critical tap targets and action placement are checked using `fitts-law`.
- Choice count and simultaneous decision burden are checked using `hicks-law`.
- Emotional tone is applied contextually with `interfaces-that-feel`, especially payment, errors, queue waiting, cancellation, and confirmation.
- Motion is purposeful and token-driven, with reduced-motion support.
- Visual critique is a separate pass from design construction.
- Nielsen heuristic evaluation is performed after representative screens and again after the full set.
