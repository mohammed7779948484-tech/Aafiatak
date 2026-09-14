# Aafiatak Design System — Flutter rules v2.1 (Burgundy Monochrome)

Approved visual direction: **Burgundy Monochrome** (derived directly from `Aafiatak_High_Fidelity_Prototype_v3.0`).

## Location

```text
lib/src/design_system/
├── foundations/         # Colors, Spacing, Radii, Typography
├── theme/               # Material 3 Theme mapping
├── components/          # 9 Core primitives
└── patterns/           # 7 Domain patterns
```

## Material Strategy

Material 3 supplies platform behavior and accessibility mechanics. Aafiatak owns semantic colors, geometry, typography, and clean reusable component APIs.

```text
Material primitive
→ Aafiatak theme / component styles
→ Aafiatak 9 core components
→ Aafiatak 7 domain patterns
→ Feature screens (Patient shell)
```

## Core Visual Palette (Burgundy Monochrome)

- **Brand / Primary**: `#800020` (Deep Burgundy)
- **Primary Container**: `#F7E9EC` (Soft Pinkish Burgundy Container)
- **Canvas / Background**: `#E5E5E5` (Cool Grey Background)
- **Surface**: `#FFFFFF` (Clean White for cards, panels, inputs)
- **Surface Container**: `#EFEFEF` (Light grey container)
- **Text Primary**: `#1A1A1A` (Near Black)
- **Text Secondary**: `#6E6E6E` (Muted Grey)
- **Outline / Border**: `#E5E5E5` (Subtle boundary borders)

### Feedback Tones
- **Success**: `#15803D` (Container: `#DCFCE7`)
- **Warning**: `#B45309` (Container: `#FEF3C7`)
- **Error / Destructive**: `#B91C1C` (Container: `#FEE2E2`)
- **Info / Brand**: `#800020` (Container: `#F7E9EC`)
- **Neutral**: `#6E6E6E` (Container: `#F5F5F5`)
- **Hold**: `#C2410C` (Container: `#FFEDD5`)

### Dimensions & Metrics
- Minimum touch target: `48dp`
- Spacing scale: `0, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64` (both t-shirt `xs..x5l` and numeric `space0..space64`)
- Radii: `8, 12, 16, 24, 999` (both t-shirt `sm..full` and numeric `radius8..radiusFull`)

## Typography

Contract hierarchy:
- Primary: `IBM Plex Sans Arabic`
- Fallbacks: `Noto Sans Arabic`, `Noto Sans`, platform sans-serif

> Note: Font binaries are not bundled into the repository; system and platform fallbacks are fully supported.

## Arabic / RTL

- Arabic is the sole MVP locale and composition is RTL-first.
- Directional layout uses `start`/`end` APIs.
- Back navigation follows standard RTL conventions (pointing right for back).
- Phone numbers, OTP codes, references, and timestamps are isolated as LTR where appropriate.

## Core Components (9)

1. `AafiatakButton` — Variants: primary (`#800020`), tonal (`#F7E9EC`), secondary (`outline`), destructive, text. Block & compact sizing. Icon support.
2. `AafiatakTextField` — Input container with hint, optional prefix/suffix icon, error & helper text.
3. `AafiatakCard` — Surface container with optional elevation and tap callback.
4. `AafiatakInfoRows` — Structured key-value metadata list with optional LTR value isolation.
5. `AafiatakBadge` — Status pill badge with 7px dot bullet indicator.
6. `AafiatakNotice` — Full-width contextual banner for warning, info, success, and error.
7. `AafiatakStatusBlock` — Status card with 48x48 icon chip, category tag, title, and descriptive message.
8. `AafiatakSectionHeading` — Section title heading with optional action button or trailing badge.
9. `AafiatakEmptyState` — Empty state placeholder with 48x48 icon, title, copy, and action button.

## Domain Patterns (7)

1. `DoctorCard` — Doctor card with name, specialty, rating, fee, next available slot, and booking button.
2. `ServiceCard` — Service item card with title, duration, pricing, and selection trigger.
3. `FacilitySummary` — Clinic/facility summary with name, address, rating, and distance.
4. `AppointmentSummary` — Appointment overview card with doctor, clinic, date/time, and status badge.
5. `ReservationHoldBanner` — Countdown timer banner for temporary slot hold with active hold indicator.
6. `ArrivalWindowCard` — Recommended patient arrival window and gate guidance.
7. `PolicyCard` — Cancellation and clinic policy disclosure with bullet points.

