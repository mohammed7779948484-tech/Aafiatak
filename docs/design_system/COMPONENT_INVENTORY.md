# Core Component Inventory — v2.1 (Burgundy Monochrome)

## Core Components (9 Primitives in `lib/src/design_system/components/`)

### 1. Buttons (`components/buttons/`)
- `AafiatakButton` — Clean button primitive supporting variants: `primary` (Burgundy `#800020`), `tonal` (`#F7E9EC`), `secondary` (`outline`), `destructive` (`#B91C1C`), and `text`. Sizing options: `block` (full width, 48dp) and `compact` (36dp). Handles optional leading/trailing icons, disabled states, and flexible text wrapping.

### 2. Inputs (`components/inputs/`)
- `AafiatakTextField` — Modern input shell with persistent or floating label, hint text, optional leading/trailing icon, error message, helper text, and validation states.

### 3. Surfaces (`components/surfaces/`)
- `AafiatakCard` — Surface container with 12px or 16px radius, subtle border (`#E5E5E5`), optional tap handling, and configurable elevation/padding.
- `AafiatakInfoRows` — Structured key-value display row list supporting RTL labels, optional LTR isolation for numbers/IDs/dates, and subtle dividers.

### 4. Data Display (`components/data_display/`)
- `AafiatakBadge` — Compact status pill badge featuring a 7px dot bullet indicator, configurable `AafiatakBadgeTone` / `AafiatakFeedbackTone`, and min 28dp height.

### 5. Feedback (`components/feedback/`)
- `AafiatakNotice` — Contextual alert banner across feedback tones (`neutral`, `success`, `warning`, `error`, `info`, `hold`) for highlighting important messages.
- `AafiatakStatusBlock` — High-emphasis status presentation card featuring a 48x48 icon chip, category tag, title heading, descriptive body text, and optional action.

### 6. Layout (`components/layout/`)
- `AafiatakSectionHeading` — Standard section header displaying title text with optional trailing action button or badge.

### 7. States (`components/states/`)
- `AafiatakEmptyState` — Full-surface empty state placeholder with 48x48 icon container, title, supporting copy, and action button.

---

## Domain Patterns (7 Visual Compositions in `lib/src/design_system/patterns/`)

### 1. Doctor Pattern (`patterns/doctor/`)
- `DoctorCard` — Doctor presentation card with photo placeholder, name, specialty, rating badge, consultation fee, next available slot, and booking action button.

### 2. Service Pattern (`patterns/service/`)
- `ServiceCard` — Medical service card displaying service title, duration, price, description, and selection button.

### 3. Facility Pattern (`patterns/facility/`)
- `FacilitySummary` — Healthcare facility / hospital summary card with clinic name, address, working hours, rating, and distance.

### 4. Appointment Pattern (`patterns/appointment/`)
- `AppointmentSummary` — Appointment overview card with doctor, clinic/branch, date, time slot, appointment type, and status badge.

### 5. Booking Patterns (`patterns/booking/`)
- `ReservationHoldBanner` — Temporary hold countdown banner highlighting hold duration and expiration timer with clock icon.
- `ArrivalWindowCard` — Recommended arrival guidance block displaying arrival window time, room number, and gate instructions.
- `PolicyCard` — Clinic policy disclosure card displaying cancellation rules and clinic instructions with bullet points.

