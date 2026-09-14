# Screen-by-Screen Final Review

Each screen was built, rendered, visually checked, refined where necessary, and then re-rendered. All listed states are additionally available in the per-screen state contact sheets.

| Screen | Final review focus | Verdict |
|---|---|---|
| PAT-01 Home / Discover | Brand entry point, search prominence, primary booking CTA, patient/guest/empty/offline states | PASS |
| PAT-02 Search & Results | Search-first hierarchy, filters, heterogeneous result types, zero-results recovery | PASS |
| PAT-03 Doctor Details | Doctor identity, bio, facility context, service/payment-policy visibility, inactive/no-capacity handling | PASS |
| PAT-04 Service Details | Price, fixed payment policy, cancellation/no-show/arrival instructions, facility context | PASS |
| PAT-05 Facility & Branch | Address, neutral map preview, contact/hours, doctors/services, no provider lock-in | PASS |
| PAT-06 Availability / Select Day | Day-only choice, system-assigned arrival window, no arbitrary group picker, alert/no-capacity/stale states | PASS |
| PAT-07 Booking Review & Hold | Review-before-hold, policy disclosure, explicit temporary hold, expiry/capacity-loss recovery | PASS |
| PAT-08 Full Payment | Provider-neutral handoff, hold continuity, return-unverified/connectivity recovery, no invented card form | PASS |
| PAT-09 Payment Result | Payment vs booking outcome separation across success/processing/failure/review/refund states | PASS |
| PAT-10 Booking Confirmation | Confirmation, booking number/verification action, paid vs pay-at-facility distinction, arrival guidance | PASS |
| PAT-11 My Appointments | Upcoming/past segmentation, empty/loading/offline/refreshing behavior, consistent bottom nav | PASS |
| PAT-12 Appointment Details | Independent status domains, QR/number, directions, cancellation, facility cancellation and manual late handling | PASS |
| PAT-13 Payment & Refund Details | Due-at-facility path without fake PaymentIntent; full payment/refund state coverage | PASS |
| PAT-14 Live Visit & Queue | No self-check-in, group-local approximate position, CALLED prominence, manual-late privacy/priority guardrail | PASS |
| PAT-15 Notification Center | Read/unread not color-only, chronological scannability, stale deep-link safety | PASS |
| PAT-16 Profile | Minimal approved identity, verified phone, edit/logout, session expiry and logout feedback | PASS |
| PAT-17 Edit Profile | Single-column approved-field form, inline validation, preserved values on save/offline/failure | PASS |
| PAT-18 Account Access | Contextual auth reason, login/register split, WhatsApp passwordless explanation, safe return to browse | PASS |
| PAT-19 Phone Number | Neutral phone-format assumption, WhatsApp OTP request, rate/provider/identity recovery | PASS |
| PAT-20 WhatsApp OTP | Config-driven cell concept, LTR code inside RTL UI, verify/resend/change-number states | PASS |
| PAT-21 Complete Patient Profile | Verified phone context, full-name-only approved field, recoverable failure/duplicate identity paths | PASS |
