# خطة Developer B — Booking + Payment + Route Integration

## 1. بطاقة المهمة

- فرع التنفيذ: `feature/patient-booking-payment`.
- فرع التكامل اللاحق: `integration/patient-ui-navigation`.
- **Implementation Baseline:** `<IMPLEMENTATION_BASELINE_SHA>` من أحدث `origin/develop` بعد دفع تنظيف Design System.
- الملكية على Feature branch: `features/booking/**`, `features/payment/**`.
- الشاشات: PAT-06، PAT-07، PAT-08، PAT-09، PAT-10، PAT-13.
- الحالات: **9**.
- الحمل: 17.5 تنفيذ + 1.5 QA/PR + 2.5 routing integration = **21.5**.
- Pilot: PAT-07.

## 2. Retained-State Visual Fidelity

نفذ كامل الـUI المرئي للحالة المختارة. لا تحذف Control لمجرد أن نتيجته State غير مختارة.

- PAT-06 `no-capacity`: Calendar + Arrival Window بالقيمة `—` + Notice + availability-alert section/button + bottom action تبقى كلها.
- PAT-13 `succeeded`: زر «تحديث الحالة» يبقى ظاهرًا إلى جانب الرجوع للموعد؛ refresh presentation-only.

## 3. Mock canonical

- Doctor `doc-001 / د. سارة عبدالله`.
- Facility `fac-aafiatak-tahrir / مركز عافيتك التخصصي / فرع التحرير`.
- Service `svc-family-consult / استشارة طب الأسرة / 15,000 ر.ي`.
- Appointment `apt-af-28931 / AF-28931 / الجمعة 18 سبتمبر 2026 / 10:00 – 10:30`.
- Payment `PAY-2026-1847 / YER`.
- `09:42` fixture بصري فقط.

في PAT-06 إذا استخدمت 14–20 سبتمبر 2026 فالأيام الصحيحة: الاثنين 14، الثلاثاء 15، الأربعاء 16، الخميس 17، الجمعة 18، السبت 19، الأحد 20. حافظ على معنى availability/selection من HF ولا تنسخ أسماء أيامه المتعارضة مع التاريخ.

## 4. ملكية الملفات

### Feature branch

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

### Integration branch فقط

```text
lib/src/app/routing/app_routes.dart
lib/src/app/routing/app_router.dart
```

ممنوع تعديل أي app/DS/pubspec/starter/HF أو Features A/C على Feature branch. على Integration branch لا تعدل Feature files؛ أي constructor/callback ناقص يعالج عبر PR صغير لصاحب Feature.

## 5. Public Contracts

- PAT-06 `AvailabilityScreen`: `AvailabilityDemoState initialState`, `onReviewTap`, `onAvailabilityAlertRequested`.
- PAT-07 `BookingReviewScreen`: `onPaymentTap`; state transition داخلي.
- PAT-08 `PaymentScreen`: `onPaymentResultTap`.
- PAT-09 `PaymentResultScreen`: `onConfirmationTap`.
- PAT-10 `BookingConfirmationScreen`: `BookingPaymentPolicy` + appointment/facility/home/showQr callbacks.
- PAT-13 `PaymentDetailsScreen`: `appointmentId` + appointment/refreshRequested callbacks.

على route integration يجب استهلاك العقود الموثقة في Master لكل Screens A/B/C كما هي.

## 6. Route Contract

- `/` PAT-01؛ `audience`: patient أو guest، default patient.
- `/search` PAT-02.
- `/doctors/:doctorId` PAT-03.
- `/services/:serviceId` PAT-04.
- `/facilities/:facilityId` PAT-05.
- `/availability` PAT-06؛ `state`: bookable أو no-capacity، default bookable.
- `/booking/review` PAT-07.
- `/payment` PAT-08.
- `/payment/result` PAT-09.
- `/booking/confirmation` PAT-10؛ `policy`: paid أو facility، default paid.
- `/appointments` PAT-11.
- `/appointments/:appointmentId` PAT-12.
- `/appointments/:appointmentId/payment` PAT-13.
- `/appointments/:appointmentId/visit` PAT-14؛ `state`: checked-in-waiting أو called أو completed، default checked-in-waiting.
- `/notifications` PAT-15.
- `/profile` PAT-16.
- `/profile/edit` PAT-17.
- `/auth` PAT-18.
- `/auth/phone` PAT-19؛ `intent`: login أو register، default login.
- `/auth/otp` PAT-20؛ `intent`: login أو register، default login.
- `/auth/complete-profile` PAT-21.

### Route parsing mappings — إلزامية

- `policy=facility` → `BookingPaymentPolicy.payAtFacility`.
- `policy=paid` أو query مفقود أو أي قيمة غير معروفة → `BookingPaymentPolicy.paid`.
- لا تستخدم parsing مباشرًا باسم enum لـ`policy`.
- `state=checked-in-waiting` → `VisitQueueDemoState.waiting`.
- `state=called` → `VisitQueueDemoState.called`.
- `state=completed` → `VisitQueueDemoState.completed`.
- `state` المفقود أو غير المعروف → `VisitQueueDemoState.waiting`.
- اسم HF/route canonical للحالة الأولى هو `checked-in-waiting`، بينما اسم enum المحلي المختصر هو `waiting`؛ هذا mapping مقصود ولا يغيّر نطاق الحالات.

## 7. التسلسل الصارم

### B-00 — تجهيز Feature Branch

- يعتمد على دفع تنظيف Design System وإعلان `IMPLEMENTATION_BASELINE_SHA`؛ `SHARED`.

```bash
git fetch --all --prune
git switch -c feature/patient-booking-payment <IMPLEMENTATION_BASELINE_SHA>
git status
git rev-parse HEAD
flutter pub get
```

- القبول: HEAD مطابق والشجرة نظيفة.
- commit: لا شيء.
- التالي: B-01.

### B-01 — Pilot: PAT-07 Booking Review

- الحالات: `pre-hold-review`, `active-hold` فقط.
- ينشئ: `booking/mock_data.dart`, `booking/screens/booking_review_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Card, Badge, Notice, Button, AppointmentSummary, ReservationHoldBanner, PolicyCard.
- private: `_BookingAmountBlock`.
- StatefulWidget + enum private `_BookingReviewView`؛ CTA الأول ينتقل محليًا إلى active-hold، والثاني يستدعي `onPaymentTap`.
- لا Timer ولا domain service ولا acquiring/expired/offline states.
- القبول: full visible UI للحالتين، hold لا يساوي appointment/payment، bottom action غير حاجب.
- screenshots 360/390.
- commit: `feat(booking): implement booking review pilot states`.
- التالي: B-02.

### B-02 — Pilot Gate

- يعتمد على B-01؛ `HARD`.
- افحص RTL، local enum، no timer/no router، canonical data، scrolling، visual fidelity.
- `flutter analyze` نظيف.
- commit عند الحاجة: `fix(booking): align booking review pilot`.
- التالي: B-03.

### B-03 — PAT-06 Availability

- الحالات: `bookable`, `no-capacity` فقط.
- ينشئ: `booking/widgets/availability_day_tile.dart`, `booking/screens/availability_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Card, SectionHeading, Notice, Button, AppointmentSummary, ArrivalWindowCard.
- `AvailabilityDayTile`: local booking widget متكرر للأيام.
- StatefulWidget + enum عام في الملف `AvailabilityDemoState { bookable, noCapacity }` وconstructor `initialState` حتى يفتح preview والـroute الحالتين صراحةً.
- Mock days 14–20 بالتواريخ/أيام الأسبوع الصحيحة، selected day 18.
- **في `no-capacity` يجب أن تبقى**: AppointmentSummary، Calendar، Arrival Window مع `—`، Notice، قسم «هل تريد معرفة متى تتوفر سعة؟»، زر «أشعرني عند التوفر»، وbottom action «اختر يومًا آخر».
- `onAvailabilityAlertRequested` presentation-only؛ لا subscription logic.
- CTA bookable فقط يستدعي `onReviewTap`.
- mapping التكامل: `state=no-capacity` → `AvailabilityDemoState.noCapacity`، وما عدا ذلك → `.bookable`.
- القبول: لا time picker، Arrival Window ليست doctor-entry time، لا loading/last-seat/time-cutoff/stale/offline/error.
- commit مع B-04: `feat(booking): implement availability and confirmation screens`.
- التالي: B-04.

### B-04 — PAT-10 Booking Confirmation

- الحالات: `confirmed-paid`, `confirmed-pay-at-facility`.
- ينشئ: `booking_confirmation_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Badge, Button, StatusBlock, AppointmentSummary, PolicyCard.
- private: `_ConfirmationHero`.
- Stateless + `BookingPaymentPolicy { paid, payAtFacility }`.
- في pay-at-facility لا `PaymentIntent` ولا payment reference.
- controls المرئية: show QR، تفاصيل الموعد، الاتجاهات، الرئيسية.
- القبول: appointment confirmed في الحالتين، لا deposit/partial payment.
- التالي: B-05.

### B-05 — PAT-08 Payment Ready

- الحالة: `ready`.
- ينشئ: `payment/mock_data.dart`, `payment/screens/payment_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Card, Notice, Button, ReservationHoldBanner.
- private: `_PaymentSafePanel`.
- Stateless؛ CTA إلى `onPaymentResultTap` مباشرة في UI demo.
- لا card form/provider SDK/handoff/network logic.
- القبول: amount بارز، hold continuity، notice الفصل بين الدفع وتأكيد الموعد.
- التالي: B-06.

### B-06 — PAT-09 Payment Result

- الحالة: `success-confirmed`.
- ينشئ: `payment_result_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, StatusBlock مرتين، Card, InfoRows, Button.
- private: `_OperationDetails`.
- نجاح الدفع ونجاح appointment كتلتان منفصلتان؛ references LTR.
- CTA `onConfirmationTap`.
- لا processing/failed/refund/offline.
- التالي: B-07.

### B-07 — PAT-13 Payment Details

- الحالة: `succeeded`.
- ينشئ: `payment/widgets/payment_receipt.dart`, `payment/screens/payment_details_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, StatusBlock, Card, Button.
- `PaymentReceipt`: 4 صفوف payment-specific، بلا business logic.
- private: `_PaymentAmountBlock`.
- **Retained-State Fidelity:** زر «تحديث الحالة» ظاهر ويستدعي `onRefreshRequested` presentation-only، وزر «العودة إلى تفاصيل الموعد» يستدعي callback.
- لا due-at-facility/refund/processing states.
- القبول: long references لا overflow وLTR صحيح.
- commit: `feat(payment): implement payment ui flow`.
- التالي: B-08.

### B-08 — Booking/Payment QA

- يفحص 6 Screens و9 States.
- يفحص PAT-06 no-capacity كامل بصريًا وPAT-13 refresh control.
- يفحص currency، hold/payment/appointment separation، no PaymentIntent facility، no partial payment.
- no router imports وno Timer/Repository/Service/Provider/Bloc.
- 360/390 screenshots للحالات البديلة.
- commit عند الحاجة: `fix(ui): polish booking and payment flows`.
- التالي: B-09.

### B-09 — Validation Gate

- format Features B ثم format check لكل lib.
- `flutter analyze`.
- debug APK إذا متاح.
- `git diff --check`, `git status`.
- القبول: diff محصور بملفات B.
- التالي: B-10.

### B-10 — Feature PR Ready

- PR `feature/patient-booking-payment → develop`.
- يذكر `IMPLEMENTATION_BASELINE_SHA`, 6 Screens, 9 States، screenshots، validation.
- CodeRabbit fixes على الفرع نفسه.
- **لا routing على Feature branch**.
- commit review: `fix(ui): address review feedback for booking payment scope`.
- التالي بعد دمج A/B/C: B-11.

### B-11 — Route Integration

- يعتمد على دمج Feature PRs الثلاثة؛ `HARD`.
- من أحدث develop:

```bash
git fetch --all --prune
git switch develop
git pull --ff-only origin develop
git switch -c integration/patient-ui-navigation
```

- يعدل **فقط** `app_routes.dart` و`app_router.dart`.
- يضيف 21 route names/paths.
- يستبدل Starter كـinitial destination بـPAT-01.
- parse آمن للIDs/query؛ defaults: audience patient، policy `BookingPaymentPolicy.paid`، visit `VisitQueueDemoState.waiting`، auth intent login.
- **PAT-10 mapping:** إذا كانت query `policy=facility` فمرر `BookingPaymentPolicy.payAtFacility`. إذا كانت `paid` أو مفقودة أو غير معروفة فمرر `BookingPaymentPolicy.paid`. لا تستخدم `Enum.values.byName` أو parsing مباشر باسم enum.
- **PAT-06 mapping:** إذا كانت query `state=no-capacity` فمرر `AvailabilityDemoState.noCapacity`. إذا كانت `bookable` أو مفقودة أو غير معروفة فمرر `AvailabilityDemoState.bookable`.
- **PAT-14 mapping:** `checked-in-waiting` → `VisitQueueDemoState.waiting`، و`called`/`completed` إلى القيم المناظرة؛ المفقود أو غير المعروف → `VisitQueueDemoState.waiting`.
- يربط كل constructor/callback حسب Master؛ لا يغير signatures.
- presentation-only callbacks مثل cancel/logout/refresh/availability-alert/resend لا تنشئ omitted states؛ تبقى آمنة وبلا crash.
- يربط root tabs home/appointments/profile والإشعارات.
- لا redirects/auth guards/StatefulShellRoute/nested architecture.
- القبول: 21 paths تفتح PAT الصحيح، back يعمل، booking/auth flows كاملة، invalid query يرجع default بلا crash، وpay-at-facility يفتح `BookingPaymentPolicy.payAtFacility` فعليًا.
- validation: format/analyze/build + manual flows 390×844.
- commit: `feat(routing): integrate patient ui navigation`.
- التالي: B-12.

### B-12 — Integration QA وPR

- يفحص 21 destination و28 state.
- flows: home→search→details؛ doctor/service→availability→review→payment→result→confirmation→appointment؛ root tabs؛ notifications؛ login flow؛ register flow.
- queries: audience، availability bookable/no-capacity، policy paid/facility، visit `checked-in-waiting`/called/completed، auth intent.
- diff يحتوي route files فقط.
- PR `integration/patient-ui-navigation → develop`; CodeRabbit fixes على نفس الفرع.
- commit review عند الحاجة: `fix(routing): address patient navigation review feedback`.

## 8. Checklists

### Feature PR

- [ ] 6 Screens و9 States فقط.
- [ ] PAT-06 no-capacity يحتفظ بكل عناصر HF المرئية.
- [ ] PAT-13 refresh + back controls ظاهرة.
- [ ] التاريخ canonical الجمعة 18 سبتمبر 2026.
- [ ] no Timer/provider/backend/PaymentIntent facility/partial payment.
- [ ] no router/shared/HF changes.
- [ ] constructor contracts مطابقة.
- [ ] format/analyze/build وvisual QA ناجحة.

### Integration PR

- [ ] 21 routes وdefaults مطابقة.
- [ ] `policy=facility` يتحول إلى `BookingPaymentPolicy.payAtFacility`، وبقية/المفقود/غير المعروف إلى `BookingPaymentPolicy.paid`.
- [ ] `availability?state=no-capacity` يتحول إلى `AvailabilityDemoState.noCapacity`، وبقية/المفقود/غير المعروف إلى `.bookable`.
- [ ] `state=checked-in-waiting` يتحول إلى `VisitQueueDemoState.waiting`.
- [ ] `app_router.dart` و`app_routes.dart` فقط في diff.
- [ ] لا Feature patches.
- [ ] callbacks/root nav/back/notification destinations تعمل.
- [ ] presentation-only controls لا تنشئ omitted states ولا crash.
- [ ] 28 states قابلة للفحص.
- [ ] CodeRabbit threads محلولة.
