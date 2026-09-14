# Mock Fixture Boundaries

This High-Fidelity package is a **frontend-only coded prototype**. Mock values exist only to make states visually reviewable.

## Not product requirements

- **ReservationHold duration / countdown** — the product decision remains open. Review captures inject example remaining times such as `04:18` or `00:42`; the UI source reads a configurable runtime value.
- **WhatsApp OTP length** — the exact OTP length remains open. Review captures inject a six-cell example; the screen generates cells from runtime configuration.
- **Phone country/format policy** — not frozen. The screens use neutral placeholders such as `+[رمز الدولة] [رقم الهاتف]`.
- **Payment provider/card UI** — no provider-specific card form is invented. PAT-08 only models the handoff and return/recovery states.
- **Map provider** — no specific provider is frozen. PAT-05 uses a neutral location preview.
- **Availability freshness duration / reminder timing / alert anti-spam timings** — not hard-coded into the UI.

These examples are presentation fixtures only and must not be copied into backend business rules.
