# Flutter Handoff — High-Fidelity v2.0

## Implementation intent

The coded prototype is a **visual and behavior reference**, not the production technology stack. The production frontend remains Flutter.

Recommended mapping:

| Prototype concept | Flutter target |
|---|---|
| CSS semantic colors | `ColorScheme` + Aafiatak `ThemeExtension` |
| Typography roles | `TextTheme` / named Aafiatak text styles |
| Spacing/radius tokens | Dart token constants / theme extensions |
| `.button` variants | Aafiatak button widgets |
| `statusBlock()` | domain-neutral status panel widget |
| `doctorCard()` | DoctorCard widget |
| `serviceCard()` | ServiceCard widget |
| `appointmentSummary()` | AppointmentSummary widget |
| `holdBanner()` | ReservationHoldBanner widget |
| PAT screen state string | typed view-state / scenario enum |
| mock fixtures | repository/service mock implementation |

## Architecture boundary

`Screen/Widgets → Feature View State → Controller/Use-case Boundary → Repository Interface → Mock Repository now → Real Backend later`

Widgets should consume resolved view models and `allowedActions`; they should not recreate backend business truth from raw status strings.

## Critical implementation guardrails

- Do not merge Appointment, PaymentIntent, VisitInstance, QueueEntry, or ReservationHold state into one enum.
- No patient self-check-in.
- No patient self-reschedule.
- No exact doctor-entry time picker.
- No arbitrary ArrivalGroup picker.
- PAY_AT_FACILITY creates no PaymentIntent UI object.
- Payment success does not automatically imply appointment confirmation unless the trusted booking state says so.
- Availability alerts are interest only, not reservation or priority.
- Accepted late arrival remains manual handling without a guaranteed numeric queue position.
- Currency presentation is Yemeni Rial (`ر.ي`, `YER`).

## Typography

Load **IBM Plex Sans Arabic** in Flutter according to the approved Design System. The sandbox screenshots used the installed fallback when IBM Plex Sans Arabic was unavailable; spacing and layout were designed to tolerate normal Arabic font-metric variation, but Flutter must receive a final real-device typography QA pass.
