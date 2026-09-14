# Nielsen Heuristic Evaluation — Aafiatak Patient High-Fidelity v2.0

**Scope:** 21 phone screens and 142 implemented UI state variants.  
**Method:** Expert review of coded prototype + rendered screenshots after the final refinement pass.  
**Severity scale:** 0–4.

| Heuristic | Result | Evidence / rationale |
|---|---|---|
| 1. Visibility of system status | PASS | Hold, payment, booking, visit, queue, loading, pending, offline and error states are explicit and independently labeled. |
| 2. Match between system and real world | PASS | Arabic patient language is used; `نافذة الوصول` is explained as arrival period rather than exact doctor-entry time. |
| 3. User control and freedom | PASS | Back/retry/return paths are visible; cancellation is available only in its allowed context; stale deep links do not replay actions automatically. |
| 4. Consistency and standards | PASS | Shared buttons/cards/status patterns, bottom navigation, search, forms, back behavior and semantic colors are consistent across screens. |
| 5. Error prevention | PASS | Invalid inputs, expired holds, stale availability, duplicate OTP submissions, payment uncertainty and destructive cancellation consequences are prevented or surfaced before unsafe action. |
| 6. Recognition rather than recall | PASS | Current status, doctor/service/facility context, booking number, payment/queue state and available actions remain visible near the task. |
| 7. Flexibility and efficiency | PASS for MVP | The flow avoids unnecessary advanced controls and preserves user intent across authentication. No expert-only shortcuts are required for the patient MVP. |
| 8. Aesthetic and minimalist design | PASS | One dominant action, restrained surfaces, limited status color, controlled density and no unrelated deferred features. |
| 9. Help users recognize, diagnose and recover from errors | PASS | Errors state what happened and provide a concrete retry/back/change-number/return-to-availability path without blame. |
| 10. Help and documentation | PASS for task context | Arrival/payment/refund/OTP/queue guidance is embedded contextually at the point of need rather than through a generic help layer. |

## Severity findings after final refinement

- **Severity 4:** 0 open
- **Severity 3:** 0 open
- **Severity 2:** 0 open in the High-Fidelity design baseline
- **Severity 1:** 0 required design changes before Flutter implementation

## Items intentionally deferred to later validation

These are not High-Fidelity design defects:
- real-user usability testing;
- VoiceOver/TalkBack testing on the Flutter build;
- final payment-provider-specific screens after provider selection;
- final map-provider behavior after integration selection;
- real-device typography verification with the approved IBM Plex Sans Arabic asset;
- backend concurrency/freshness behavior.
