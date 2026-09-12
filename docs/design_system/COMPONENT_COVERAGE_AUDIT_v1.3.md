# Documentation → Flutter component coverage audit — v1.3

## Basis

The component surface was compared against the supplied Detailed Screen Specifications, Design System Visual Foundations, Component Foundations, UI State Matrix and High-Fidelity Flutter handoff covering the frozen 21 Patient screens / 142 rendered states.

## Tier-A primitive coverage

| Documented primitive/capability | Flutter implementation | Result |
|---|---|---|
| Button variants incl. destructive | `AafiatakButton` | PASS |
| IconButton | `AafiatakIconButton` | PASS |
| TextField | `AafiatakTextField` | PASS |
| PhoneField | `AafiatakPhoneField` | PASS |
| OtpInput | `AafiatakOtpInput` | PASS — config-driven single logical input |
| Chip | `AafiatakChip` | PASS |
| SegmentedControl | `AafiatakSegmentedControl` | PASS |
| AppBar | `AafiatakAppBar` | PASS |
| NavigationBar | `AafiatakNavigationBar` | PASS |
| Card | `AafiatakCard` | PASS |
| Divider | `AafiatakDivider` | PASS |
| List row | `AafiatakListRow` | PASS — added v1.3 |
| Dialog | `AafiatakDialog` | PASS |
| BottomSheet | `AafiatakBottomSheetBody` | PASS |
| Banner | `AafiatakBanner` | PASS |
| Snackbar | `AafiatakSnackbar` | PASS |
| Skeleton | `AafiatakSkeleton` | PASS |
| Progress | `AafiatakProgress` / `AafiatakLoading` | PASS |
| Badge | `AafiatakBadge` | PASS |

## Reusable structural map

| Documented structural concept | Decision |
|---|---|
| `PatientAppShell` | APP-LAYER DEFER — implement with real routing/top-level destinations, not as a Design System primitive |
| `AsyncStateView` | DELIBERATE DEFER — 142-state matrix includes nuanced stale/offline/refreshing content-preservation states; avoid an oversimplified universal wrapper |
| SearchInput | COVERED by `AafiatakSearchField` |
| OtpInput | COVERED by rebuilt `AafiatakOtpInput` |
| `FormFieldBlock` | CURRENTLY COVERED by text/phone/OTP field contracts; add a generic wrapper only when a real non-text field requires it |
| `PrimaryActionBar` | COVERED by `AafiatakPrimaryActionBar` — added v1.3 |
| `StatusMessage` | COVERED by `AafiatakStatusBlock` / `AafiatakBanner`; no duplicate primitive |

## Tier-B/domain layer

All documented domain components remain intentionally unimplemented in the foundation baseline. They are **not missing core primitives**. They will be assigned to the three developers with one owner per shared Pattern and built from the primitives above.

## Additional review conclusions

- no Avatar/Carousel/QR wrapper is promoted to a generic primitive solely because a future Pattern may use one;
- no open OTP length, hold duration, payment-provider detail or country/phone policy is hard-coded;
- no new generic `utils`, service, or `shared/widgets` layer is needed;
- localizable visible strings have a dedicated ARB path.

## Verdict

**No additional source-backed domain-neutral component must be added before team feature work.** The next architecture work is Domain Pattern/screen ownership planning, followed by team implementation.
