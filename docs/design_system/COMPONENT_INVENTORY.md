# Core component inventory — v1.3

## Buttons

- `AafiatakButton` — filled / tonal / outline / text / destructive, loading/disabled, leading/trailing, expanded width, semantics.
- `AafiatakIconButton` — standard / filled / tonal / outlined icon action with required tooltip.

## Inputs

- `AafiatakTextField` — persistent label, helper/error, standard input geometry.
- `AafiatakPhoneField` — phone-specialized LTR entry without inventing country/normalization policy.
- `AafiatakOtpInput` — caller-configured length, one logical digits-only input, generated visual cells, paste/autofill, no component-owned verification submission.
- `AafiatakSearchField` — Material 3 `SearchBar` wrapper with Aafiatak sizing/theme hooks.

## Selection

- `AafiatakChip` — filter/select option with non-color selected indicator.
- `AafiatakSegmentedControl<T>` — 2–4 peer options with selected icon enabled by default.

## Surfaces / layout

- `AafiatakCard` — standard card surface + optional interaction.
- `AafiatakDivider` — low-emphasis separator.
- `AafiatakInfoRow` — domain-neutral label/value summary row.
- `AafiatakListRow` — generic RTL-safe repeated/menu list row; domain-specific rows remain Patterns/features.
- `AafiatakPrimaryActionBar` — stable SafeArea-aware bottom action region for transactional/form screens; owns layout only.

## Navigation

- `AafiatakAppBar` — platform/RTL-correct Material AppBar/back behavior.
- `AafiatakNavigationBar` — Material 3 top-level phone navigation.

## Feedback

- `AafiatakStatusBlock` — icon + state title + optional supporting copy + optional next action/trailing content.
- `AafiatakBanner` — persistent page feedback with optional action/dismiss.
- `AafiatakSnackbar` — centralized transient feedback.
- `AafiatakFeedbackTone` — neutral/success/warning/error/info/hold semantic mapping.

## Overlays

- `AafiatakDialog` / `showAafiatakDialog`
- `AafiatakBottomSheetBody` / `showAafiatakBottomSheet`

## States

- `AafiatakLoading`
- `AafiatakSkeleton`
- `AafiatakProgress`
- `AafiatakEmptyState`
- `AafiatakErrorState`

These are primitives, not a one-size-fits-all `AsyncStateView`; feature state may preserve stale/offline content according to the approved state matrix.

## Data display

- `AafiatakBadge`
- `AafiatakIcon`

## Material controls themed without wrapper

Checkbox, Radio, Switch and related standard controls are governed through the application Material theme. A wrapper is not created unless a stable product-specific API becomes necessary.

## Deliberately absent: Domain Patterns

Examples intentionally left for team ownership include:

`DoctorCard`, `ServiceCard`, `FacilitySummaryCard`, `AppointmentCard`,
`AvailabilityDayItem`, `ArrivalWindowCard`, `ReservationHoldBanner`,
`AppointmentStatusBlock`, `PaymentStatusBlock`, `VisitStatusBlock`,
`QueueStatusBlock`, `NotificationItem`, `BookingSummary`,
`PolicyDisclosureSection`, and `QRVerificationPanel`.
