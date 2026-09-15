# خطة Developer C — Appointments + Visit + Auth

## 1. بطاقة المهمة

- الفرع: `feature/patient-appointments-auth`.
- **Inspected Baseline:** `2c130c407979fc555652ae643d19369f2f7aad0c` للمرجعية فقط.
- **Implementation Baseline:** `<IMPLEMENTATION_BASELINE_SHA>` بعد دمج PR التخطيط.
- الملكية: `features/appointments/**`, `features/visit/**`, `features/auth/**`.
- الشاشات: PAT-11، PAT-12، PAT-14، PAT-18، PAT-19، PAT-20، PAT-21.
- الحالات: **10**.
- الحمل: 21.0 تنفيذ + 1.5 QA/PR = **22.5**.
- Pilot: PAT-20.

## 2. Retained-State Visual Fidelity

لا تحذف controls الموجودة في الحالة المختارة حتى لو كانت نتيجتها حالة غير مختارة:

- PAT-11 upcoming-populated: Segmented control «القادمة / السابقة» يبقى ظاهرًا؛ لا تبني past state.
- PAT-12 confirmed: زر «إلغاء الموعد» يبقى ظاهرًا؛ لا تبني cancelled state.
- PAT-20 waiting: تغيير الرقم، إعادة الإرسال، والتحقق تبقى ظاهرة؛ لا Timer ولا verifying/verified states.

## 3. Mock canonical

- Doctor `doc-001 / د. سارة عبدالله`.
- Facility `fac-aafiatak-tahrir / مركز عافيتك التخصصي / فرع التحرير`.
- Service `svc-family-consult / استشارة طب الأسرة / 15,000 ر.ي`.
- Appointment `apt-af-28931 / AF-28931 / الجمعة 18 سبتمبر 2026 / 10:00 – 10:30`.
- Patient `pat-001 / أحمد بلال / أب / +[رمز الدولة] ••• ••15`.
- Queue `3 / 12:04 م`.
- OTP length=6 fixture presentation فقط.

## 4. الملفات التي تملكها

```text
lib/src/features/appointments/mock_data.dart
lib/src/features/appointments/screens/appointments_screen.dart
lib/src/features/appointments/screens/appointment_details_screen.dart
lib/src/features/appointments/widgets/appointment_list_card.dart
lib/src/features/visit/mock_data.dart
lib/src/features/visit/screens/visit_queue_screen.dart
lib/src/features/auth/auth_intent.dart
lib/src/features/auth/mock_data.dart
lib/src/features/auth/screens/auth_entry_screen.dart
lib/src/features/auth/screens/phone_screen.dart
lib/src/features/auth/screens/whatsapp_otp_screen.dart
lib/src/features/auth/screens/complete_patient_profile_screen.dart
lib/src/features/auth/widgets/auth_intro.dart
lib/src/features/auth/widgets/otp_input.dart
lib/src/features/auth/widgets/verified_phone_summary.dart
```

ممنوع `lib/src/app/**`, Design System, main, pubspec, starter, Features A/B، وHigh-Fidelity. لا WhatsApp SDK ولا auth service ولا SMS/password/email/social أو generated localization.

## 5. Public Contracts

- PAT-11 `AppointmentsScreen`: appointment callback + notifications + rootTab + `onPastRequested` presentation-only.
- PAT-12 `AppointmentDetailsScreen`: `appointmentId` + facility/showQr/cancelRequested callbacks؛ cancel presentation-only.
- PAT-14 `VisitQueueScreen`: `VisitQueueDemoState initialState` بقيم waiting/called/completed. الحالة الخارجية canonical `checked-in-waiting` تتحول إلى القيمة المحلية `waiting`.
- PAT-18 `AuthEntryScreen`: `ValueChanged<AuthIntent> onPhoneRequested`, `onBrowseTap`.
- PAT-19 `PhoneScreen`: `AuthIntent`, `onOtpRequested`.
- PAT-20 `WhatsAppOtpScreen`: `AuthIntent`, changePhone/verifyRequested/resendRequested callbacks.
- PAT-21 `CompletePatientProfileScreen`: `onFinished`; editing→success محلي.

Feature files لا تستورد router. B يربطها بعد الدمج.

## 6. Routes

- `/` home، وجهة auth success/browse.
- `/appointments` PAT-11.
- `/appointments/:appointmentId` PAT-12.
- `/facilities/:facilityId` وجهة من PAT-12 يملكها A.
- `/appointments/:appointmentId/visit` PAT-14؛ `state`: checked-in-waiting أو called أو completed، default checked-in-waiting. في integration يحول B `checked-in-waiting` إلى `VisitQueueDemoState.waiting` صراحةً.
- `/notifications` وجهة root app bar يملكها A.
- `/profile` root tab يملكه A.
- `/auth` PAT-18.
- `/auth/phone` PAT-19؛ `intent`: login أو register، default login.
- `/auth/otp` PAT-20؛ `intent`: login أو register، default login.
- `/auth/complete-profile` PAT-21.

## 7. التسلسل الصارم

### C-00 — تجهيز الفرع

- يعتمد على دمج الخطة وإعلان `IMPLEMENTATION_BASELINE_SHA`; `SHARED`.

```bash
git fetch --all --prune
git switch -c feature/patient-appointments-auth <IMPLEMENTATION_BASELINE_SHA>
git status
git rev-parse HEAD
flutter pub get
```

- القبول: HEAD مطابق وشجرة نظيفة.
- commit: لا شيء.
- التالي: C-01.

### C-01 — Pilot: PAT-20 WhatsApp OTP

- الحالة: `waiting` فقط.
- ينشئ: `auth/auth_intent.dart`, `auth/mock_data.dart`, `auth/widgets/auth_intro.dart`, `auth/widgets/otp_input.dart`, `auth/widgets/verified_phone_summary.dart`, `auth/screens/whatsapp_otp_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Card, Button، DS spacing/typography/colors، Material text/focus primitives داخل OtpInput.
- `AuthIntro`: يتكرر PAT-18 إلى PAT-21.
- `OtpInput`: تركيب خاص بالAuth، لا يوسع AafiatakTextField.
- `VerifiedPhoneSummary`: يتكرر PAT-20 وPAT-21.
- private: `_OtpActions` أو `_ResendInformation` فقط إذا حسنت القراءة.
- state: StatefulWidget؛ controller واحد أو FocusNodes بسيطة، dispose للجميع.
- direction: code LTR داخل shell RTL.
- **Retained-State Fidelity:** change-number، resend، bottom verify visible. `onResendRequested` presentation-only بلا Timer؛ verify يستدعي callback مباشرة في demo ولا يعرض verifying/verified UI.
- WhatsApp فقط؛ لا SMS/password.
- القبول: 6 خلايا لا overflow 360px، touch targets سليمة، masked phone.
- screenshots 360/390.
- commit: `feat(auth): implement whatsapp otp pilot`.
- التالي: C-02.

### C-02 — Pilot Gate

- يعتمد C-01؛ `HARD`.
- يفحص public DS import، RTL/LTR، focus/lifecycle، no auth layer/no router/no timer، scrolling، no overflow.
- analyze نظيف.
- commit عند الحاجة: `fix(auth): align otp pilot with rtl ui baseline`.
- التالي: C-03.

### C-03 — PAT-18 Auth Entry

- الحالة: `default`.
- ينشئ: `auth_entry_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Card, Button, AuthIntro.
- private: `_PasswordlessInfoCard`, `_AuthActions`.
- Login/Create يرسلان `AuthIntent.login/register` إلى `onPhoneRequested`; browse إلى home.
- القبول: OTP WhatsApp الرسمي واضح، لا email/password/Forgot/SMS/social.
- التالي: C-04.

### C-04 — PAT-19 Phone

- الحالة: `idle` فقط.
- ينشئ: `phone_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, TextField, Card, Button, AuthIntro.
- StatefulWidget مع phone controller وdispose؛ textDirection LTR وkeyboard phone.
- CTA إلى `onOtpRequested` مع الحفاظ على AuthIntent في constructor.
- لا validation/requesting/provider/rate/identity states.
- القبول: WhatsApp wording، keyboard لا يحجب bottom action.
- التالي: C-05.

### C-05 — PAT-21 Complete Patient Profile

- الحالات: `editing`, `success`.
- ينشئ: `complete_patient_profile_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, TextField, Card, StatusBlock, Button, AuthIntro, VerifiedPhoneSummary.
- private: `_SuccessContent`.
- StatefulWidget + enum private `_ProfileCompletionView`; CTA editing يعمل `setState(success)`، success CTA يستدعي `onFinished`.
- حقل الاسم فقط، phone verified readonly.
- لا validation/creating/failure/duplicate states.
- commit auth group: `feat(auth): implement account access flow`.
- التالي: C-06.

### C-06 — PAT-11 Appointments

- الحالة: `upcoming-populated`.
- ينشئ: `appointments/mock_data.dart`, `appointments/widgets/appointment_list_card.dart`, `appointments/screens/appointments_screen.dart`.
- يستخدم: `PatientShell.root(scrollable:true)`, Card, Badge, InfoRows, Button، Material segmented control حسب Theme.
- `AppointmentListCard`: feature-local.
- **Retained-State Fidelity:** Segmented «القادمة / السابقة» يبقى ظاهرًا مع القادمة selected. `onPastRequested` presentation-only؛ لا تنفذ past-populated/past-empty.
- root nav appointments active، notification/rootTab callbacks.
- القبول: بطاقة الموعد canonical، لا loading/empty/refresh/offline.
- commit مع C-07: `feat(appointments): implement appointment screens`.
- التالي: C-07.

### C-07 — PAT-12 Appointment Details

- الحالة: `confirmed`.
- ينشئ: `appointment_details_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Card, Badge, InfoRows, StatusBlock, Button, PolicyCard.
- private: `_BookingProofCard`, `_DomainStatusSection`.
- يعرض appointment/payment/visit blocks منفصلة وتعليمات الوصول وstaff-only check-in.
- **Retained-State Fidelity:** زر «إلغاء الموعد» destructive يبقى ظاهرًا ويستدعي `onCancelRequested` presentation-only؛ لا cancelled state. زر QR والاتجاهات يبقيان.
- callback facility إلى PAT-05.
- لا manual-late/payment-variants/visit-queue-variants/loading/offline.
- القبول: booking number LTR، long scroll بلا overflow.
- commit: `feat(appointments): implement appointment screens`.
- التالي: C-08.

### C-08 — PAT-14 Visit Queue

- الحالات الخارجية المعتمدة: `checked-in-waiting`, `called`, `completed`.
- ينشئ: `visit/mock_data.dart`, `visit/screens/visit_queue_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, StatusBlock, Card, Notice, SectionHeading, AppointmentSummary, ArrivalWindowCard.
- private: `_QueueMetrics`, `_CalledQueuePanel`, `_LastUpdateCard`.
- public enum في الملف `VisitQueueDemoState { waiting, called, completed }` وconstructor `initialState`.
- mapping المقصود: HF/route `checked-in-waiting` → `VisitQueueDemoState.waiting`; `called` → `.called`; `completed` → `.completed`. لا تستخدم parsing مباشرًا لاسم enum.
- لا developer controls ظاهرة لتبديل state؛ route query يعرضها بعد integration.
- waiting يعرض approximateAhead=3 وlast update؛ called callout؛ completed status فقط.
- لا check-in/reschedule/rejoin buttons.
- commit: `feat(visit): implement selected queue states`.
- التالي: C-09.

### C-09 — Feature QA

- يفحص 7 Screens و10 States.
- Retained-State Fidelity: PAT-11 segmented، PAT-12 cancel، PAT-20 resend/change/verify.
- يفحص controllers/focus disposal، canonical date، queue semantics، callbacks، scroll 360/390.
- `rg "go_router|app_routes|Repository|Service|Provider|Bloc"` لا يظهر اعتمادًا ممنوعًا؛ ظهور كلمات SMS/password داخل copy النفي مسموح.
- commit عند الحاجة: `fix(ui): polish appointments visit and auth`.
- التالي: C-10.

### C-10 — Validation Gate

- format Features C ثم format check لكل lib.
- `flutter analyze`.
- debug APK إذا متاح.
- `git diff --check`, status.
- القبول: diff محصور بملفات C.
- التالي: C-11.

### C-11 — PR Ready

- PR `feature/patient-appointments-auth → develop`.
- يذكر `IMPLEMENTATION_BASELINE_SHA`, 7 Screens, 10 States، Pilot PAT-20، screenshots لـPAT-14 الثلاث وPAT-21 الحالتين.
- CodeRabbit fixes على نفس الفرع.
- لا router/shared/HF changes.
- commit review: `fix(ui): address review feedback for appointments auth scope`.

## 8. PR Checklist

- [ ] 7 Screens، 10 States فقط.
- [ ] PAT-20 Pilot يثبت LTR/RTL وfocus/dispose والcontrols المرئية كاملة.
- [ ] PAT-11 segmented control ظاهر بلا past state.
- [ ] PAT-12 cancel button ظاهر بلا cancelled state.
- [ ] PAT-14 ثلاث حالات خارجية فقط: `checked-in-waiting`, `called`, `completed`، مع mapping صريح إلى enum المحلي `waiting/called/completed`.
- [ ] Auth WhatsApp OTP فقط؛ لا SMS/password/email/social implementation.
- [ ] PAT-21 editing/success فقط وحقل الاسم وحده.
- [ ] canonical date = الجمعة 18 سبتمبر 2026.
- [ ] no router/shared/HF changes.
- [ ] constructor contracts مطابقة للMaster.
- [ ] format/analyze/build وvisual QA ناجحة.
- [ ] CodeRabbit threads محلولة.