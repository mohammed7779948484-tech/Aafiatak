# الخطة الرئيسية لتنفيذ واجهات المريض

> الحالة: خطة تنفيذ نهائية بانتظار مراجعة PR التخطيطي. هذا الملف هو مصدر الحقيقة لفريق Flutter.

## 1. خط الأساس الذي بُنيت عليه الخطة

- المستودع: `mohammed7779948484-tech/Aafiatak`.
- فرع التطوير المفحوص: `develop`.
- SHA الكامل: `2c130c407979fc555652ae643d19369f2f7aad0c`.
- العنوان: `Merge PR #2: finalize student design system baseline`.
- حالة الشجرة وقت الفحص: نظيفة ومتزامنة مع `origin/develop`.
- العلاقة مع `main`: نتيجة `git rev-list --left-right --count origin/main...develop` هي `1 0`؛ أي أن `develop` يتقدم على `main` بcommit واحد ولا يوجد commit منفرد على `main`. و`merge-base` هو SHA نفسه أعلاه.
- فرع التخطيط: `planning/ui-team-execution-plan`، ولا يحتوي إلا المستندات الأربعة داخل هذا المجلد.

يجب إنشاء فروع التنفيذ الثلاثة من SHA أعلاه بعد اعتماد هذه الخطة. إذا دُمج PR التخطيطي أولًا، يجوز إنشاء الفروع من merge commit الناتج بشرط أن يؤكد المنسق أن التغيير الوحيد فوق SHA أعلاه وثائقي، وأن تستخدم الفروع الثلاثة SHA واحدًا مكتوبًا في وصف كل PR. لا يبدأ أي طالب من checkout أقدم أو مختلف.

## 2. قرار النطاق والهندسة المجمد

المطلوب 21 وجهة PAT و28 حالة UI مختارة فقط. التطبيق عربي RTL، للهاتف، Light mode، ببيانات محلية، وMaterial 3. تُكتب النصوص العربية الثابتة داخل ملفات الشاشات وWidgets المعنية. تستخدم البيانات المحاكية للكيانات والمواعيد والدفع والطابور ملفات `mock_data.dart` الخاصة بالـFeature.

المسموح للحالة المحلية هو `StatelessWidget`، أو `StatefulWidget` مع `setState`، أو enum محلي صغير، أو constructor parameter. لا تُنشأ مجلدات `states/` أو `controllers/` أو `providers/`. لا تُضاف Riverpod أو Bloc أو Provider أو GetX أو Repository أو Service أو Use Case أو DTO أو DI أو backend أو ARB أو `gen-l10n`.

تظل المفاهيم منفصلة: `ReservationHold` و`Appointment` و`PaymentIntent` و`VisitInstance` و`QueueEntry`. `ArrivalWindow` نافذة وصول وليست وعدًا بدخول الطبيب. الدفع إما كامل إلكترونيًا أو في المنشأة، بلا عربون. مسار الدفع في المنشأة لا ينشئ `PaymentIntent`. لا يوجد self-check-in ولا self-reschedule.

وجد الفحص تعارضين تاريخيين في `Aafiatak_High_Fidelity_Prototype_v3.0/docs/FLUTTER_HANDOFF.md`: يقترح بنية Repository/Use-case وخط IBM Plex Sans Arabic. كلاهما غير حاكم؛ prompt الحالي وكود `develop` يفرضان mock UI بسيطًا وخط النظام من دون asset. كما أن مثال `PatientShell` في `docs/design_system/README.md` قديم؛ constructors الفعلية هي `PatientShell.root` و`PatientShell.detail`.

## 3. جرد Design System الفعلي والمجمد

الاستيراد العام الوحيد هو:

```dart
import 'package:aafiatak/src/design_system/design_system.dart';
```

### Foundations وTheme

- `AafiatakColors`: Burgundy Monochrome، canvas `#E5E5E5`، surface `#FFFFFF`، primary `#800020`، نص أساسي `#1A1A1A`.
- `AafiatakSpacing`: `4, 8, 12, 16, 24, 32`.
- `AafiatakRadii`: `medium`, `large`, `full`.
- `AafiatakTypography`: أدوار display/headline/title/body/label الحالية.
- `AafiatakTheme.light`: ThemeData Material 3 لشريط التطبيق والبطاقات والأزرار والحقول والبحث وChips وNavigationBar.

### Core Components وواجهاتها المقصودة

| Component | الاستخدام الصحيح المختصر |
|---|---|
| `AafiatakButton` | constructors: `.primary/.tonal/.secondary/.destructive/.text`؛ التعطيل عبر `onPressed: null`، و`fullWidth` عند الحاجة. |
| `AafiatakTextField` | Forms؛ يدعم controller/label/hint/helper/error/keyboard/direction. |
| `AafiatakSearchField` | البحث فقط؛ controller و`onChanged` و`onSubmitted`. |
| `AafiatakCard` | سطح موحد، `elevated` اختياري و`onTap` اختياري. |
| `AafiatakBadge` | label مع `AafiatakFeedbackTone`. |
| `AafiatakNotice` | message وtone لملاحظة سياقية. |
| `AafiatakStatusBlock` | title/message/tone/icon/tag لحالة بارزة. |
| `AafiatakSectionHeading` | label وmeta اختياري. |
| `AafiatakInfoRows` | قائمة `InfoRowItem`، مع `isLtr` للقيم التقنية. |
| `AafiatakEmptyState` | بدون إجراء أو `.withAction`. الحالات الفارغة غير مطلوبة في النطاق الحالي. |

### Domain Patterns

| Pattern | البيانات الأساسية |
|---|---|
| `DoctorCard` | name/specialty/avatarText/price/onTap. |
| `ServiceCard` | title/price/policy/badgeLabel/onTap. |
| `FacilitySummary` | facilityName/location/branch/onTap. |
| `AppointmentSummary` | service/doctor/facility/branch/date/arrivalWindow. |
| `ReservationHoldBanner` | countdown فقط؛ لا يشغّل Timer. |
| `ArrivalWindowCard` | title/arrivalWindow/note. |
| `PolicyCard` | title/items. |

لا يعدّل أي طالب `lib/src/design_system/**`. إن ظهر عائق مثبت بصورتين أو أكثر، يُفتح issue/تعليق PR ولا يُحل محليًا على فرع Feature.

## 4. خريطة Features ونطاق الحالات

| Feature | PAT screens |
|---|---|
| `discovery` | PAT-01..PAT-05 |
| `booking` | PAT-06، PAT-07، PAT-10 |
| `payment` | PAT-08، PAT-09، PAT-13 |
| `appointments` | PAT-11، PAT-12 |
| `visit` | PAT-14 |
| `notifications` | PAT-15 |
| `profile` | PAT-16، PAT-17 |
| `auth` | PAT-18..PAT-21 |

الحالات المحتفظ بها: PAT-01=2، PAT-02=1، PAT-03=1، PAT-04=1، PAT-05=1، PAT-06=2، PAT-07=2، PAT-08=1، PAT-09=1، PAT-10=2، PAT-11=1، PAT-12=1، PAT-13=1، PAT-14=3، PAT-15=1، PAT-16=1، PAT-17=1، PAT-18=1، PAT-19=1، PAT-20=1، PAT-21=2. المجموع الحسابي المؤكد = **28**.

## 5. مصفوفة تنفيذ PAT-01 إلى PAT-21

كل مرجع بصري أدناه يعني ملف TS المذكور مع CSS المشترك في `src/css/{tokens,base,components,screens}.css` وصورة/تقرير الالتقاط الموافق داخل `docs/reviews/`.

| PAT | الاسم العربي / class المقترح | Feature والمسار | الحالات المحتفظة؛ المحذوفة | Shell | النقاط/التعقيد/الخطر |
|---|---|---|---|---|---|
| PAT-01 | الرئيسية / `HomeScreen` | `discovery/screens/home_screen.dart` | `patient-populated`, `guest-populated`؛ حذف loading, empty-discovery, offline, error | root/home | 4.0 / عالٍ / متوسط |
| PAT-02 | البحث والنتائج / `SearchScreen` | `discovery/screens/search_screen.dart` | results؛ حذف initial, searching, no-results, offline, error | detail | 2.5 / متوسط / منخفض |
| PAT-03 | تفاصيل الطبيب / `DoctorDetailsScreen` | `discovery/screens/doctor_details_screen.dart` | active؛ حذف no-bookable-availability, inactive, loading, error | detail | 2.5 / متوسط / منخفض |
| PAT-04 | تفاصيل الخدمة / `ServiceDetailsScreen` | `discovery/screens/service_details_screen.dart` | active؛ حذف no-capacity, inactive, loading, error | detail+bottomAction | 2.5 / متوسط / متوسط |
| PAT-05 | تفاصيل المنشأة والفرع / `FacilityDetailsScreen` | `discovery/screens/facility_details_screen.dart` | loaded؛ حذف location-unavailable, loading, error | detail | 2.5 / متوسط / متوسط |
| PAT-06 | التوفر واختيار اليوم / `AvailabilityScreen` | `booking/screens/availability_screen.dart` | bookable, no-capacity؛ حذف loading, last-seat-held, time-cutoff, stale, offline, error | detail+bottomAction | 3.5 / عالٍ / متوسط |
| PAT-07 | مراجعة الحجز / `BookingReviewScreen` | `booking/screens/booking_review_screen.dart` | pre-hold-review, active-hold؛ حذف acquiring-hold, capacity-loss, hold-expired, target-invalid, offline-unknown | detail+bottomAction | 3.5 / عالٍ / عالٍ |
| PAT-08 | الدفع الكامل / `PaymentScreen` | `payment/screens/payment_screen.dart` | ready؛ حذف handoff, returned-unverified, connectivity-interrupted, hold-near-expiry, hold-expired | detail+bottomAction | 2.5 / متوسط / متوسط |
| PAT-09 | نتيجة الدفع / `PaymentResultScreen` | `payment/screens/payment_result_screen.dart` | success-confirmed؛ حذف processing, failed, expired, under-review, payment-succeeded-booking-unresolved, refund-pending, refunded, offline | detail+bottomAction | 2.5 / متوسط / متوسط |
| PAT-10 | تأكيد الحجز / `BookingConfirmationScreen` | `booking/screens/booking_confirmation_screen.dart` | confirmed-paid, confirmed-pay-at-facility؛ لا حالات محذوفة | detail | 2.5 / متوسط / متوسط |
| PAT-11 | مواعيدي / `AppointmentsScreen` | `appointments/screens/appointments_screen.dart` | upcoming-populated؛ حذف loading, upcoming-empty, past-populated, past-empty, refreshing, offline, error | root/appointments | 2.5 / متوسط / منخفض |
| PAT-12 | تفاصيل الموعد / `AppointmentDetailsScreen` | `appointments/screens/appointment_details_screen.dart` | confirmed؛ حذف cancelled-by-patient, cancelled-by-facility, payment-variants, visit-queue-variants, manual-late, loading, offline | detail | 3.5 / عالٍ / متوسط |
| PAT-13 | تفاصيل الدفع / `PaymentDetailsScreen` | `payment/screens/payment_details_screen.dart` | succeeded؛ حذف due-at-facility, processing, failed, expired, under-review, refund-pending, refunded, loading, error | detail | 3.0 / متوسط / متوسط |
| PAT-14 | الزيارة والطابور / `VisitQueueScreen` | `visit/screens/visit_queue_screen.dart` | checked-in-waiting, called, completed؛ حذف not-checked-in, in-service, not-completed, no-show, manual-late, offline, stale | detail | 4.5 / عالٍ / عالٍ |
| PAT-15 | الإشعارات / `NotificationsScreen` | `notifications/screens/notifications_screen.dart` | populated-unread؛ حذف loading, empty, populated-read, deep-link-stale, offline, error | detail | 2.0 / منخفض / منخفض |
| PAT-16 | حسابي / `ProfileScreen` | `profile/screens/profile_screen.dart` | loaded؛ حذف loading, error, session-expired, logging-out, logged-out | root/profile | 2.0 / منخفض / منخفض |
| PAT-17 | تعديل الملف / `EditProfileScreen` | `profile/screens/edit_profile_screen.dart` | editing؛ حذف pristine, validation-error, saving, saved, save-failed, offline | detail | 2.5 / متوسط / متوسط |
| PAT-18 | الدخول للحساب / `AuthEntryScreen` | `auth/screens/auth_entry_screen.dart` | default؛ حذف return-intent, session-expired-context | detail | 1.5 / منخفض / منخفض |
| PAT-19 | رقم الهاتف / `PhoneScreen` | `auth/screens/phone_screen.dart` | idle؛ حذف editing, invalid, requesting-otp, existing-identity, unknown-identity, provider-unavailable, rate-limited, accepted | detail+bottomAction | 2.5 / متوسط / متوسط |
| PAT-20 | رمز واتساب / `WhatsAppOtpScreen` | `auth/screens/whatsapp_otp_screen.dart` | waiting؛ حذف verifying, invalid, expired, already-used, rate-limited, provider-unavailable, verified-existing, verified-new | detail+bottomAction | 3.0 / عالٍ / عالٍ |
| PAT-21 | استكمال المريض / `CompletePatientProfileScreen` | `auth/screens/complete_patient_profile_screen.dart` | editing, success؛ حذف pristine, validation-error, creating, recoverable-failure, duplicate-identity-conflict | detail+bottomAction في editing | 3.5 / عالٍ / متوسط |

### تفاصيل التركيب، البيانات، الحالة والتنقل ومعيار القبول

| PAT | المرجع وDesign System | Feature Widget / private Widgets | Mock Data | inbound → outbound والعقد | الحالة ومعيار التحقق المرئي |
|---|---|---|---|---|---|
| PAT-01 | `PAT01.ts`؛ SearchField, Button, Card, Badge, SectionHeading, InfoRows؛ DoctorCard, ServiceCard | لا ملف Feature Widget؛ `_HomeHero`, `_QuickActions`, `_UpcomingAppointmentSection`, `_AvailabilityFeaturePanel` تبقى private لأنها خاصة بهذه الشاشة | doctor/service + appointment للpatient، وغياب appointment للguest | `/`؛ من shell/نجاح التسجيل → search, doctor, service, facility, availability, appointment, notifications, root tabs | constructor enum `HomeAudience.patient/guest`؛ اختلاف guest يزيل الموعد القادم فقط؛ جميع الأقسام وترتيب RTL مطابق ولا overflow عند عرض 360px |
| PAT-02 | `PAT02.ts`؛ SearchField, Badge, Card | `_SearchFilters`, `_SearchResultTile` private؛ ليست نمطًا عالميًا لأن الشكل مختلط الأنواع ومحصور في search | query «طب الأسرة» و3 نتائج canonical | home → `/search` → doctor/service/facility | `StatelessWidget`؛ results فقط، chips مرئية ولا يلزم منطق filter؛ كل صف يرسل callback الصحيح |
| PAT-03 | `PAT03.ts`؛ Card, SectionHeading, InfoRows, Button؛ FacilitySummary, ServiceCard | `_DoctorProfileHeader`, `_ProfessionalBio` private | canonical doctor، services، facility، working days/hours | search/home/facility → `/doctors/doc-001` → facility/service/availability | `StatelessWidget`؛ active فقط؛ bottom action «عرض المواعيد المتاحة» ولا inactive/no-capacity |
| PAT-04 | `PAT04.ts`؛ Badge, Card, SectionHeading, Button؛ PolicyCard, FacilitySummary | `_ServiceHero`, `_ServicePricePanel`, `_EstimatedDuration` private | consultation service 15,000 ر.ي، full electronic policy، duration 30، facility | search/home/doctor/facility → `/services/svc-family-consult` → facility/availability | `StatelessWidget`؛ active؛ ثلاث سياسات واضحة وpolicy غير قابلة للتغيير |
| PAT-05 | `PAT05.ts`؛ Badge, Card, SectionHeading, InfoRows, Button, Notice؛ DoctorCard, ServiceCard | `_FacilityIdentity`, `_LocationPreview` private؛ preview مستخدم مرة ولا يبرر global map component | canonical facility، doctor، خدمتان، phone/hours/address | discovery/PAT-10/PAT-12 → `/facilities/fac-aafiatak-tahrir` → doctor/service | `StatelessWidget`؛ loaded؛ معاينة محايدة بلا SDK خرائط، قيم الهاتف LTR، notice السعة منشور |
| PAT-06 | `PAT06.ts`؛ Card, SectionHeading, Notice, Button؛ AppointmentSummary, ArrivalWindowCard | `widgets/availability_day_tile.dart` = `AvailabilityDayTile` لأنه تركيب يوم متكرر 7 مرات ومحصور في booking؛ `_AvailabilityCalendar` private | الأيام 14..20، selected day 18، arrival window، capacity flag | doctor/service/home → `/availability` → booking review | `StatefulWidget` + enum private `_AvailabilityView { bookable, noCapacity }`؛ اختيار يوم متاح/غير متاح يبدل العرض؛ no-capacity يخفي النافذة ويظهر التنبيه فقط؛ لا alert behavior حقيقي |
| PAT-07 | `PAT07.ts`؛ Card, Badge, Notice, Button؛ AppointmentSummary, ReservationHoldBanner, PolicyCard | `_BookingAmountBlock` private | appointment selection، full-payment policy، display countdown `09:42` كfixture لا كقاعدة | availability → `/booking/review` → payment | `StatefulWidget` + enum private `_BookingReviewView { preHoldReview, activeHold }`؛ CTA الأول ينفذ `setState`، والثاني callback للدفع؛ لا Timer ولا expiry |
| PAT-08 | `PAT08.ts`؛ Card, Notice, Button؛ ReservationHoldBanner | `_PaymentSafePanel` private | amount، doctor/service/date، countdown | booking review → `/payment` → payment result | `StatelessWidget` ready؛ زر متابعة يستدعي callback مباشرة إلى result mock، بلا card form/provider/handoff state |
| PAT-09 | `PAT09.ts`؛ StatusBlock, Card, InfoRows, Button | `_OperationDetails` private | paid amount، paymentReference، bookingNumber | payment → `/payment/result` → confirmation | `StatelessWidget` success-confirmed؛ يجب ظهور نجاح الدفع ونجاح الموعد ككتلتين منفصلتين |
| PAT-10 | `PAT10.ts`؛ Badge, Button, StatusBlock؛ AppointmentSummary, PolicyCard | `_ConfirmationHero` private | appointment، bookingNumber، policy paid/facility؛ لا PaymentIntent في facility | payment result أو pay-at-facility flow → `/booking/confirmation?policy=paid|facility` → appointment/facility/home | constructor enum `BookingPaymentPolicy`؛ Stateless؛ النص والstatus يتغيران فقط، ويظل الموعد مؤكدًا في الحالتين |
| PAT-11 | `PAT11.ts`؛ Card, Badge, InfoRows, Button | `widgets/appointment_list_card.dart` لأنه صف موعد متكرر وقابل لإعادة الاستخدام داخل appointments فقط؛ segmented past لا يُنفذ لأنه خارج النطاق | قائمة upcoming واحدة canonical | root tab → `/appointments` → appointment details/notifications/root tabs | `StatelessWidget`؛ upcoming-populated فقط؛ لا tabs تفاعلية لحالات محذوفة، البطاقة تفتح التفاصيل |
| PAT-12 | `PAT12.ts`؛ Card, Badge, InfoRows, StatusBlock, Button؛ PolicyCard | `_BookingProofCard`, `_DomainStatusSection` private | appointment، booking number، paid status، visit before-arrival | PAT-01/PAT-10/PAT-11/notification → `/appointments/apt-af-28931` → facility | `StatelessWidget` confirmed؛ لا زر cancel لأن حالته الناتجة خارج النطاق؛ يوضح staff check-in وعدم ضمان الدخول |
| PAT-13 | `PAT13.ts`؛ StatusBlock, Card, Button | `widgets/payment_receipt.dart` لأنه قسم إيصال ذو 4 حقول قد يتوسع داخل payment فقط؛ `_PaymentAmountBlock` private | succeeded payment، amount/reference/booking/service/facility | appointment/payment notification → `/appointments/apt-af-28931/payment` → appointment | `StatelessWidget` succeeded؛ receipt LTR للمراجع، لا refund ولا due-at-facility UI |
| PAT-14 | `PAT14.ts`؛ StatusBlock, Card, Notice, SectionHeading؛ AppointmentSummary, ArrivalWindowCard | لا ملف مستقل؛ `_QueueMetrics`, `_CalledQueuePanel`, `_LastUpdateCard` private لأنها أشكال خاصة بشاشة واحدة | appointment، position 3، `12:04 م`، call copy | appointment/queue notification → `/appointments/apt-af-28931/visit?state=waiting|called|completed` | `StatefulWidget` مع enum public صغير في ملف الشاشة `VisitQueueDemoState` وconstructor initialState؛ لا self-check-in. waiting metrics، called callout، completed status فقط؛ لا أزرار simulation في UI النهائي |
| PAT-15 | `PAT15.ts`؛ Card/tones | `widgets/notification_tile.dart` لأن العنصر يتكرر ويعزل unread وkind؛ محلي للnotifications لأنه يفسر نوع الإشعار | 3 notifications canonical مع unread=true للأولين | app bars → `/notifications` → appointment/payment/visit حسب kind | `StatelessWidget`؛ unread ظاهر بالنص والنقطة وليس اللون وحده؛ timestamp معزول عند الحاجة؛ كل kind callback صحيح |
| PAT-16 | `PAT16.ts`؛ Card, InfoRows, SectionHeading, Button | `_ProfileHero` private | أحمد بلال، initials «أب»، masked phone | root tab → `/profile` → edit/notifications/root tabs | `StatelessWidget` loaded؛ لا logout transition لأن الحالات غير مختارة؛ زر edit فقط ضمن التدفق المطلوب |
| PAT-17 | `PAT17.ts`؛ TextField, Card, SectionHeading, Button | `_VerifiedPhoneCard` private؛ لا يتكرر في profile Feature | patient fixture وinitial full name | profile → `/profile/edit` → back/profile بعد save callback | `StatefulWidget` controller للاسم فقط؛ editing فقط، زر حفظ callback محلي من دون saved/error state؛ dispose صحيح والهاتف غير قابل للتحرير |
| PAT-18 | `PAT18.ts`؛ Card, Button | `AuthIntro` من `auth/widgets/auth_intro.dart`؛ reusable في PAT-18..21، و`_PasswordlessInfoCard` private | لا domain data؛ copy ثابت | protected intent/manual → `/auth` → phone/home | `StatelessWidget` default؛ Login وCreate كلاهما إلى phone مع intent constructor، ولا email/password/SMS/social |
| PAT-19 | `PAT19.ts`؛ TextField, Card, Button | `AuthIntro`؛ `_WhatsAppInfoCard` private | neutral phone placeholder، `AuthIntent` القادم | auth → `/auth/phone?intent=login|register` → OTP | `StatefulWidget` controller للاستخدام التفاعلي لكن الحالة البصرية idle فقط؛ no validation/error/request state؛ phone LTR، CTA WhatsApp |
| PAT-20 | `PAT20.ts`؛ Card, Button | `AuthIntro`; `OtpInput` في `auth/widgets/otp_input.dart` لأنه تركيب تقني خاص؛ `VerifiedPhoneSummary` في `auth/widgets/verified_phone_summary.dart` ويستخدم أيضًا PAT-21 | masked verified phone، display OTP length=6 مع تعليق أنه fixture configurable لا قرار منتج | phone → `/auth/otp?intent=...` → complete profile للregister أو home للlogin حسب callback يحدده router | `StatefulWidget`، controller/FocusNodes محلية أو حقل digits بسيط؛ waiting فقط؛ RTL shell مع code LTR؛ لا resend timer/invalid/verified UI |
| PAT-21 | `PAT21.ts`؛ TextField, Card, StatusBlock, Button | `AuthIntro`, `VerifiedPhoneSummary`; `_SuccessContent` private | masked phone، initial name | OTP registration → `/auth/complete-profile` → home | `StatefulWidget` + enum private `_ProfileCompletionView { editing, success }`؛ CTA يبدل إلى success؛ النجاح بلا bottom action ويعرض متابعة home؛ لا validation/creating/failure |

## 6. البنية الدقيقة المقترحة للملفات

```text
lib/src/
├── features/
│   ├── discovery/
│   │   ├── screens/{home_screen,search_screen,doctor_details_screen,service_details_screen,facility_details_screen}.dart
│   │   └── mock_data.dart
│   ├── booking/
│   │   ├── screens/{availability_screen,booking_review_screen,booking_confirmation_screen}.dart
│   │   ├── widgets/availability_day_tile.dart
│   │   └── mock_data.dart
│   ├── payment/
│   │   ├── screens/{payment_screen,payment_result_screen,payment_details_screen}.dart
│   │   ├── widgets/payment_receipt.dart
│   │   └── mock_data.dart
│   ├── appointments/
│   │   ├── screens/{appointments_screen,appointment_details_screen}.dart
│   │   ├── widgets/appointment_list_card.dart
│   │   └── mock_data.dart
│   ├── visit/
│   │   ├── screens/visit_queue_screen.dart
│   │   └── mock_data.dart
│   ├── notifications/
│   │   ├── screens/notifications_screen.dart
│   │   ├── widgets/notification_tile.dart
│   │   └── mock_data.dart
│   ├── profile/
│   │   ├── screens/{profile_screen,edit_profile_screen}.dart
│   │   └── mock_data.dart
│   └── auth/
│       ├── auth_intent.dart
│       ├── screens/{auth_entry_screen,phone_screen,whatsapp_otp_screen,complete_patient_profile_screen}.dart
│       ├── widgets/{auth_intro,otp_input,verified_phone_summary}.dart
│       └── mock_data.dart
└── app/routing/{app_routes,app_router}.dart  # مهمة تكامل لاحقة فقط
```

لا تنشأ `widgets/` في discovery/profile/visit لأنه لا يوجد استخراج متعدد الشاشات يبررها. Widgets المذكورة كـprivate تبقى في ملف الشاشة. لا يُنشأ `lib/src/mock_data/app_mock_data.dart` في هذه المرحلة؛ السبب هو أن الفروع الثلاثة تبدأ بالتوازي من baseline واحد، وملف مشترك جديد سيخلق اعتمادًا صلبًا أو تعارضًا. بدلًا منه يوجد عقد قيم canonical أدناه، وتحتفظ كل Feature بأقل subset تحتاجه وبالقيم نفسها حرفيًا. هذا تكرار عرض محدود ومراقب، وليس ثلاث نسخ لنموذج domain مختلف.

### قرارات Feature-local Widgets

| الملف | الشاشات المستهلكة | سبب الاستخراج | لماذا ليس Global Design System |
|---|---|---|---|
| `booking/widgets/availability_day_tile.dart` | PAT-06 | سبعة عناصر متكررة بحدود selection/availability واضحة | معنى اليوم والسعة خاص بتدفق booking ولا يتكرر بين Features |
| `payment/widgets/payment_receipt.dart` | PAT-13 | قسم إيصال متعدد الصفوف يحتاج ملفًا مقروءًا وقابلًا للتوسع داخل payment | يعرض حقول دفع عافيتك المحددة وليس surface عامًا |
| `appointments/widgets/appointment_list_card.dart` | PAT-11 | عنصر قائمة متكرر يحتفظ بـstatus وCTA | `AppointmentSummary` يغطي النمط المشترك؛ هذا الشكل خاص بقائمة appointments |
| `notifications/widgets/notification_tile.dart` | PAT-15 | ثلاثة عناصر تتشارك kind/unread/time وsemantics | تفسير `NotificationKind` وunread خاص بالFeature |
| `auth/widgets/auth_intro.dart` | PAT-18..PAT-21 | hero نصي متكرر في أربع شاشات Auth | لا يوجد تكرار خارج Auth |
| `auth/widgets/otp_input.dart` | PAT-20 | تركيب خلايا/Focus متخصص يثقل ملف الشاشة | OTP ليس input عامًا ولا يجوز توسيع `AafiatakTextField` له |
| `auth/widgets/verified_phone_summary.dart` | PAT-20 وPAT-21 | هاتف موثق masked يتكرر بحماية LTR | معنى «موثق» خاص بتدفق Auth |
| `auth/auth_intent.dart` | PAT-18..PAT-20 | enum عقد تدفق `login/register` مشترك بين ملفات Auth | ليس Widget ولا app-wide state؛ يبقى داخل Feature |

## 7. عقد Mock Data المشترك

القيم العابرة للFeatures مجمدة للميلستون:

| الكيان | القيم canonical |
|---|---|
| Doctor | id=`doc-001`، initials=`س.ع`، name=`د. سارة عبدالله`، specialty=`طب الأسرة`، department=`الرعاية الأولية`، qualification=`زمالة في طب الأسرة` |
| Facility | id=`fac-aafiatak-tahrir`، name=`مركز عافيتك التخصصي`، branch=`فرع التحرير`، city=`صنعاء`، region=`أمانة العاصمة`، address=`شارع التحرير، بجوار الساحة العامة` |
| Service | id=`svc-family-consult`، name=`استشارة طب الأسرة`، amount=`15,000 ر.ي`، policy=`الدفع الكامل إلكترونيًا`، duration=`30 دقيقة تقريبًا` |
| Appointment | id=`apt-af-28931`، date=`الأربعاء 18 سبتمبر 2026`، arrivalWindow=`10:00 – 10:30`، bookingNumber=`AF-28931` |
| Payment | amount=`15,000 ر.ي`، currency=`YER` للبيانات و`ر.ي` للعرض، paymentReference=`PAY-2026-1847` |
| Patient | id=`pat-001`، name=`أحمد بلال`، initials=`أب`، maskedPhone=`+[رمز الدولة] ••• ••15` |
| Queue | approximateAhead=`3`، lastUpdated=`12:04 م` |

`09:42` وOTP length `6` قيمتا presentation fixture فقط وليستا policy. النصوص الثابتة مثل عناوين الشاشات والأزرار لا توضع في Mock Data. يمنع إنشاء classes عامة ضخمة؛ const records/classes صغيرة داخل كل `mock_data.dart` تكفي.

## 8. عقد التنقل وملكية routing

الشاشات لا تستورد `app_routes.dart` ولا تنفذ `context.go/push` في فروع Features. كل Screen يستقبل callbacks مسماة للأفعال الخارجة، وتستقبل Domain Patterns callbacks من الشاشة. هذا يجعل كل فرع يحلل ويبني قبل وجود وجهته على فرع آخر. `BackButton` الافتراضي في `PatientShell.detail` يكفي للرجوع، أو يمرر router callback عند الحاجة.

| name | path | PAT | query/parameter |
|---|---|---|---|
| `home` | `/` | PAT-01 | `audience=patient|guest` اختياري للـQA |
| `search` | `/search` | PAT-02 | لا شيء |
| `doctorDetails` | `/doctors/:doctorId` | PAT-03 | `doc-001` |
| `serviceDetails` | `/services/:serviceId` | PAT-04 | `svc-family-consult` |
| `facilityDetails` | `/facilities/:facilityId` | PAT-05 | `fac-aafiatak-tahrir` |
| `availability` | `/availability` | PAT-06 | لا شيء؛ الحالة local |
| `bookingReview` | `/booking/review` | PAT-07 | لا شيء؛ الحالة local |
| `payment` | `/payment` | PAT-08 | لا شيء |
| `paymentResult` | `/payment/result` | PAT-09 | لا شيء |
| `bookingConfirmation` | `/booking/confirmation` | PAT-10 | `policy=paid|facility` |
| `appointments` | `/appointments` | PAT-11 | لا شيء |
| `appointmentDetails` | `/appointments/:appointmentId` | PAT-12 | `apt-af-28931` |
| `paymentDetails` | `/appointments/:appointmentId/payment` | PAT-13 | `apt-af-28931` |
| `visitQueue` | `/appointments/:appointmentId/visit` | PAT-14 | `state=waiting|called|completed` |
| `notifications` | `/notifications` | PAT-15 | لا شيء |
| `profile` | `/profile` | PAT-16 | لا شيء |
| `editProfile` | `/profile/edit` | PAT-17 | لا شيء |
| `authEntry` | `/auth` | PAT-18 | لا شيء |
| `phone` | `/auth/phone` | PAT-19 | `intent=login|register` |
| `whatsappOtp` | `/auth/otp` | PAT-20 | `intent=login|register` |
| `completeProfile` | `/auth/complete-profile` | PAT-21 | لا شيء |

Developer B هو مالك التكامل، لكنه **لا يلمس** router على فرع `feature/patient-booking-payment`. بعد دمج PRs الثلاثة في `develop` ينشئ `integration/patient-ui-navigation`، ويعدل وحده `app_routes.dart` و`app_router.dart`، ويستبدل وجهة starter، ويوصل callbacks، ويفحص deep links/query defaults والقوائم السفلية. لا يحذف `starter_screen.dart` في هذا الميلستون إلا بقرار مراجعة منفصل.

## 9. تعريف التبعيات وسجلها

- **HARD DEPENDENCY**: ملف/بوابة لا يمكن للخطوة أن تكتمل بدونه.
- **SOFT DEPENDENCY**: الوجهة غير موجودة بعد على الفرع، لكن callback/route contract يسمح بالاستمرار.
- **SHARED DEPENDENCY**: baseline وDesign System وPatientShell وقيم mock وأسماء routes المتفق عليها.

### التبعيات الصلبة — 27 gate/edge

| ID | من → إلى | السبب |
|---|---|---|
| H-01..H-02 | A-01 → A-02 → بقية تنفيذ A | pilot ثم اعتماده |
| H-03..H-05 | A-01 mock → A-04/A-05/A-06 | كيانات discovery canonical |
| H-06 | A-08 → A-09 | profile mock |
| H-07..H-09 | مهام A → A-10 → A-11 → A-12 | QA ثم validation ثم PR |
| H-10..H-12 | B-01 → B-02/B-03/B-04 | pilot/booking mock |
| H-13..H-14 | B-05 → B-06/B-07 | payment mock |
| H-15..H-17 | مهام B → B-08 → B-09 → B-10 | QA ثم validation ثم PR |
| H-18..H-21 | C-01 → C-02/C-03/C-04/C-05 | pilot وAuth widgets/mock |
| H-22 | C-06 → C-07 | appointments mock/widget |
| H-23..H-25 | مهام C → C-09 → C-10 → C-11 | QA ثم validation ثم PR |
| H-26 | A-12+B-10+C-11 merged → B-11 | router لا يستورد ملفات غير مدمجة |
| H-27 | B-11 → B-12 | integration QA بعد wiring |

### التبعيات المرنة — 13 عقد تنقل

| ID | المصدر → الوجهة | كيف لا تمنع العمل |
|---|---|---|
| S-01 | PAT-01 → PAT-02 | `onSearchTap` |
| S-02 | PAT-01 → PAT-06 | `onAvailabilityTap` |
| S-03 | PAT-01/PAT-02 → PAT-03/04/05 | callbacks بحسب البطاقة/النتيجة |
| S-04 | PAT-03 → PAT-06 | `onAvailabilityTap` |
| S-05 | PAT-04 → PAT-06 | `onAvailabilityTap` |
| S-06 | PAT-06 → PAT-07 | `onReviewTap` |
| S-07 | PAT-07 → PAT-08 | `onPaymentTap` بعد active hold |
| S-08 | PAT-08 → PAT-09 | `onContinuePaymentTap` |
| S-09 | PAT-09 → PAT-10 | `onConfirmationTap` |
| S-10 | PAT-10 → PAT-12/PAT-05/PAT-01 | ثلاثة callbacks صريحة |
| S-11 | PAT-15 → PAT-12/PAT-13/PAT-14 | dispatch بحسب `NotificationKind` داخل الشاشة لا داخل tile |
| S-12 | PAT-18→19→20→21→PAT-01 | callbacks مع `AuthIntent` بسيط |
| S-13 | root nav PAT-01/PAT-11/PAT-16 والإشعارات | `PatientTab` callback وعقد paths ثابت |

## 10. توزيع الملكية وميزان الحمل

| العضو | Features / PAT | تنفيذ الشاشات | QA/تنسيق | المجموع |
|---|---|---:|---:|---:|
| A | discovery PAT-01..05، notifications PAT-15، profile PAT-16..17 | 20.5 | 1.5 | **22.0** |
| B | booking PAT-06/07/10، payment PAT-08/09/13 | 17.5 | 1.5 + routing integration 2.5 | **21.5** |
| C | appointments PAT-11/12، visit PAT-14، auth PAT-18..21 | 21.0 | 1.5 | **22.5** |

التفاوت الأقصى نقطة واحدة فقط. لم يُقسم أي Feature بين عضوين. العدد ليس 7/7/7: A يملك 8 شاشات، B يملك 6، C يملك 7؛ التوازن مبني على الحالات والنماذج والتفاعل وWidgets والتكامل.

### مصفوفة ملكية الملفات

| المجال | المالك | غير مسموح للآخرين |
|---|---|---|
| `features/discovery/**`, `notifications/**`, `profile/**` | A | B وC |
| `features/booking/**`, `payment/**` | B | A وC |
| `features/appointments/**`, `visit/**`, `auth/**` | C | A وB |
| `app/routing/app_routes.dart`, `app_router.dart` | B على integration branch فقط | الجميع على Feature branches |
| `design_system/**`, `app/patient_shell.dart`, `app/aafiatak_app.dart`, `main.dart`, `pubspec.yaml`, `pubspec.lock`, `features/starter/**` | مجمد | الجميع دون موافقة صريحة |
| `Aafiatak_High_Fidelity_Prototype_v3.0/**` | read-only | الجميع دائمًا |

## 11. خطة Pilot

- A يبدأ بـPAT-01 لأنه composition/card-heavy ويختبر root shell وRTL وMock Data وDoctorCard/ServiceCard والنسختين guest/patient.
- B يبدأ بـPAT-07 لأنه interaction/state-heavy ويثبت enum محلي وانتقال pre-hold إلى active-hold وفصل `ReservationHold` عن `Appointment`.
- C يبدأ بـPAT-20 لأنه form/input وLTR-inside-RTL ويختبر Widget OTP وFocus/dispose وعقد `AuthIntent` من دون إضافة حالات غير مطلوبة.

Pilot gate مشترك: screenshot على 360×800 و390×844، لا overflow، لا ألوان محلية خارج tokens، imports عامة للDesign System، ملفات Mock Data منضبطة، private extraction معقول، و`flutter analyze` نظيف للفرع. بعد gate يكمل كل عضو على **نفس فرعه**.

## 12. الرسم التنفيذي المختصر والـcritical path

### سجل Tasks الكامل

| Task | Depends On / النوع | المالك | Creates | Modifies | Consumes | Unblocks |
|---|---|---|---|---|---|---|
| A-00 | baseline / SHARED | A | branch | — | SHA | A-01 |
| A-01 | A-00 / SHARED؛ destinations / SOFT | A | discovery mock, PAT-01 | — | DS, shell, mock contract | A-02, A-04..06 |
| A-02 | A-01 / HARD | A | — | PAT-01 عند الحاجة | Pilot checklist | A-03..09 |
| A-03 | A-02 / HARD؛ details / SOFT | A | PAT-02 | — | discovery mock | A-10 |
| A-04 | A-02+A-01 mock / HARD؛ PAT-06 / SOFT | A | PAT-03 | — | DS Patterns, discovery mock | A-10 |
| A-05 | A-02+A-01 mock / HARD؛ PAT-06 / SOFT | A | PAT-04 | — | DS Patterns, discovery mock | A-10 |
| A-06 | A-02+A-01 mock / HARD؛ detail routes / SOFT | A | PAT-05 | — | DS Patterns, discovery mock | A-10 |
| A-07 | A-02 / HARD؛ PAT-12/13/14 / SOFT | A | notification mock/tile/PAT-15 | — | notification contract | A-10 |
| A-08 | A-02 / HARD؛ root routes / SOFT | A | profile mock/PAT-16 | — | patient contract | A-09 |
| A-09 | A-08 / HARD؛ profile route / SOFT | A | PAT-17 | — | profile mock | A-10 |
| A-10 | A-03..09 / HARD | A | — | A files only | screenshots/checklist | A-11 |
| A-11 | A-10 / HARD | A | validation evidence | formatting fixes only | Flutter toolchain | A-12 |
| A-12 | A-11 / HARD | A | Feature PR | review fixes only | CodeRabbit | merge gate |
| B-00 | baseline / SHARED | B | branch | — | SHA | B-01 |
| B-01 | B-00 / SHARED؛ PAT-08 / SOFT | B | booking mock/PAT-07 | — | DS, shell, contract | B-02..04 |
| B-02 | B-01 / HARD | B | — | PAT-07 عند الحاجة | Pilot checklist | B-03..07 |
| B-03 | B-01+B-02 / HARD؛ PAT-07 / SOFT | B | day tile/PAT-06 | — | booking mock | B-08 |
| B-04 | B-01+B-02 / HARD؛ PAT-01/05/12 / SOFT | B | PAT-10 | — | booking mock | B-08 |
| B-05 | B-02 / HARD؛ PAT-09 / SOFT | B | payment mock/PAT-08 | — | payment contract | B-06..07 |
| B-06 | B-05 / HARD؛ PAT-10 / SOFT | B | PAT-09 | — | payment mock | B-08 |
| B-07 | B-05 / HARD؛ PAT-12 / SOFT | B | receipt/PAT-13 | — | payment mock | B-08 |
| B-08 | B-03..07 / HARD | B | — | B files only | screenshots/checklist | B-09 |
| B-09 | B-08 / HARD | B | validation evidence | formatting fixes only | Flutter toolchain | B-10 |
| B-10 | B-09 / HARD | B | Feature PR | review fixes only | CodeRabbit | merge gate |
| B-11 | merged A-12+B-10+C-11 / HARD | B | integration branch | router files only | 21 Screens, route contract | B-12 |
| B-12 | B-11 / HARD | B | integration PR | router fixes only | flow QA, CodeRabbit | milestone approval |
| C-00 | baseline / SHARED | C | branch | — | SHA | C-01 |
| C-01 | C-00 / SHARED؛ Auth routes / SOFT | C | auth intent/mock/widgets/PAT-20 | — | DS, shell, auth contract | C-02..05 |
| C-02 | C-01 / HARD | C | — | PAT-20 عند الحاجة | Pilot checklist | C-03..08 |
| C-03 | C-01+C-02 / HARD؛ PAT-19/home / SOFT | C | PAT-18 | — | auth widgets/intent | C-09 |
| C-04 | C-01+C-02 / HARD؛ PAT-20 / SOFT | C | PAT-19 | — | auth widgets/intent | C-09 |
| C-05 | C-01+C-02 / HARD؛ home / SOFT | C | PAT-21 | — | auth widgets/mock | C-09 |
| C-06 | C-02 / HARD؛ PAT-12/root routes / SOFT | C | appointment mock/card/PAT-11 | — | appointment contract | C-07 |
| C-07 | C-06 / HARD؛ PAT-05 / SOFT | C | PAT-12 | — | appointment mock | C-09 |
| C-08 | C-02 / HARD؛ PAT-12/15 / SOFT | C | visit mock/PAT-14 | — | queue contract | C-09 |
| C-09 | C-03..08 / HARD | C | — | C files only | screenshots/checklist | C-10 |
| C-10 | C-09 / HARD | C | validation evidence | formatting fixes only | Flutter toolchain | C-11 |
| C-11 | C-10 / HARD | C | Feature PR | review fixes only | CodeRabbit | merge gate/B-11 |

التسمية HARD في الجدول تشير إلى gates نفسها المسجلة في H-01..H-27؛ لا تُجمع مرات ظهورها في هذا العرض مرة ثانية. أما SOFT فتعود إلى العقود S-01..S-13.

| Task | يعتمد على / النوع | المالك | ينشئ | يعدل | يستهلك | يفتح |
|---|---|---|---|---|---|---|
| A-01 | baseline/SHARED | A | PAT-01 + discovery mock | لا شيء مشترك | DS/shell/canonical data | A pilot gate وPAT-03..05 |
| A-03..A-09 | A-02/HARD، routes/SOFT | A | بقية ملفات A | ملفات A فقط | contracts | A QA |
| B-01 | baseline/SHARED | B | PAT-07 + booking mock | لا شيء مشترك | DS/shell | B pilot gate |
| B-03..B-07 | B-02/HARD، routes/SOFT | B | بقية ملفات B | ملفات B فقط | contracts | B QA |
| C-01 | baseline/SHARED | C | PAT-20 + auth mock/widgets | لا شيء مشترك | DS/shell | C pilot gate وAuth |
| C-03..C-08 | C-02/HARD، routes/SOFT | C | بقية ملفات C | ملفات C فقط | contracts | C QA |
| A-12/B-10/C-11 | validation/HARD | كل مالك | PRs | Feature files فقط | CodeRabbit | merge to develop |
| B-11 | دمج الثلاثة/HARD | B | لا Feature files | routes فقط | كل Screens + route contract | navigation QA |
| B-12 | B-11/HARD | B | integration PR | routes فقط | app كامل | milestone approval |

الـcritical path هو أطول فرع تنفيذ، ويرجح C بسبب PAT-14 وPAT-20/21، ثم انتظار دمج PRs الثلاثة، ثم B-11/B-12. لا توجد تبعية صلبة بين أعضاء الفريق قبل الدمج.

## 13. استراتيجية Git وPR

1. كل عضو ينفذ `git fetch --all --prune` ويتحقق من baseline.
2. الفروع: `feature/patient-discovery-profile`، `feature/patient-booking-payment`، `feature/patient-appointments-auth`.
3. لا عمل مباشر على `develop` أو `main`، ولا merge لفرع زميل داخل Feature branch.
4. commits مقترحة: pilot، مجموعة Feature مكتملة، ثم QA/fixes؛ 3–5 commits لكل عضو، بلا micro-commits وبلا giant commit.
5. كل PR إلى `develop`، ثم CodeRabbit، والإصلاحات على الفرع نفسه.
6. ترتيب الدمج المقترح A ثم C ثم B، لأن ملفات Features منفصلة؛ الترتيب ليس اعتمادًا وظيفيًا.
7. بعد الثلاثة، B ينشئ `integration/patient-ui-navigation` من أحدث `develop` ويصل routing ويفتح PR منفصلًا.
8. بعد QA وموافقة milestone فقط ينتقل `develop` إلى `main`.

## 14. Definition of Done الموحد

- كل الحالات المختارة فقط مطابقة لنية High-Fidelity؛ لا loading/offline/error أو حالات أخرى غير معتمدة.
- العربية RTL صحيحة، والقيم التقنية/OTP/phone/reference/time معزولة LTR عند الحاجة.
- لا `RenderFlex overflow` عند 360px و390px، مع scrolling مناسب وbottom action غير حاجب.
- Design System الحالي مستخدم، ولا global component مكرر أو ألوان/حواف عشوائية.
- Screen file يركب الصفحة بوضوح؛ Feature Widgets هي فقط المذكورة؛ private Widgets لا تتحول لملفات صغيرة بلا قيمة.
- Mock Data يطابق العقد canonical، والنص الثابت لا ينتقل إلى mock.
- callbacks وعقد route محترمان؛ لا استيراد router داخل Feature files.
- لا state-management package ولا layers مؤسسية ولا l10n/ARB ولا dependencies جديدة.
- لا تعديل في المساحات المجمدة ولا High-Fidelity.
- `dart format --output=none --set-exit-if-changed lib` و`flutter analyze` ناجحان؛ `flutter build apk --debug` ناجح إذا بيئة Android متاحة.
- PR يصف PAT والحالات المنفذة، ويحتوي screenshots للPilot وللحالات البديلة المختارة.

## 15. التحقق الحالي وخطة QA النهائية

نتيجة baseline بتاريخ 2026-09-14:

| الأمر | النتيجة |
|---|---|
| `flutter pub get` | نجاح؛ توجد 3 إصدارات أحدث غير متوافقة مع القيود الحالية، ولا حاجة لتحديثها |
| `dart format --output=none --set-exit-if-changed lib` | نجاح؛ 33 ملفًا، 0 تغير |
| `flutter analyze` | نجاح؛ `No issues found`، 19.7 ثانية |
| `flutter build apk --debug` | نجاح؛ `build/app/outputs/flutter-apk/app-debug.apk`، نحو 364.2 ثانية |

QA النهائي بعد routing: تشغيل flows الرئيسية `home→search→details`, `doctor/service→availability→review→payment→result→confirmation→appointment`, root tabs، notifications deep destinations، وauth register/login callbacks. تُفحص الحالات 28 عبر constructors/query contracts من دون إبقاء أزرار developer-only في الواجهة.

## 16. سجل مراجعات الخطة العشر

| Pass | النتيجة |
|---|---|
| 1 Coverage Audit | PASS: PAT-01..PAT-21 = 21، كل شاشة مرة واحدة، A=8/B=6/C=7. |
| 2 State Audit | PASS: 28 بالضبط؛ قائمة المحذوف موثقة لكل PAT ولا حالة إضافية. |
| 3 File Ownership Audit | PASS: لا Feature file بمالكين؛ routes مع B لاحقًا؛ shared areas مجمدة. |
| 4 Dependency Audit | PASS: 27 hard gates داخل الفروع/التكامل، 13 soft contracts؛ لا انتظار بين الأعضاء قبل merge. |
| 5 Architecture Audit | PASS: setState/enum/constructor فقط؛ لا layers/packages/l10n زائد. |
| 6 Mock Data Audit | PASS: عقد canonical واحد بلا ملف مشترك متنازع عليه؛ static copy داخل UI. |
| 7 Navigation Audit | PASS: 21 route names/paths، callbacks قبل الدمج، integration owner واحد. |
| 8 Workload Balance Audit | PASS: 22.0/21.5/22.5؛ أقصى فرق 1.0. |
| 9 Member Consistency Audit | PASS بعد المقارنة: Features/PAT/files/points/pilots/branches مطابقة للملفات الثلاثة. |
| 10 Student Usability Audit | PASS: كل ملف عضو مستقل وفيه ترتيب، paths، Widgets، mocks، states، criteria، commits وPR gate. |

لا يوجد blocker تخطيطي متبقٍ. بدء التنفيذ مشروط فقط باعتماد PR التخطيطي وتسجيل SHA واحد تنطلق منه الفروع الثلاثة.
