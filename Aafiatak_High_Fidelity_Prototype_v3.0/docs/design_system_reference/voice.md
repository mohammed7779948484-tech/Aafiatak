# Aafiatak Product Voice — Patient UI v1.0

## Voice

**Clear, calm, respectful, specific.** Arabic copy should help the patient act confidently without sounding bureaucratic, promotional, or overly casual.

## Tone by context

- **Discovery:** welcoming and concise.
- **Booking:** precise and task-oriented.
- **Payment:** factual and reassuring; never imply success before trusted verification.
- **Errors:** explain what happened and what to do next without blame.
- **Queue/service day:** direct and operational.
- **Cancellation/refund:** explicit about consequence and current state.

## Copy rules

- Prefer action verbs: `احجز موعدًا`, `عرض التوفر`, `تأكيد والمتابعة`.
- Use patient language rather than raw enums or internal domain names.
- Explain `نافذة الوصول` as an arrival period, not an exact doctor-entry time.
- Never say an availability alert reserved a seat or priority.
- Never say payment succeeded until trusted payment state supports it.
- Do not use passwords/SMS wording in the approved WhatsApp OTP flow.
- Currency presentation: Yemeni Rial `ر.ي`; underlying code/value can use `YER`.
- Critical state messages use a short heading plus one next-step sentence.

## Avoid

- Marketing superlatives inside transactional UI.
- Technical error codes as the primary message.
- Vague CTAs such as `إرسال` or `متابعة` when a more specific outcome is known.
- Excessive exclamation marks.
- Shame/blame language.
