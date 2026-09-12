# Delivery manifest — Aafiatak Flutter foundation v1.3

## Delivered

- feature-first Flutter application shell;
- first-class `design_system/` boundary (no `core/` wrapper);
- Aafiatak Material 3 foundations/theme;
- complete documented domain-neutral/Tier-A primitive surface;
- v1.3 additions: `AafiatakListRow`, `AafiatakPrimaryActionBar`, rebuilt configurable OTP, expanded StatusBlock/PhoneField;
- Arabic-first Flutter `gen-l10n` resources;
- strict `shared/media/` infrastructure boundary;
- development-only starter screen;
- Design System, accessibility/RTL, media and app-shell tests;
- static Design System + architecture audits;
- source-alignment, component-coverage, per-component usage contracts and team-readiness documentation.

## Deliberately absent

- Domain Patterns (Doctor/Booking/Appointment/Payment/Visit/Queue etc.);
- production Patient screens;
- real backend/repositories/providers;
- payment or WhatsApp provider integration;
- unresolved OTP/hold/reminder numeric policy;
- native platform shells/package identifiers;
- font binaries.

These absences are deliberate scope boundaries, not forgotten implementation.
