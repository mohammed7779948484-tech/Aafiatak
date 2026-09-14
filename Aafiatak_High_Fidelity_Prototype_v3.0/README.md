# Aafiatak — Patient MVP High-Fidelity Coded Prototype v2.0

**Status:** Final High-Fidelity phone baseline — audited and ready for Flutter implementation.

This package is a coded visual/interaction reference for the Aafiatak Patient MVP. It is intentionally **phone-only** and uses **HTML + TypeScript + CSS Variables** so the screens can be rendered, reviewed, iterated, and compared before the team implements them in Flutter.

## Coverage

- 21/21 logical Patient screens (`PAT-01` … `PAT-21`)
- 142 implemented UI state variants
- Arabic RTL first
- Yemeni Rial (`ر.ي` / YER)
- No Figma dependency
- No backend, database, real OTP, real payment gateway, or real maps integration
- No Tablet/Desktop design scope in this phase

## Source of truth hierarchy

1. Aafiatak Project Specification
2. Audited Screen Inventory
3. Information Architecture
4. User / Screen Flows
5. UI State Matrix
6. Detailed Screen Specifications
7. Annotated Wireframe Specifications
8. Design System / Visual Foundations v1.1
9. This High-Fidelity coded prototype

See `docs/SOURCE_CHAIN.md` and `docs/reviews/TRACEABILITY_AUDIT.md`.

## Palette v2.1 — Burgundy Monochrome

The UI uses exactly three source colors: **`#800020`** (brand burgundy — primary actions, positive/hold accents), **`#FFFFFF`** (surfaces/cards), and **`#E5E5E5`** (canvas, borders, secondary fills). All other values are tonal mixes or shades of these three. Status semantics are monochrome: positive states use the burgundy, caution/critical states use charcoal, and meaning is carried by the icon glyph and copy — never by a green/orange/blue hue.

## Navigation

The prototype is a single-page app with hash routing. Every screen is reachable by clicking the real UI (buttons, cards, bottom nav, back arrow), and the location hash reflects the target, for example:

```text
index.html#/PAT-12
index.html#/PAT-07/active-hold
index.html#/PAT-13/refunded
```

Query parameters (`?screen=PAT-12&state=confirmed`) remain supported and redirect into the hash on the first render. Opening `index.html` directly from disk works with full navigation.

## Run locally

```bash
./scripts/build.sh
./scripts/run_local.sh
```

## Final visual exports

- `screenshots/final_phone_viewport_4x/` — true 390×844 phone viewport captured at 4× device density.
- `screenshots/final_phone_full_3x/` — full-scroll reference at 3× density. Persistent bottom controls are moved to the document end only for readable full-page export.
- `screenshots/preview/` — all 142 state variants for QA.
- `contact_sheets/FINAL_21_SCREENS_OVERVIEW.png` — all approved default screens in one overview.
- `contact_sheets/PAT-XX_states.png` — every state variant for each screen.

## Important mock boundaries

The prototype contains presentation fixtures only. Values such as a displayed hold countdown and OTP cell count are injected as mock configuration for rendering and **do not freeze unresolved product decisions**. See `docs/MOCK_FIXTURE_BOUNDARIES.md`.

## Typography note

The Design System target is **IBM Plex Sans Arabic**. The CSS stack uses it first and falls back to Noto Sans Arabic when it is not installed. The sandbox review environment used the installed fallback for screenshot rendering. Flutter should load the approved IBM Plex Sans Arabic family in the actual app.
