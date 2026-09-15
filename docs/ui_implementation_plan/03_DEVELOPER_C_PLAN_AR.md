# خطة Developer C — Appointments + Visit + Auth

## بطاقة المهمة والفرع

- الفرع: `feature/patient-appointments-auth`.
- baseline: `2c130c407979fc555652ae643d19369f2f7aad0c`.
- الملكية: `features/appointments/**` و`features/visit/**` و`features/auth/**`.
- الشاشات: PAT-11، PAT-12، PAT-14، PAT-18، PAT-19، PAT-20، PAT-21.
- الحالات: `upcoming-populated`, `confirmed`, `checked-in-waiting/called/completed`, `default`, `idle`, `waiting`, `editing/success` = 10 حالات.
- الحمل: 21.0 نقطة تنفيذ + 1.5 QA/PR = **22.5**.
- Pilot: PAT-20 لأنه يختبر إدخال LTR داخل RTL وWidget OTP وإدارة controller/focus من دون توسيع حالات المنتج.

العقد canonical: الطبيب `doc-001 / د. سارة عبدالله`، المنشأة `fac-aafiatak-tahrir / مركز عافيتك التخصصي / فرع التحرير`، الخدمة `svc-family-consult / استشارة طب الأسرة / 15,000 ر.ي`، الموعد `apt-af-28931 / AF-28931 / الأربعاء 18 سبتمبر 2026 / 10:00 – 10:30`، المريض `pat-001 / أحمد بلال / أب / +[رمز الدولة] ••• ••15`، queue `3 / 12:04 م`. OTP length=6 fixture قابل للاستبدال، لا قرار منتج.

## حدود الملكية

### الملفات التي تملكها

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

### ممنوع لمسها

`lib/src/design_system/**`, `lib/src/app/**` وrouting، `lib/main.dart`, `pubspec.*`, `features/starter/**`, Features A/B، وكل High-Fidelity. لا تضف WhatsApp SDK أو auth service أو validation layer أو generated localization.

### عقد التنقل

لا تستورد router. Screens تستقبل callbacks: appointments→detail؛ detail→facility؛ visit constructor يأخذ `VisitQueueDemoState initialState`; auth chain يمرر `AuthIntent { login, register }` عبر constructors/callbacks؛ OTP login يخرج للرئيسية، وregister يخرج لـComplete Profile، وsuccess يخرج للرئيسية. الربط الفعلي مسؤولية Developer B بعد الدمج.

| route name | path | علاقتك به |
|---|---|---|
| `home` | `/` | auth success/browse destination يملكه A |
| `appointments` | `/appointments` | PAT-11 root |
| `appointmentDetails` | `/appointments/:appointmentId` | PAT-12، id=`apt-af-28931` |
| `facilityDetails` | `/facilities/:facilityId` | destination من PAT-12 يملكه A |
| `visitQueue` | `/appointments/:appointmentId/visit` | PAT-14، `state=waiting|called|completed` |
| `notifications` | `/notifications` | root app bar destination يملكه A |
| `profile` | `/profile` | root tab destination يملكه A |
| `authEntry` | `/auth` | PAT-18 |
| `phone` | `/auth/phone` | PAT-19، `intent=login|register` |
| `whatsappOtp` | `/auth/otp` | PAT-20، `intent=login|register` |
| `completeProfile` | `/auth/complete-profile` | PAT-21 |

`AuthIntent` يعرف في `lib/src/features/auth/auth_intent.dart` لأنه عقد صغير مستخدم عبر PAT-18..20، وليس app-wide state. قاعدة `Must Not Touch` أعلاه تنطبق على كل Task أدناه.

## التسلسل الصارم

### C-00 — تجهيز الفرع

- يعتمد على: اعتماد الخطة؛ `SHARED`.
- ينشئ/يعدل: لا شيء.
- نفذ fetch ثم `git switch -c feature/patient-appointments-auth 2c130c407979fc555652ae643d19369f2f7aad0c` ثم pub get/status.
- القبول: HEAD مطابق وشجرة نظيفة.
- commit: لا شيء.
- التالي: C-01.

### C-01 — Pilot: PAT-20 WhatsApp OTP

- الهدف: waiting state فقط مع إدخال OTP قابل للفهم والشرح.
- يعتمد على: C-00 `SHARED`؛ PAT-19/PAT-21/PAT-01 routes `SOFT`.
- المرجع: `PAT20.ts`, waiting، و`MOCK_FIXTURE_BOUNDARIES.md`.
- ينشئ: `lib/src/features/auth/auth_intent.dart`, `lib/src/features/auth/mock_data.dart`, `lib/src/features/auth/widgets/auth_intro.dart`, `lib/src/features/auth/widgets/otp_input.dart`, `lib/src/features/auth/widgets/verified_phone_summary.dart`, `lib/src/features/auth/screens/whatsapp_otp_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakButton`, DS spacing/typography/colors، Material `TextField`/focus primitives داخل OtpInput عند الحاجة.
- Feature Widgets: `AuthIntro` لأن intro يتكرر PAT-18..21؛ `OtpInput` لأنه تركيب خاص بعدة خلايا/Focus لكنه محصور في auth؛ `VerifiedPhoneSummary` لأن الهاتف الموثق يظهر في PAT-20 وPAT-21. لا يملك أي منها navigation.
- private: `_OtpActions` أو `_ResendInformation` داخل screen؛ لا تحولهما لملفات.
- Mock: masked phone وOTP display length=6، مع تعليق صريح أن length config fixture؛ static instructions في UI.
- الحالة: `StatefulWidget`; أبسط تنفيذ سليم: controller واحد رقمي مع عرض خلايا، أو FocusNodes محلية بعدد fixture؛ dispose للجميع. الواجهة كلها waiting فقط ولا تعرض invalid/verifying/verified/resend countdown.
- التنقل: entry PAT-19 مع `AuthIntent`; تغيير الرقم callback إلى PAT-19؛ verify callback يذهب حسب intent إلى PAT-21 أو home. زر resend ظاهر لكنه callback presentation-only أو null حسب التصميم، بلا Timer.
- القبول: 6 خلايا متساوية لا overflow عند 360px، code LTR داخل shell RTL، phone masked، WhatsApp فقط، لا SMS/password، touch targets مناسبة.
- التحقق: إدخال أرقام، keyboard، focus/backspace، screenshots 360/390، format/analyze.
- commit: `feat(auth): implement whatsapp otp pilot`.
- التالي: C-02.

### C-02 — Pilot Gate

- يعتمد على: C-01؛ `HARD`.
- ينشئ: لا شيء؛ يعدل ملفات C-01 فقط إن لزم.
- افحص public DS import، اتجاهات النص، lifecycle، عدم hard-code مدة/قاعدة OTP، no auth layer/no router import، no overflow.
- القبول: screenshot و`flutter analyze` نظيف وتجربة focus ناجحة.
- commit: squash أو `fix(auth): align otp pilot with rtl ui baseline`.
- التالي: C-03.

### C-03 — PAT-18 Auth Entry

- الهدف: default account access فقط.
- يعتمد على: C-01 AuthIntro/mock وC-02؛ `HARD`. PAT-19/PAT-01 `SOFT`.
- المرجع/الحالة: `PAT18.ts`, default.
- ينشئ: `lib/src/features/auth/screens/auth_entry_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakButton`, `AuthIntro`.
- private: `_PasswordlessInfoCard`, `_AuthActions`.
- Mock: لا domain fixture جديد؛ text ثابت.
- الحالة: `StatelessWidget`.
- التنقل: Login وCreate إلى phone callback مع `AuthIntent.login/register`؛ browse إلى home.
- القبول: شرح OTP الرسمي عبر WhatsApp، لا email/password/Forgot/SMS/social؛ الأزرار الثلاثة واضحة.
- التحقق: callbacks بالقيمتين، 360px، format/analyze.
- commit: يمكن جمعه مع C-04/C-05 `feat(auth): implement account access flow`.
- التالي: C-04.

### C-04 — PAT-19 Phone

- الهدف: idle phone entry دون حالات التحقق الأخرى.
- يعتمد على: C-01/C-02؛ `HARD`. PAT-20 `SOFT`.
- المرجع/الحالة: `PAT19.ts`, idle.
- ينشئ: `lib/src/features/auth/screens/phone_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakTextField`, `AafiatakCard`, `AafiatakButton`, `AuthIntro`.
- private: `_WhatsAppDeliveryCard`.
- Mock: neutral phone placeholder؛ `AuthIntent` constructor.
- الحالة: `StatefulWidget` مع phone controller وdispose، لكن لا editing/invalid/requesting/rate/provider UI. keyboard phone وtextDirection LTR.
- التنقل: PAT-18 entry؛ bottom action إلى PAT-20 callback محافظًا على intent.
- القبول: صيغة الهاتف غير مفترضة كسياسة بلد، WhatsApp wording صحيح، لا SMS/password، bottom action غير محجوب بالkeyboard.
- التحقق: keyboard/insets/controller وformat/analyze.
- commit: مع auth flow.
- التالي: C-05.

### C-05 — PAT-21 Complete Patient Profile

- الهدف: editing ينتقل محليًا إلى success.
- يعتمد على: C-01 widgets/mock وC-02؛ `HARD`. home route `SOFT`.
- المرجع/الحالات: `PAT21.ts`, editing وsuccess.
- ينشئ: `lib/src/features/auth/screens/complete_patient_profile_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakTextField`, `AafiatakCard`, `AafiatakStatusBlock`, `AafiatakButton`, `AuthIntro`, `VerifiedPhoneSummary`.
- private: `_SuccessContent` فقط.
- Mock: verified masked phone، initial full name أحمد بلال.
- الحالة: `StatefulWidget`، controller + enum private `_ProfileCompletionView { editing, success }`; CTA `setState(success)`؛ dispose صحيح؛ success لا يعرض form أو bottom action.
- التنقل: OTP register entry؛ success CTA إلى home callback.
- القبول: حقل الاسم فقط، phone verified readonly، success status؛ لا validation/creating/failure/duplicate.
- التحقق: transition مرتين عبر إعادة فتح الشاشة، keyboard، screenshots للحالتين، format/analyze.
- commit: `feat(auth): implement account access flow`.
- التالي: C-06.

### C-06 — PAT-11 Appointments

- الهدف: upcoming-populated root.
- يعتمد على: C-02؛ `HARD` pilot gate. PAT-12 وroot tabs `SOFT`.
- المرجع/الحالة: `PAT11.ts`, upcoming-populated.
- ينشئ: `lib/src/features/appointments/mock_data.dart`, `lib/src/features/appointments/widgets/appointment_list_card.dart`, `lib/src/features/appointments/screens/appointments_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.root`, `AafiatakCard`, `AafiatakBadge`, `AafiatakInfoRows`, `AafiatakButton`.
- Feature Widget: `AppointmentListCard` لأنه عنصر قائمة قد يتكرر داخل appointments ويحتوي status/rows/action؛ لا يصبح Pattern عالميًا لأن `AppointmentSummary` يغطي الملخص العام. private: لا شيء أو `_UpcomingHeader` إن احتاج.
- Mock: upcoming canonical appointment فقط.
- الحالة: `StatelessWidget`; لا past tab behavior ولا empty/loading.
- التنقل: root appointments tab؛ card إلى PAT-12، app bar إلى notifications، root tab callback.
- القبول: nav active appointments، بطاقة واحدة كاملة، no segmented interaction يقود لحالات محذوفة.
- التحقق: root nav و360px وformat/analyze.
- commit: يمكن جمعه مع C-07 `feat(appointments): implement appointment screens`.
- التالي: C-07.

### C-07 — PAT-12 Appointment Details

- الهدف: confirmed state مع فصل حالات الدفع والزيارة.
- يعتمد على: C-06 mock/widget؛ `HARD`. PAT-05 `SOFT`.
- المرجع/الحالة: `PAT12.ts`, confirmed.
- ينشئ: `lib/src/features/appointments/screens/appointment_details_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakBadge`, `AafiatakInfoRows`, `AafiatakStatusBlock`, `AafiatakButton`, `PolicyCard`.
- private: `_BookingProofCard`, `_DomainStatusSection`.
- Mock: appointment، booking number، paid status، visit before-arrival.
- الحالة: `StatelessWidget`.
- التنقل: home/confirmation/appointments/notification entry؛ facility direction callback. لا cancel callback لأن cancelled state خارج scope.
- القبول: appointment confirmed، QR/number، payment وvisit blocks منفصلة، staff-only check-in، Arrival Window disclaimer، لا cancel/manual-late/offline variants.
- التحقق: booking number LTR، long scroll، format/analyze.
- commit: `feat(appointments): implement appointment screens`.
- التالي: C-08.

### C-08 — PAT-14 Visit Queue

- الهدف: ثلاث حالات waiting/called/completed في شاشة واحدة دون self-check-in.
- يعتمد على: C-02؛ `HARD` pilot gate. appointment route/notification `SOFT`.
- المرجع/الحالات: `PAT14.ts`, checked-in-waiting, called, completed.
- ينشئ: `lib/src/features/visit/mock_data.dart`, `lib/src/features/visit/screens/visit_queue_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakStatusBlock`, `AafiatakCard`, `AafiatakNotice`, `AafiatakSectionHeading`, `AppointmentSummary`, `ArrivalWindowCard`.
- Feature-local: لا ملف؛ `_QueueMetrics`, `_CalledQueuePanel`, `_LastUpdateCard` private لشاشة واحدة.
- Mock: appointment subset مطابق، approximateAhead=3، last update 12:04، called copy.
- الحالة: `StatefulWidget` مع enum في ملف الشاشة `VisitQueueDemoState { waiting, called, completed }` وconstructor `initialState`; لا Widget controls لتغيير state داخل UI النهائي. يمكن أثناء التطوير تغيير initialState مؤقتًا ثم إزالته؛ router query سيعرض الحالات.
- التنقل: PAT-12/queue notification entry؛ لا outbound action مطلوب.
- القبول: waiting يعرض 3 ووقت التحديث؛ called يعرض burgundy callout ولا يحول تلقائيًا إلى in-service؛ completed يعرض اكتمال الزيارة؛ لا check-in/reschedule/rejoin buttons.
- التحقق: screenshots للحالات الثلاث، query-ready constructors، 360px، format/analyze.
- commit: `feat(visit): implement selected queue states`.
- التالي: C-09.

### C-09 — Feature QA

- يعتمد على: C-03..C-08؛ `HARD`.
- ينشئ: لا شيء؛ يعدل ملفات C فقط.
- افحص 7 screens/10 states، root/details shells، OTP/phone directions، controller disposal، queue semantics، canonical data، callbacks، وعدم وجود حالات محذوفة.
- `rg "go_router|app_routes|Repository|Service|Provider|Bloc|SMS|password" lib/src/features/appointments lib/src/features/visit lib/src/features/auth`؛ افحص النتائج النصية المشروعة في copy فقط مثل «لا توجد كلمة مرور أو SMS» ولا APIs.
- commit: `fix(ui): polish appointments visit and auth` عند الحاجة.
- التالي: C-10.

### C-10 — Validation Gate

- يعتمد على: C-09؛ `HARD`.
- شغل format على Features المملوكة ثم format check لكل lib، `flutter analyze`, debug APK إن متاح، `git diff --check`, status.
- القبول: نجاح كامل وdiff محصور بالملفات الخمسة عشر المملوكة.
- commit: لا commit منفصل إلا إصلاح.
- التالي: C-11.

### C-11 — PR Ready

- يعتمد على: C-10؛ `HARD`.
- PR: `feature/patient-appointments-auth → develop`، مع PAT/cases، Pilot PAT-20، screenshots لـPAT-14 الثلاث وPAT-21 الحالتين، ونتائج validation.
- راجع `git diff 2c130c4...HEAD --name-only` وHigh-Fidelity diff يجب أن يكون فارغًا.
- CodeRabbit fixes على الفرع نفسه؛ لا تعدل router أو Feature زميل.
- branch ready عند checks نظيفة، threads محلولة، وconstructor/callback contract موثق.
- commit إصلاح: `fix(ui): address review feedback for appointments auth scope`.
- التالي: بعد الدمج يسلم route constructors إلى Developer B؛ لا يعمل على integration branch.

## PR checklist

- [ ] 7 شاشات و10 حالات فقط.
- [ ] PAT-20 Pilot يثبت LTR/RTL وfocus/dispose.
- [ ] PAT-14 ثلاث حالات فقط ولا self-check-in/reschedule.
- [ ] PAT-18..20 WhatsApp OTP فقط؛ لا SMS/password/email/social.
- [ ] PAT-21 editing/success فقط، حقل الاسم وحده.
- [ ] لا router/shared/high-fidelity changes.
- [ ] canonical mock values مطابقة ولا ملف mock عالمي.
- [ ] لا Widget fragmentation: ثلاثة auth widgets وAppointmentListCard فقط؛ بقية الأقسام private.
- [ ] format/analyze/build وvisual QA ناجحة.
- [ ] PR إلى develop وCodeRabbit fixes على الفرع نفسه.
