# Source alignment — Aafiatak Flutter v1.3

## Authority used

This pass uses the project specification/UML for product invariants and the supplied Patient design-document chain through High Fidelity for presentation/component requirements. The Flutter starter is not allowed to silently invent unresolved product values.

## Product invariants preserved

- phone identity + passwordless WhatsApp OTP; no email/password/Forgot Password/SMS-auth flow;
- OTP length and timing are configuration-driven;
- ReservationHold duration and reminder timing remain open;
- payment provider/backend provider details remain open;
- ReservationHold, Appointment, PaymentIntent, VisitInstance and QueueEntry remain independent;
- PAY_AT_FACILITY creates no PaymentIntent;
- patient does not self-check-in or self-reschedule;
- arrival window is not an exact doctor-entry promise;
- current UI is Arabic/RTL and phone-first.

## Design-document alignment

The documentation freezes 21 logical Patient screens and 142 High-Fidelity state variants. It explicitly defines Tier-A primitives and a separate Tier-B/domain component layer.

v1.3 closes the source-backed primitive gaps found in v1.2:

- `List row` → `AafiatakListRow`;
- `PrimaryActionBar` → `AafiatakPrimaryActionBar`;
- configurable accessible OTP → rebuilt `AafiatakOtpInput`;
- status block with optional supporting copy/action → expanded `AafiatakStatusBlock`;
- localizable visible Arabic copy → `gen-l10n` + `app_ar.arb`.

## Deliberate deferrals

The following are not missing foundation components:

- `PatientAppShell`: belongs to the app/routing shell when real primary destinations are implemented.
- `AsyncStateView`: not frozen as a generic wrapper because the approved state matrix contains nuanced stale/offline/refreshing states where preserving content matters; introduce only if a stable cross-feature API emerges.
- `FormFieldBlock`: current text/phone/OTP primitives already own persistent label/helper/error behavior; add a more general wrapper only when an actual non-text field requires it.
- `StatusMessage`: covered by `AafiatakStatusBlock`/`AafiatakBanner`; a duplicate primitive would add ambiguity.
- Tier-B Doctor/Booking/Appointment/Payment/Visit/Queue compositions: intentionally team-owned Domain Patterns.

## Conclusion

No additional clearly source-required **core/domain-neutral primitive** remains missing after v1.3. The next UI implementation work is Domain Pattern ownership + feature screens, not further speculative foundation expansion.
