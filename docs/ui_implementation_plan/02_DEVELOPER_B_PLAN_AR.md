# خطة Developer B — Booking + Payment + Route Integration

## بطاقة المهمة والفرع

- فرع التنفيذ: `feature/patient-booking-payment`.
- baseline: `2c130c407979fc555652ae643d19369f2f7aad0c`.
- فرع التكامل اللاحق: `integration/patient-ui-navigation` من أحدث `develop` بعد دمج PRs الثلاثة.
- الملكية على فرع التنفيذ: `features/booking/**` و`features/payment/**`.
- الشاشات: PAT-06، PAT-07، PAT-10، PAT-08، PAT-09، PAT-13.
- الحالات: `bookable/no-capacity`, `pre-hold-review/active-hold`, `confirmed-paid/confirmed-pay-at-facility`, `ready`, `success-confirmed`, `succeeded` = 9 حالات.
- الحمل: 17.5 تنفيذ + 1.5 QA/PR + 2.5 تكامل routing = **21.5**.
- Pilot: PAT-07 لأنه يثبت local state وفصل ReservationHold عن الموعد والدفع.

العقد canonical: الطبيب `doc-001 / د. سارة عبدالله`، المنشأة `fac-aafiatak-tahrir / مركز عافيتك التخصصي / فرع التحرير`، الخدمة `svc-family-consult / استشارة طب الأسرة / 15,000 ر.ي`، الموعد `apt-af-28931 / AF-28931 / الأربعاء 18 سبتمبر 2026 / 10:00 – 10:30`، الدفع `PAY-2026-1847 / YER`. العد `09:42` fixture بصري فقط، وليس مدة منتج.

## حدود الملكية

### تملك على فرع التنفيذ

```text
lib/src/features/booking/mock_data.dart
lib/src/features/booking/screens/availability_screen.dart
lib/src/features/booking/screens/booking_review_screen.dart
lib/src/features/booking/screens/booking_confirmation_screen.dart
lib/src/features/booking/widgets/availability_day_tile.dart
lib/src/features/payment/mock_data.dart
lib/src/features/payment/screens/payment_screen.dart
lib/src/features/payment/screens/payment_result_screen.dart
lib/src/features/payment/screens/payment_details_screen.dart
lib/src/features/payment/widgets/payment_receipt.dart
```

### تملك على فرع التكامل فقط

`lib/src/app/routing/app_routes.dart` و`lib/src/app/routing/app_router.dart`.

### ممنوع لمسها على فرع التنفيذ

كل `lib/src/app/**`، `design_system/**`، `main.dart`، `pubspec.*`، `features/starter/**`، Features A/C، وHigh-Fidelity. على integration branch لا تعدل Feature files؛ إذا كان callback ناقصًا، أعد PR لصاحبه بدل patch جانبي.

### عقد التنقل

Feature Screens تستقبل callbacks ولا تستورد router. التدفق: PAT-06 `onReviewTap`؛ PAT-07 يبدل داخليًا إلى active hold ثم `onPaymentTap`؛ PAT-08 `onPaymentResultTap`؛ PAT-09 `onConfirmationTap`؛ PAT-10 callbacks للموعد والمنشأة والرئيسية؛ PAT-13 callback للموعد. query الوحيد داخل ملكيتك هو PAT-10 `policy=paid|facility`، ويُحوّل في router إلى constructor enum.

| route name | path | PAT/default |
|---|---|---|
| `home` | `/` | PAT-01؛ audience patient |
| `search` | `/search` | PAT-02 |
| `doctorDetails` | `/doctors/:doctorId` | PAT-03 |
| `serviceDetails` | `/services/:serviceId` | PAT-04 |
| `facilityDetails` | `/facilities/:facilityId` | PAT-05 |
| `availability` | `/availability` | PAT-06؛ bookable |
| `bookingReview` | `/booking/review` | PAT-07؛ preHoldReview |
| `payment` | `/payment` | PAT-08 |
| `paymentResult` | `/payment/result` | PAT-09 |
| `bookingConfirmation` | `/booking/confirmation` | PAT-10؛ `policy=paid|facility`، default paid |
| `appointments` | `/appointments` | PAT-11 |
| `appointmentDetails` | `/appointments/:appointmentId` | PAT-12 |
| `paymentDetails` | `/appointments/:appointmentId/payment` | PAT-13 |
| `visitQueue` | `/appointments/:appointmentId/visit` | PAT-14؛ `state=waiting|called|completed`، default waiting |
| `notifications` | `/notifications` | PAT-15 |
| `profile` | `/profile` | PAT-16 |
| `editProfile` | `/profile/edit` | PAT-17 |
| `authEntry` | `/auth` | PAT-18 |
| `phone` | `/auth/phone` | PAT-19؛ `intent=login|register` |
| `whatsappOtp` | `/auth/otp` | PAT-20؛ `intent=login|register` |
| `completeProfile` | `/auth/complete-profile` | PAT-21 |

IDs الممررة هي `doc-001`, `svc-family-consult`, `fac-aafiatak-tahrir`, `apt-af-28931`. قاعدة `Must Not Touch` أعلاه تنطبق على كل Task؛ الاستثناء الوحيد هو B-11/B-12 لملفي router المحددين.

## التسلسل الصارم

### B-00 — تجهيز فرع التنفيذ

- يعتمد على: اعتماد الخطة؛ `SHARED`.
- ينشئ/يعدل: لا شيء.
- نفذ fetch ثم `git switch -c feature/patient-booking-payment 2c130c407979fc555652ae643d19369f2f7aad0c`، ثم pub get/status.
- القبول: HEAD مطابق وشجرة نظيفة.
- commit: لا شيء.
- التالي: B-01.

### B-01 — Pilot: PAT-07 Booking Review

- الهدف: pre-hold-review ينتقل محليًا إلى active-hold دون backend/Timer.
- يعتمد على: B-00 `SHARED`؛ PAT-08 route `SOFT`.
- المرجع: `PAT07.ts` للحالتين المعتمدتين.
- ينشئ: `lib/src/features/booking/mock_data.dart`, `lib/src/features/booking/screens/booking_review_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakBadge`, `AafiatakNotice`, `AafiatakButton`, `AppointmentSummary`, `ReservationHoldBanner`, `PolicyCard`.
- Feature-local: لا ملف. private: `_BookingAmountBlock`.
- Mock: selection canonical، amount، full-payment policy، countdown display `09:42` مع تعليق أنه fixture.
- الحالة: `StatefulWidget` وenum private `_BookingReviewView { preHoldReview, activeHold }`; أول CTA `setState` فقط، ثم يتغير النص إلى «الانتقال إلى الدفع» ويستدعي callback.
- التنقل: PAT-06 entry؛ active only → PAT-08 callback.
- ملاحظات: لا تنشئ `ReservationHold` domain service، ولا Timer، ولا توحّد hold/appointment/payment.
- القبول: appointment summary والسياسة والمبلغ في الحالتين؛ banner/notice فقط في active; لا acquiring/expired/loss/offline.
- التحقق: screenshots الحالتين 360/390، bottom action ثابت بلا حجب، format/analyze.
- commit: `feat(booking): implement booking review pilot states`.
- التالي: B-02.

### B-02 — Pilot Gate

- يعتمد على: B-01؛ `HARD`.
- ينشئ: لا شيء؛ يعدل B-01 فقط إن لزم.
- افحص RTL، public DS import، local enum، state transition، no timer/no route import، canonical data، no overflow.
- القبول: صور الحالتين و`flutter analyze` نظيف.
- commit: squash صغير أو `fix(booking): align booking review pilot`.
- التالي: B-03.

### B-03 — PAT-06 Availability

- الهدف: bookable/no-capacity باختيار يوم بسيط.
- يعتمد على: B-01 booking mock وB-02؛ `HARD`. PAT-07 callback `SOFT`.
- المرجع/الحالات: `PAT06.ts`, bookable وno-capacity.
- ينشئ: `lib/src/features/booking/widgets/availability_day_tile.dart`, `lib/src/features/booking/screens/availability_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakSectionHeading`, `AafiatakNotice`, `AafiatakButton`, `AppointmentSummary`, `ArrivalWindowCard`, Material buttons/chips.
- Feature Widget: `AvailabilityDayTile` لسبعة أيام متكررة، presentation-only، callbacks/selected/enabled؛ محلي لـbooking لأنه ليس calendar عام. private: `_AvailabilityCalendar`.
- Mock: أيام 14–20 وحالة كل يوم؛ 18 selected؛ arrival window canonical؛ no-capacity message.
- الحالة: `StatefulWidget` + enum private `_AvailabilityView { bookable, noCapacity }`; اختيار available يعرض bookable، واليوم غير المتاح يعرض noCapacity. لا state آخر.
- التنقل: doctor/service/home entry؛ CTA bookable إلى PAT-07؛ no-capacity CTA يبقى داخل الشاشة أو يختار يومًا آخر، ولا ينفذ alert subscription.
- القبول: اختيار يوم فقط، لا time/group picker؛ no-capacity لا يعرض وقتًا صالحًا ويظهر notice؛ Arrival Window ليست وقت دخول.
- التحقق: tap semantics وscroll/bottom action وformat/analyze.
- commit: يمكن جمعه مع B-04 `feat(booking): implement availability and confirmation screens`.
- التالي: B-04.

### B-04 — PAT-10 Booking Confirmation

- الهدف: confirmed paid وpay-at-facility في وجهة واحدة.
- يعتمد على: B-01 mock وB-02؛ `HARD`. PAT-12/PAT-05/PAT-01 `SOFT`.
- المرجع/الحالات: `PAT10.ts`, الحالتان كاملتان.
- ينشئ: `lib/src/features/booking/screens/booking_confirmation_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakBadge`, `AafiatakButton`, `AafiatakStatusBlock`, `AppointmentSummary`, `PolicyCard`.
- private: `_ConfirmationHero`؛ لا Feature Widget.
- Mock: booking number/appointment/payment policy. في facility لا تنشئ payment reference أو PaymentIntent.
- الحالة: `StatelessWidget` مع enum constructor `BookingPaymentPolicy { paid, payAtFacility }`؛ default paid.
- التنقل: PAT-09 أو pay-at-facility path entry؛ callbacks إلى appointment details/facility/home.
- القبول: booking confirmed في الحالتين؛ status «مدفوع» مقابل «مستحق في المنشأة»؛ QR UI؛ arrival instructions؛ لا partial/deposit.
- التحقق: query mapping لاحقًا، screenshots للحالتين، format/analyze.
- commit: `feat(booking): implement availability and confirmation screens`.
- التالي: B-05.

### B-05 — PAT-08 Payment Ready

- الهدف: provider-neutral payment ready.
- يعتمد على: B-02؛ `HARD` pilot gate. PAT-09 `SOFT`.
- المرجع/الحالة: `PAT08.ts`, ready فقط.
- ينشئ: `lib/src/features/payment/mock_data.dart`, `lib/src/features/payment/screens/payment_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakNotice`, `AafiatakButton`, `ReservationHoldBanner`.
- private: `_PaymentSafePanel`.
- Mock: appointment summary subset، amount/payment policy، countdown fixture.
- الحالة: `StatelessWidget`.
- التنقل: PAT-07 → payment؛ CTA إلى PAT-09 mock result callback.
- ملاحظات: لا card form، provider SDK، handoff state، network logic، أو PaymentIntent object layer.
- القبول: amount بارز وLTR، hold continuity، notice أن الموعد لا يؤكد قبل التحقق، ready فقط.
- التحقق: 360px، bottom CTA، format/analyze.
- commit: يمكن جمعه مع B-06/B-07 `feat(payment): implement payment ui flow`.
- التالي: B-06.

### B-06 — PAT-09 Payment Result

- الهدف: success-confirmed مع فصل نتيجتي الدفع والحجز.
- يعتمد على: B-05 payment mock؛ `HARD`. PAT-10 `SOFT`.
- المرجع/الحالة: `PAT09.ts`, success-confirmed.
- ينشئ: `lib/src/features/payment/screens/payment_result_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakStatusBlock` مرتين، `AafiatakCard`, `AafiatakInfoRows`, `AafiatakButton`.
- private: `_OperationDetails`.
- Mock: amount/payment reference/booking number.
- الحالة: `StatelessWidget`.
- التنقل: payment entry؛ confirmation callback.
- القبول: status دفع وstatus appointment منفصلان، references LTR، لا processing/refund/failed.
- التحقق: semantics للنص وليس اللون فقط، format/analyze.
- commit: مع payment flow.
- التالي: B-07.

### B-07 — PAT-13 Payment Details

- الهدف: succeeded receipt فقط.
- يعتمد على: B-05 mock؛ `HARD`. PAT-12 `SOFT`.
- المرجع/الحالة: `PAT13.ts`, succeeded.
- ينشئ: `lib/src/features/payment/widgets/payment_receipt.dart`, `lib/src/features/payment/screens/payment_details_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakStatusBlock`, `AafiatakCard`, `AafiatakButton`; receipt يستخدم Material layout وDS typography/spacing.
- Feature Widget: `PaymentReceipt` لأنه قسم مكوّن من 4 صفوف ومتخصص داخل payment؛ يستقبل قيم عرض جاهزة ولا ينفذ منطق. private: `_PaymentAmountBlock`.
- Mock: succeeded/paymentReference/bookingNumber/service/facility/amount.
- الحالة: `StatelessWidget`.
- التنقل: PAT-12/payment notification entry؛ callback إلى appointment details.
- القبول: succeeded فقط؛ LTR للمراجع والمبلغ؛ لا due-at-facility/refund/update-state behavior.
- التحقق: long references wrap بلا overflow، format/analyze.
- commit: `feat(payment): implement payment ui flow`.
- التالي: B-08.

### B-08 — Booking/Payment QA

- يعتمد على: B-03..B-07؛ `HARD`.
- ينشئ: لا شيء؛ يعدل ملكية B فقط.
- افحص 6 screens و9 states، bottom actions، state transitions، currency، no PaymentIntent on facility، no partial payment، no provider UI، callbacks كاملة.
- افحص أن `rg "go_router|app_routes|Timer|Repository|Service|Provider|Bloc" lib/src/features/booking lib/src/features/payment` لا يظهر اختراقًا غير مبرر.
- commit: `fix(ui): polish booking and payment flows` إن لزم.
- التالي: B-09.

### B-09 — Validation Gate

- يعتمد على: B-08؛ `HARD`.
- شغل format على Feature files ثم format check لكل lib، `flutter analyze`, debug APK إن متاح، `git diff --check`, status.
- القبول: جميعها ناجحة؛ diff محصور بالملفات العشرة المملوكة.
- commit: لا commit منفصل إلا إصلاح حقيقي.
- التالي: B-10.

### B-10 — Feature PR Ready

- يعتمد على: B-09؛ `HARD`.
- PR: `feature/patient-booking-payment → develop` مع PAT/cases/screenshots/validation.
- راجع `git diff 2c130c4...HEAD --name-only` وHigh-Fidelity diff.
- CodeRabbit fixes على الفرع نفسه. ممنوع إضافة router «لتجربة التدفق».
- branch ready: checks وreview محلولة وcallbacks موثقة.
- commit إصلاح مقترح: `fix(ui): address review feedback for booking payment scope`.
- التالي: انتظار دمج PRs A وB وC، ثم B-11.

### B-11 — تكامل routes بعد الدمج

- الهدف: جعل 21 شاشة قابلة للوصول وربط callbacks.
- يعتمد على: دمج A-12 وB-10 وC-11 في `develop`؛ `HARD` H-26.
- الفرع: من أحدث develop نفذ `git switch -c integration/patient-ui-navigation`.
- ينشئ: لا ملفات جديدة.
- يعدل فقط: `lib/src/app/routing/app_routes.dart`, `lib/src/app/routing/app_router.dart`.
- Must Not Touch: كل Feature/DS/shell/pubspec/High-Fidelity.
- يستخدم: `go_router` الحالي وScreens المدمجة.
- التنفيذ: أضف 21 constants للأسماء/paths، استبدل starter initial route بـPAT-01، builder لكل PAT، parse آمن للIDs/query مع defaults: audience patient، policy paid، visit waiting، auth intent login. وصل root nav والإشعارات وكل callback وفق العقد.
- لا تستخدم redirects/auth guards أو StatefulShellRoute أو nested architecture؛ هذه UI demo.
- القبول: كل path في الخطة يفتح PAT الصحيح؛ back يعمل؛ bottom nav home/appointments/profile؛ notification kinds إلى appointment/payment/visit؛ flows booking وauth كاملة؛ invalid query يعود default بلا crash.
- التحقق: format/analyze/build، وتشغيل يدوي للflows على 390×844.
- commit: `feat(routing): integrate patient ui navigation`.
- التالي: B-12.

### B-12 — Integration QA وPR

- يعتمد على: B-11؛ `HARD`.
- ينشئ: PR فقط؛ يعدل route files فقط لإصلاح عيوب wiring.
- flow checks: `home→search→details`; `doctor/service→availability→review(state change)→payment→result→confirmation→appointment`; root tabs؛ notifications؛ `auth→phone→otp→complete→home`; direct query للحالات البديلة المختارة PAT-01/10/14.
- تحقق 21 destinations و28 states، وعدم وجود شاشة starter كinitial destination.
- PR: `integration/patient-ui-navigation → develop`؛ CodeRabbit fixes على نفس الفرع؛ لا merge تلقائي.
- commit إصلاح: `fix(routing): address patient navigation review feedback`.
- النهاية: milestone جاهز لموافقة develop→main.

## PR checklists

### Feature PR

- [ ] 6 شاشات و9 حالات فقط.
- [ ] PAT-07 pilot بالحالتين.
- [ ] hold/payment/appointment منفصلة، ولا Timer/provider/backend.
- [ ] no PaymentIntent للfacility ولا partial payment.
- [ ] لا router/shared/high-fidelity changes.
- [ ] format/analyze/build وvisual QA ناجحة.

### Integration PR

- [ ] routes 21 وأسماء/paths/query مطابقة.
- [ ] app_router/app_routes فقط في diff.
- [ ] callbacks/root nav/back/deep destinations تعمل.
- [ ] 28 states قابلة للفحص بلا UI debug controls.
- [ ] CodeRabbit والبوابات النهائية ناجحة.
