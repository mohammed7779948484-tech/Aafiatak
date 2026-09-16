# الخطة الرئيسية لتنفيذ واجهات المريض

> الحالة: خطة تنفيذ نهائية. يبدأ فريق Flutter فقط من خط الأساس المعلن بعد دفع تنظيف Design System إلى `develop`.

## 1. خط الأساس ونقطة بدء التنفيذ

- المستودع: `mohammed7779948484-tech/Aafiatak`.
- فرع التطوير المعتمد: `develop`.
- لا يحفظ هذا المستند SHA ثابتًا لأنه يصبح قديمًا عند أي commit جديد.

### Implementation Baseline — قاعدة إلزامية

بعد دفع تنظيف Design System إلى `develop`، وقبل إنشاء فروع التنفيذ مباشرة، ينفذ المنسق:

```bash
git fetch origin develop
git switch develop
git pull --ff-only origin develop
git rev-parse origin/develop
```

يسجل الناتج باسم **`IMPLEMENTATION_BASELINE_SHA`** ويرسله للأعضاء الثلاثة. كل فروع التنفيذ الثلاثة يجب أن تبدأ من **نفس** هذا SHA، ويكتب في وصف كل Feature PR. ممنوع استخدام checkout أقدم أو مختلف.

## 2. النطاق والهندسة المجمدة

المطلوب **21 شاشة PAT و28 حالة UI مختارة فقط**. التطبيق عربي RTL، للهاتف فقط، Light mode، Material 3، وبيانات محلية Mock Data. لا Backend ولا طبقات Production.

المسموح للحالة المحلية:

- `StatelessWidget` للشاشات ذات الحالة الواحدة.
- `StatefulWidget` + `setState` للتفاعل المحلي البسيط.
- enum محلي صغير عند الحاجة.
- constructor parameter عندما يكون أوضح.

الممنوع: Riverpod، Bloc، Provider، GetX، Repository، Service، Use Case، DTO، Datasource، DI، backend، ARB، `gen-l10n`، أو أي طبقة لا تساعد ثلاثة طلاب على بناء UI ممتاز بسرعة وشرحه للدكتور.

تبقى المفاهيم منفصلة: `ReservationHold`, `Appointment`, `PaymentIntent`, `VisitInstance`, `QueueEntry`. `ArrivalWindow` نافذة وصول وليست وعدًا بوقت دخول الطبيب. الدفع إما كامل إلكترونيًا أو في المنشأة. لا عربون أو دفع جزئي. الدفع في المنشأة لا يحتاج `PaymentIntent`. لا self-check-in ولا self-reschedule.

## 3. قاعدة Retained-State Visual Fidelity — إلزامية

اختيار 28 حالة لا يعني حذف عناصر مرئية موجودة داخل الحالة المختارة. القاعدة هي:

> **يجب تنفيذ كامل الـUI المرئي للحالة المختارة كما يظهر في High-Fidelity. إذا كان زر أو Segmented control أو CTA داخل الحالة المختارة يقود إلى حالة غير مختارة، يبقى العنصر ظاهرًا وبنفس النية البصرية، لكن لا يلزم تنفيذ الحالة الهدف.**

يمكن أن يكون هذا الإجراء presentation-only عبر callback لا ينشئ State جديدة. لا يجوز حذف العنصر لمجرد أن الحالة الناتجة خارج النطاق.

أمثلة إلزامية:

- PAT-06 `no-capacity`: يبقى Calendar وArrival Window بقيمة `—` وNotice وقسم «أشعرني عند التوفر» والـbottom action؛ لا نبني اشتراك تنبيه حقيقي.
- PAT-11 `upcoming-populated`: يبقى Segmented control «القادمة / السابقة» ظاهرًا، لكن لا نبني `past-populated`.
- PAT-12 `confirmed`: يبقى زر «إلغاء الموعد» ظاهرًا، لكن لا نبني `cancelled-by-patient`.
- PAT-13 `succeeded`: يبقى زر «تحديث الحالة» وزر الرجوع ظاهرين، ولا نبني processing/refund states.
- PAT-16 `loaded`: يبقى زر «تسجيل الخروج» ظاهرًا، لكن لا نبني logging-out/logged-out.
- PAT-20 `waiting`: تبقى عناصر تغيير الرقم وإعادة الإرسال والتحقق ظاهرة، بلا resend timer ولا verifying/verified states.

## 4. Design System المجمد

الاستيراد العام:

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

### Core Components — 10

`AafiatakButton`, `AafiatakTextField`, `AafiatakSearchField`, `AafiatakCard`, `AafiatakBadge`, `AafiatakNotice`, `AafiatakStatusBlock`, `AafiatakSectionHeading`, `AafiatakInfoRows`, `AafiatakEmptyState`.

### Domain Patterns — 7

`DoctorCard`, `ServiceCard`, `FacilitySummary`, `AppointmentSummary`, `ReservationHoldBanner`, `ArrivalWindowCard`, `PolicyCard`.

لا يعدل أي طالب `lib/src/design_system/**`. إذا ظهر عائق حقيقي يثبت في أكثر من شاشة، يرفع كملاحظة/issue ويعالج بقرار منفصل.

- الخط المضمّن: `IBMPlexSansArabic` بأوزان 400 و500 و600 و700.
- Typography API: `display`, `h1`, `h2`, `h3`, `bodyLarge`, `body`, `labelLarge`, `label`, `bodySmall`, `caption`.
- Feedback tones: `primary`, `secondary`, `success`, `warning`, `info`, `hold` فقط.
- حذف feedback `error` لا يلغي `ColorScheme.error*` المستخدم للتحقق والأزرار المدمرة.
- `inputBoundary` الأقوى قرار وصول مقصود ولا يعاد إلى حد النموذج الأخف.

## 5. Features والحالات المختارة

| Feature | الشاشات |
|---|---|
| `discovery` | PAT-01 إلى PAT-05 |
| `booking` | PAT-06، PAT-07، PAT-10 |
| `payment` | PAT-08، PAT-09، PAT-13 |
| `appointments` | PAT-11، PAT-12 |
| `visit` | PAT-14 |
| `notifications` | PAT-15 |
| `profile` | PAT-16، PAT-17 |
| `auth` | PAT-18 إلى PAT-21 |

الحالات المعتمدة فقط:

- PAT-01: `patient-populated`, `guest-populated`
- PAT-02: `results`
- PAT-03: `active`
- PAT-04: `active`
- PAT-05: `loaded`
- PAT-06: `bookable`, `no-capacity`
- PAT-07: `pre-hold-review`, `active-hold`
- PAT-08: `ready`
- PAT-09: `success-confirmed`
- PAT-10: `confirmed-paid`, `confirmed-pay-at-facility`
- PAT-11: `upcoming-populated`
- PAT-12: `confirmed`
- PAT-13: `succeeded`
- PAT-14: `checked-in-waiting`, `called`, `completed`
- PAT-15: `populated-unread`
- PAT-16: `loaded`
- PAT-17: `editing`
- PAT-18: `default`
- PAT-19: `idle`
- PAT-20: `waiting`
- PAT-21: `editing`, `success`

**المجموع = 28 حالة بالضبط.** حالات High-Fidelity الأخرى تبقى مرجعًا فقط ولا تنفذ في Flutter.

## 6. مصفوفة التنفيذ والـScroll Strategy

| PAT | Flutter Screen | Feature | الحالات | Shell / Scroll | النقاط |
|---|---|---|---|---|---:|
| PAT-01 | `home_screen.dart` | discovery | patient-populated, guest-populated | root، `scrollable:true` | 4.0 |
| PAT-02 | `search_screen.dart` | discovery | results | detail، `scrollable:true` | 2.5 |
| PAT-03 | `doctor_details_screen.dart` | discovery | active | detail + bottomAction، `scrollable:true` | 2.5 |
| PAT-04 | `service_details_screen.dart` | discovery | active | detail + bottomAction، `scrollable:true` | 2.5 |
| PAT-05 | `facility_details_screen.dart` | discovery | loaded | detail، `scrollable:true` | 2.5 |
| PAT-06 | `availability_screen.dart` | booking | bookable, no-capacity | detail + bottomAction، `scrollable:true` | 3.5 |
| PAT-07 | `booking_review_screen.dart` | booking | pre-hold-review, active-hold | detail + bottomAction، `scrollable:true` | 3.5 |
| PAT-08 | `payment_screen.dart` | payment | ready | detail + bottomAction، `scrollable:true` | 2.5 |
| PAT-09 | `payment_result_screen.dart` | payment | success-confirmed | detail + bottomAction، `scrollable:true` | 2.5 |
| PAT-10 | `booking_confirmation_screen.dart` | booking | confirmed-paid, confirmed-pay-at-facility | detail، `scrollable:true` | 2.5 |
| PAT-11 | `appointments_screen.dart` | appointments | upcoming-populated | root، `scrollable:true` | 2.5 |
| PAT-12 | `appointment_details_screen.dart` | appointments | confirmed | detail، `scrollable:true` | 3.5 |
| PAT-13 | `payment_details_screen.dart` | payment | succeeded | detail، `scrollable:true` | 3.0 |
| PAT-14 | `visit_queue_screen.dart` | visit | checked-in-waiting, called, completed | detail، `scrollable:true` | 4.5 |
| PAT-15 | `notifications_screen.dart` | notifications | populated-unread | detail، body يمتلك `ListView` وshell غير scrollable | 2.0 |
| PAT-16 | `profile_screen.dart` | profile | loaded | root، `scrollable:true` | 2.0 |
| PAT-17 | `edit_profile_screen.dart` | profile | editing | detail، `scrollable:true` مع keyboard insets | 2.5 |
| PAT-18 | `auth_entry_screen.dart` | auth | default | detail، `scrollable:true` | 1.5 |
| PAT-19 | `phone_screen.dart` | auth | idle | detail + bottomAction، `scrollable:true` | 2.5 |
| PAT-20 | `whatsapp_otp_screen.dart` | auth | waiting | detail + bottomAction، `scrollable:true` | 3.0 |
| PAT-21 | `complete_patient_profile_screen.dart` | auth | editing, success | detail + bottomAction، `scrollable:true` | 3.5 |

## 7. البنية الدقيقة المقترحة

```text
lib/src/features/
├── discovery/
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── search_screen.dart
│   │   ├── doctor_details_screen.dart
│   │   ├── service_details_screen.dart
│   │   └── facility_details_screen.dart
│   ├── widgets/
│   │   ├── home_hero.dart
│   │   ├── quick_actions.dart
│   │   └── upcoming_appointment_section.dart
│   └── mock_data.dart
├── booking/
│   ├── screens/{availability_screen,booking_review_screen,booking_confirmation_screen}.dart
│   ├── widgets/availability_day_tile.dart
│   └── mock_data.dart
├── payment/
│   ├── screens/{payment_screen,payment_result_screen,payment_details_screen}.dart
│   ├── widgets/payment_receipt.dart
│   └── mock_data.dart
├── appointments/
│   ├── screens/{appointments_screen,appointment_details_screen}.dart
│   ├── widgets/appointment_list_card.dart
│   └── mock_data.dart
├── visit/
│   ├── screens/visit_queue_screen.dart
│   └── mock_data.dart
├── notifications/
│   ├── screens/notifications_screen.dart
│   ├── widgets/notification_tile.dart
│   └── mock_data.dart
├── profile/
│   ├── screens/{profile_screen,edit_profile_screen}.dart
│   └── mock_data.dart
└── auth/
    ├── auth_intent.dart
    ├── screens/{auth_entry_screen,phone_screen,whatsapp_otp_screen,complete_patient_profile_screen}.dart
    ├── widgets/{auth_intro,otp_input,verified_phone_summary}.dart
    └── mock_data.dart
```

### Widget extraction rule

- التكرار بين Features: استخدم Design System/Pattern الموجود أولًا.
- التكرار داخل Feature: Feature Widget.
- section كبير وواضح يمكن فصله حتى لو استخدم مرة واحدة إذا كان ذلك يحافظ على أن `screen.dart` ملف تركيب مقروء.
- Widget صغير ومرة واحدة: private داخل الشاشة.
- لا تنشأ ملفات فارغة أو Widgets لكل Row/Icon/Text.

تم فصل `HomeHero`, `QuickActions`, `UpcomingAppointmentSection` لأن PAT-01 طويلة وتحتاج أن يبقى `home_screen.dart` ملف تركيب؛ بقية أقسام Discovery الصغيرة تبقى private أو تستخدم Patterns الحالية.

## 8. عقد Mock Data

لا يوجد `lib/src/mock_data/app_mock_data.dart` في هذا الميلستون لتجنب ملف مشترك متنازع عليه بين الفروع. كل Feature يحتفظ بأقل subset يحتاجه مع الالتزام بالقيم canonical التالية:

| الكيان | القيم |
|---|---|
| Doctor | `doc-001`، د. سارة عبدالله، طب الأسرة، الرعاية الأولية |
| Facility | `fac-aafiatak-tahrir`، مركز عافيتك التخصصي، فرع التحرير، صنعاء |
| Service | `svc-family-consult`، استشارة طب الأسرة، `15,000 ر.ي`، الدفع الكامل إلكترونيًا |
| Appointment | `apt-af-28931`، **الجمعة 18 سبتمبر 2026**، `10:00 – 10:30`، `AF-28931` |
| Payment | `15,000 ر.ي`، `YER`، `PAY-2026-1847` |
| Patient | `pat-001`، أحمد بلال، أب، `+[رمز الدولة] ••• ••15` |
| Queue | 3 مرضى تقريبًا، آخر تحديث `12:04 م` |

### تصحيح fixture مقصود

الـHigh-Fidelity الخام كتب «الأربعاء 18 سبتمبر 2026»، لكن التاريخ الميلادي الصحيح يوافق **الجمعة**. خطة Flutter تستخدم «الجمعة 18 سبتمبر 2026» في المستندات وMock Data. كذلك عند كتابة شريط الأيام PAT-06 تستخدم الأيام الصحيحة لتواريخ 14–20 سبتمبر 2026: الاثنين، الثلاثاء، الأربعاء، الخميس، الجمعة، السبت، الأحد، مع الحفاظ على معنى availability/selection من المرجع.

`09:42` وOTP length=6 قيمتا presentation fixture فقط وليستا policy منتج. النصوص الثابتة تبقى في UI.

## 9. عقد Routes

| name | path | parameter/query |
|---|---|---|
| `home` | `/` | `audience`: patient أو guest، default patient |
| `search` | `/search` | لا شيء |
| `doctorDetails` | `/doctors/:doctorId` | `doctorId`، canonical `doc-001` |
| `serviceDetails` | `/services/:serviceId` | `serviceId`، canonical `svc-family-consult` |
| `facilityDetails` | `/facilities/:facilityId` | `facilityId`، canonical `fac-aafiatak-tahrir` |
| `availability` | `/availability` | `state`: bookable أو no-capacity، default bookable |
| `bookingReview` | `/booking/review` | الحالة local |
| `payment` | `/payment` | لا شيء |
| `paymentResult` | `/payment/result` | لا شيء |
| `bookingConfirmation` | `/booking/confirmation` | `policy`: paid أو facility، default paid |
| `appointments` | `/appointments` | لا شيء |
| `appointmentDetails` | `/appointments/:appointmentId` | canonical `apt-af-28931` |
| `paymentDetails` | `/appointments/:appointmentId/payment` | canonical `apt-af-28931` |
| `visitQueue` | `/appointments/:appointmentId/visit` | `state`: `checked-in-waiting` أو `called` أو `completed`، default `checked-in-waiting` |
| `notifications` | `/notifications` | لا شيء |
| `profile` | `/profile` | لا شيء |
| `editProfile` | `/profile/edit` | لا شيء |
| `authEntry` | `/auth` | لا شيء |
| `phone` | `/auth/phone` | `intent`: login أو register، default login |
| `whatsappOtp` | `/auth/otp` | `intent`: login أو register، default login |
| `completeProfile` | `/auth/complete-profile` | لا شيء |

### Route parsing mappings — إلزامية

- PAT-10: `policy=facility` يتحول صراحةً إلى `BookingPaymentPolicy.payAtFacility`. القيمة `paid` أو query المفقود أو أي قيمة غير معروفة تتحول إلى `BookingPaymentPolicy.paid`. لا تستخدم parsing مباشرًا باسم enum.
- PAT-06: `state=no-capacity` يتحول صراحةً إلى `AvailabilityDemoState.noCapacity`. القيمة `bookable` أو query المفقود أو أي قيمة غير معروفة تتحول إلى `AvailabilityDemoState.bookable`.
- PAT-14: اسم الحالة canonical في High-Fidelity والعقد الخارجي هو `checked-in-waiting`. عند بناء Flutter يتحول `state=checked-in-waiting` إلى `VisitQueueDemoState.waiting`؛ أما `called` و`completed` فيتحولان إلى القيم المناظرة. query المفقود أو غير المعروف يعود إلى `VisitQueueDemoState.waiting`. لا تستخدم parsing مباشرًا باسم enum.

Feature screens لا تستورد `go_router` أو `app_routes.dart`. كل التنقل الخارجي عبر callbacks. Developer B يملك route integration بعد دمج Feature PRs الثلاثة.

## 10. Public Constructor & Callback Contract

هذه العقود يجب تثبيتها أثناء التنفيذ حتى لا يحتاج Integration PR لتعديل Feature files:

| PAT | العقد العام المطلوب |
|---|---|
| PAT-01 | `HomeScreen` يأخذ `HomeAudience`, callbacks للبحث والتوفر والطبيب والخدمة والمنشأة والموعد والإشعارات و`ValueChanged<PatientTab>` |
| PAT-02 | `SearchScreen` يأخذ callbacks doctor/service/facility مع IDs |
| PAT-03 | `DoctorDetailsScreen` يأخذ `doctorId` وcallbacks facility/service/availability |
| PAT-04 | `ServiceDetailsScreen` يأخذ `serviceId` وcallbacks facility/availability |
| PAT-05 | `FacilityDetailsScreen` يأخذ `facilityId` وcallbacks doctor/service/showLocation/call |
| PAT-06 | `AvailabilityScreen` يأخذ `AvailabilityDemoState initialState` و`onReviewTap` و`onAvailabilityAlertRequested` |
| PAT-07 | `BookingReviewScreen` يأخذ `onPaymentTap` فقط؛ الانتقال بين الحالتين محلي |
| PAT-08 | `PaymentScreen` يأخذ `onPaymentResultTap` |
| PAT-09 | `PaymentResultScreen` يأخذ `onConfirmationTap` |
| PAT-10 | `BookingConfirmationScreen` يأخذ `BookingPaymentPolicy` وcallbacks appointment/facility/home/showQr |
| PAT-11 | `AppointmentsScreen` يأخذ callbacks appointment/notifications/rootTab و`onPastRequested` presentation-only |
| PAT-12 | `AppointmentDetailsScreen` يأخذ `appointmentId` وcallbacks facility/showQr/cancelRequested presentation-only |
| PAT-13 | `PaymentDetailsScreen` يأخذ `appointmentId` وcallbacks appointment/refreshRequested presentation-only |
| PAT-14 | `VisitQueueScreen` يأخذ `VisitQueueDemoState initialState`؛ القيمة المحلية `waiting` تقابل الحالة الخارجية `checked-in-waiting` |
| PAT-15 | `NotificationsScreen` يأخذ callbacks appointment/payment/visit حسب `NotificationKind` |
| PAT-16 | `ProfileScreen` يأخذ callbacks edit/notifications/rootTab/logoutRequested presentation-only |
| PAT-17 | `EditProfileScreen` يأخذ `ValueChanged<String> onSave` |
| PAT-18 | `AuthEntryScreen` يأخذ `ValueChanged<AuthIntent> onPhoneRequested` و`onBrowseTap` |
| PAT-19 | `PhoneScreen` يأخذ `AuthIntent` و`onOtpRequested` |
| PAT-20 | `WhatsAppOtpScreen` يأخذ `AuthIntent` وcallbacks changePhone/verifyRequested/resendRequested presentation-only |
| PAT-21 | `CompletePatientProfileScreen` يأخذ `onFinished`؛ editing إلى success محلي، ويحتفظ success بزر «متابعة» داخل body مع bottom action المرجعي |

الـcallback presentation-only يجب أن يبقي العنصر Enabled بصريًا إذا كان كذلك في High-Fidelity، لكنه لا ينشئ State خارج الـ28.

## 11. ملكية الملفات وتجنب التعارض

| المجال | المالك |
|---|---|
| `features/discovery/**`, `notifications/**`, `profile/**` | Developer A |
| `features/booking/**`, `payment/**` | Developer B |
| `features/appointments/**`, `visit/**`, `auth/**` | Developer C |
| `app/routing/app_routes.dart`, `app_router.dart` | Developer B على integration branch فقط |
| `design_system/**`, `patient_shell.dart`, `aafiatak_app.dart`, `main.dart`, `pubspec.*`, `features/starter/**` | مجمد |
| `Aafiatak_High_Fidelity_Prototype_v3.0/**` | read-only دائمًا |

إذا احتاج Integration owner callback غير موجود حسب العقد، لا يpatch Feature file؛ يعاد PR صغير لصاحب الـFeature.

## 12. التبعيات والعمل المتوازي

- **SHARED:** Implementation Baseline، Design System، PatientShell، route names، constructor contracts، canonical mock values.
- **HARD:** بوابات داخل فرع العضو أو بوابة دمج لا يمكن تجاوزها.
- **SOFT:** وجهة يملكها عضو آخر ويمكن الاستمرار قبل اكتمالها عبر callback contract.

لا توجد Hard Dependency بين الأعضاء الثلاثة قبل دمج Feature PRs. كل عضو يبدأ ويكمل Feature branch بالتوازي.

عدد الـHard gates المعتمد في سجل المهام = **27**. عدد العقود Soft = **13**. بعد دمج A وB وC يصبح B-11 route integration هو Hard gate المشترك الأول.

## 13. توزيع العمل

| العضو | Features | الشاشات | الحالات | الحمل |
|---|---|---:|---:|---:|
| A | discovery + notifications + profile | 8 | 9 | **22.0** |
| B | booking + payment + route integration | 6 | 9 | **21.5** |
| C | appointments + visit + auth | 7 | 10 | **22.5** |

أقصى فرق نقطة واحدة، ولم يقسم أي Feature بين عضوين.

## 14. Pilot Gate

- A: PAT-01 لاختبار composition الطويل وroot shell وguest/patient وWidget extraction.
- B: PAT-07 لاختبار local state وفصل ReservationHold/Appointment/Payment.
- C: PAT-20 لاختبار OTP وLTR داخل RTL وcontrollers/focus.

Pilot gate لكل عضو: screenshots عند 360×800 و390×844، RTL/LTR صحيح، لا overflow، لا ألوان عشوائية، public DS import، Mock canonical، callbacks فقط بلا router، `flutter analyze` نظيف. بعد الاعتماد يكمل العضو على **نفس الفرع**.

## 15. Git / PR Workflow

1. بعد دفع تنظيف Design System وجلب أحدث `origin/develop`، المنسق يعلن `IMPLEMENTATION_BASELINE_SHA`.
2. A وB وC ينشئون فروعهم من SHA نفسه.
3. لا تعديل مباشر على `develop` أو `main`.
4. كل عضو يعمل 3–5 commits منطقية تقريبًا: Pilot، Features، QA/review fixes.
5. كل Feature PR إلى `develop` ثم CodeRabbit والإصلاح على الفرع نفسه.
6. يفضل دمج A ثم C ثم B، لكن الترتيب ليس dependency لأن الملفات منفصلة.
7. بعد الثلاثة، B ينشئ `integration/patient-ui-navigation` من أحدث `develop` ويعدل **ملفي routing فقط**.
8. Integration PR يراجع ثم يدمج إلى `develop`.
9. بعد QA النهائي فقط يتم `develop → main`.

## 16. Definition of Done

- نفذت الحالات الـ28 فقط، لكن **كل عنصر مرئي داخل كل حالة مختارة محفوظ** حتى لو كان الإجراء يقود لحالة غير مختارة.
- مطابقة High-Fidelity في الترتيب والhierarchy والcopy قدر الإمكان مع التصحيحات الموثقة.
- RTL صحيح وLTR معزول للقيم التقنية والهاتف وOTP والمراجع والأوقات عند الحاجة.
- لا `RenderFlex overflow` في 360px و390px.
- scrolling strategy مطابق للمصفوفة.
- Design System الحالي مستخدم بلا duplicate globals.
- Screen file مقروء؛ extraction ليس ناقصًا ولا مفرطًا.
- Mock Data canonical متسقة.
- constructor/callback contract مطابق لهذا الملف.
- لا `go_router` داخل Feature files.
- لا حالات خارج scope ولا packages/layers جديدة.
- لا تعديل للمناطق المجمدة أو High-Fidelity.
- `dart format --output=none --set-exit-if-changed lib`, `flutter analyze`, و`flutter build apk --debug` ناجحة عندما Android متاح.
- PR يرفق screenshots للحالات البديلة المختارة والPilot.

## 17. QA النهائي بعد Route Integration

يفحص يدويًا:

- home → search → details.
- doctor/service → availability → review → payment → result → confirmation → appointment.
- root tabs: home / appointments / profile.
- notifications إلى appointment/payment/visit.
- auth login: auth → phone → OTP → home.
- auth register: auth → phone → OTP → complete profile → home.
- Query defaults لـPAT-01 وPAT-06 وPAT-10 وPAT-14 وAuth intent، مع تطبيق mappings المحددة في قسم Routes.
- جميع 21 destination قابلة للوصول، وجميع 28 state قابلة للمراجعة بدون debug controls ظاهرة للمستخدم.

## 18. مراجعات الخطة بعد التصحيح

- **Coverage Audit:** PASS — 21 PAT مرة واحدة، A=8، B=6، C=7.
- **State Audit:** PASS — 28 فقط، A=9، B=9، C=10.
- **Retained-State Fidelity Audit:** PASS — تم تثبيت قاعدة عدم حذف controls المرئية وتصحيح PAT-06/11/12/13/16/20.
- **File Ownership Audit:** PASS — لا Feature file بمالكين؛ routing منفصل.
- **Dependency Audit:** PASS — لا Hard dependency بين الأعضاء قبل الدمج.
- **Constructor Contract Audit:** PASS — عقد عام لكل PAT قبل route integration.
- **Scroll Audit:** PASS — strategy محددة لكل PAT لتجنب overflow/nested scrolling.
- **Architecture Audit:** PASS — لا state package ولا layers ولا l10n زائد.
- **Mock Audit:** PASS — canonical متسقة، وتصحيح يوم 18 سبتمبر موثق.
- **Markdown/Route Audit:** PASS — لا قيم query تستخدم pipe غير مهرب داخل جداول؛ القيم مكتوبة كقوائم allowed values، وPAT-10/PAT-14 mappings صريحة.
- **Workload Audit:** PASS — 22.0 / 21.5 / 22.5.
- **Member Consistency Audit:** PASS — ملفات A/B/C تستخدم Implementation Baseline placeholder نفسه وتتفق مع Master.
- **Student Usability Audit:** PASS — كل ملف عضو self-contained ومهامه بالترتيب مع Creates/Uses/Acceptance/Validation/Commit.

### Baseline validation قبل بدء الفروع

قبل إعلان `IMPLEMENTATION_BASELINE_SHA` يشغّل المنسق `flutter pub get` وformat
check و`flutter analyze`، ويبني APK debug عندما تكون Android tooling متاحة.

لا يوجد blocker تخطيطي متبقٍ بعد دفع تنظيف Design System وتسجيل
`IMPLEMENTATION_BASELINE_SHA` من أحدث `origin/develop`.
