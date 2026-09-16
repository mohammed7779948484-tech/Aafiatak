# خطة Developer A — Discovery + Notifications + Profile

## 1. بطاقة المهمة

- الفرع: `feature/patient-discovery-profile`.
- **Implementation Baseline:** `<IMPLEMENTATION_BASELINE_SHA>` الذي يعلنه المنسق من أحدث `origin/develop` بعد دفع تنظيف Design System.
- الملكية: `features/discovery/**`, `features/notifications/**`, `features/profile/**`.
- الشاشات: PAT-01، PAT-02، PAT-03، PAT-04، PAT-05، PAT-15، PAT-16، PAT-17.
- الحالات: **9** فقط.
- الحمل: 20.5 تنفيذ + 1.5 QA/PR = **22.0**.
- Pilot: PAT-01.

## 2. قاعدة الحالة المختارة

نفذ كامل الـUI المرئي للحالة المختارة، حتى لو كان زر داخلها يقود إلى حالة غير مختارة. لا تنفذ الحالة الهدف، لكن لا تحذف الزر/الcontrol من التصميم. ينطبق هذا خصوصًا على PAT-16: زر «تسجيل الخروج» يبقى ظاهرًا في `loaded` رغم أن logged-out ليست ضمن الـ9 حالات.

## 3. Mock canonical

- Doctor: `doc-001 / د. سارة عبدالله / طب الأسرة`.
- Facility: `fac-aafiatak-tahrir / مركز عافيتك التخصصي / فرع التحرير`.
- Service: `svc-family-consult / استشارة طب الأسرة / 15,000 ر.ي`.
- Appointment: `apt-af-28931 / AF-28931 / الجمعة 18 سبتمبر 2026 / 10:00 – 10:30`.
- Patient: `pat-001 / أحمد بلال / أب / +[رمز الدولة] ••• ••15`.

ملاحظة: الـHF الخام كتب «الأربعاء 18 سبتمبر 2026»؛ الخطة تستخدم اليوم الصحيح «الجمعة» بشكل مقصود وموثق.

## 4. الملفات التي تملكها

```text
lib/src/features/discovery/mock_data.dart
lib/src/features/discovery/screens/home_screen.dart
lib/src/features/discovery/screens/search_screen.dart
lib/src/features/discovery/screens/doctor_details_screen.dart
lib/src/features/discovery/screens/service_details_screen.dart
lib/src/features/discovery/screens/facility_details_screen.dart
lib/src/features/discovery/widgets/home_hero.dart
lib/src/features/discovery/widgets/quick_actions.dart
lib/src/features/discovery/widgets/upcoming_appointment_section.dart
lib/src/features/notifications/mock_data.dart
lib/src/features/notifications/screens/notifications_screen.dart
lib/src/features/notifications/widgets/notification_tile.dart
lib/src/features/profile/mock_data.dart
lib/src/features/profile/screens/profile_screen.dart
lib/src/features/profile/screens/edit_profile_screen.dart
```

## 5. ممنوع لمسها

`lib/src/design_system/**`, `lib/src/app/**`, `lib/main.dart`, `pubspec.yaml`, `pubspec.lock`, `features/starter/**`, Features B/C، وكل `Aafiatak_High_Fidelity_Prototype_v3.0/**`. لا تضف dependency أو l10n أو router import أو ملف mock عالمي.

## 6. Public Contracts التي يجب الالتزام بها

- `HomeScreen`: `HomeAudience` + callbacks للبحث والتوفر والطبيب والخدمة والمنشأة والموعد والإشعارات و`ValueChanged<PatientTab>`.
- `SearchScreen`: callbacks doctor/service/facility مع IDs.
- `DoctorDetailsScreen`: `doctorId` + callbacks facility/service/availability.
- `ServiceDetailsScreen`: `serviceId` + callbacks facility/availability.
- `FacilityDetailsScreen`: `facilityId` + callbacks doctor/service/showLocation/call.
- `NotificationsScreen`: callbacks appointment/payment/visit حسب `NotificationKind`.
- `ProfileScreen`: callbacks edit/notifications/rootTab/logoutRequested.
- `EditProfileScreen`: `ValueChanged<String> onSave`.

لا تستورد `AppRoutes` أو `go_router`; Developer B يربط هذه callbacks لاحقًا.

## 7. Routes التي تستهلكها

- `/` PAT-01؛ `audience` يسمح patient أو guest، default patient.
- `/search` PAT-02.
- `/doctors/:doctorId` PAT-03.
- `/services/:serviceId` PAT-04.
- `/facilities/:facilityId` PAT-05.
- `/availability` وجهة يملكها B.
- `/appointments/:appointmentId` وجهة موعد يملكها C.
- `/appointments/:appointmentId/payment` وجهة الدفع يملكها B.
- `/appointments/:appointmentId/visit` وجهة الطابور يملكها C.
- `/notifications` PAT-15.
- `/profile` PAT-16.
- `/profile/edit` PAT-17.
- `/appointments` root tab يملكه C.

## 8. التسلسل الصارم

### A-00 — تجهيز الفرع

- يعتمد على: دفع تنظيف Design System وإعلان `IMPLEMENTATION_BASELINE_SHA`؛ `SHARED`.
- ينشئ/يعدل: لا شيء.
- التنفيذ:

```bash
git fetch --all --prune
git switch -c feature/patient-discovery-profile <IMPLEMENTATION_BASELINE_SHA>
git status
git rev-parse HEAD
flutter pub get
```

- القبول: HEAD يساوي SHA المعلن والشجرة نظيفة.
- commit: لا commit.
- التالي: A-01.

### A-01 — Pilot: PAT-01 Home

- الحالات: `patient-populated`, `guest-populated` فقط.
- يعتمد على: A-00؛ destination routes `SOFT`.
- المرجع: `PAT01.ts` + CSS المشترك.
- ينشئ:
  - `discovery/mock_data.dart`
  - `discovery/screens/home_screen.dart`
  - `discovery/widgets/home_hero.dart`
  - `discovery/widgets/quick_actions.dart`
  - `discovery/widgets/upcoming_appointment_section.dart`
- يستخدم: `PatientShell.root(scrollable:true)`, SearchField, Button, Card, Badge, SectionHeading, InfoRows, DoctorCard, ServiceCard.
- private داخل screen: `_AvailabilityFeaturePanel` وأقسام صغيرة لا تستحق ملفًا مستقلًا.
- لماذا extraction: الصفحة طويلة؛ `HomeHero`, `QuickActions`, `UpcomingAppointmentSection` sections واضحة وكبيرة بما يكفي لإبقاء screen ملف تركيب، دون تفتيت كل Row.
- Mock: discovery subset بالقيم canonical؛ بيانات إضافية محلية للبطاقات الثانوية مسموحة بشرط ألا تغير الكيان canonical عبر Features.
- الحالة: `StatelessWidget` مع `HomeAudience { patient, guest }`; guest يخفي الموعد القادم فقط.
- التنقل: callbacks حسب العقد العام.
- القبول: الترتيب البصري مطابق للHF، guest/patient مختلفان فقط بما يفرضه المرجع، لا loading/empty/offline/error، bottom nav home، لا overflow 360px.
- التحقق: format، analyze، screenshots 360×800 و390×844 للحالتين.
- commit: `feat(discovery): implement home pilot states`.
- التالي: A-02.

### A-02 — Pilot Gate

- يعتمد على A-01؛ `HARD`.
- يعدل فقط ملفات Pilot عند الحاجة.
- يفحص: public DS import، RTL، extraction المتزن، canonical data، callbacks بلا router، scrolling، no overflow/no local random colors.
- القبول: screenshots + `flutter analyze` نظيف.
- commit عند الحاجة: `fix(discovery): align home pilot with ui baseline`.
- التالي: A-03.

### A-03 — PAT-02 Search Results

- الحالة: `results` فقط.
- ينشئ: `discovery/screens/search_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, SearchField, Badge, Card، Material FilterChip/ChoiceChip من Theme.
- private: `_SearchFilters`, `_SearchSummary`, `_SearchResultTile`؛ النتيجة متكررة داخل شاشة واحدة لكن لا تستحق global component.
- Mock: query «طب الأسرة» وثلاث نتائج doctor/service/facility.
- الحالة: Stateless.
- القبول: SearchField + chips + 3 results كما في HF؛ لا initial/searching/no-results.
- commit: ضمن `feat(discovery): implement search and detail screens`.
- التالي: A-04.

### A-04 — PAT-03 Doctor Details

- الحالة: `active`.
- ينشئ: `doctor_details_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true, bottomAction: ...)`, Card, SectionHeading, InfoRows, Button, FacilitySummary, ServiceCard.
- private: `_DoctorProfileHeader`, `_ProfessionalBio`.
- Mock: bio/qualification/department/services/hours/facility.
- callbacks: facility/service/availability.
- القبول: كل أقسام `active` مرئية، وbottom action الثابت «عرض المواعيد المتاحة»، لا inactive/no-availability/loading/error.
- التالي: A-05.

### A-05 — PAT-04 Service Details

- الحالة: `active`.
- ينشئ: `service_details_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Badge, Card, SectionHeading, Button, PolicyCard, FacilitySummary.
- private: `_ServiceHero`, `_ServicePricePanel`, `_EstimatedDuration`.
- Mock: service/amount/full-payment/duration/facility.
- القبول: policy cards الثلاثة ومدة الخدمة وfacility summary وbottom action كلها موجودة؛ لا no-capacity/inactive/error.
- التالي: A-06.

### A-06 — PAT-05 Facility Details

- الحالة: `loaded`.
- ينشئ: `facility_details_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, Badge, Card, SectionHeading, InfoRows, Button, Notice, DoctorCard, ServiceCard.
- private: `_FacilityIdentity`, `_LocationPreview`.
- callbacks: showLocation/call/doctor/service presentation-only أو navigation callbacks حسب العقد.
- القبول: preview محايد بلا SDK خرائط، address/contact/hours، doctor/services، notice السعة، phone LTR.
- commit: `feat(discovery): implement search and detail screens`.
- التالي: A-07.

### A-07 — PAT-15 Notifications

- الحالة: `populated-unread`.
- ينشئ: `notifications/mock_data.dart`, `notifications/widgets/notification_tile.dart`, `notifications/screens/notifications_screen.dart`.
- Scroll: `NotificationsScreen` body يملك `ListView`; لا `PatientShell.scrollable:true` حتى لا يحدث nested scrolling.
- `NotificationTile`: presentation-only، لا navigation داخله.
- الشاشة dispatch حسب `NotificationKind` إلى callbacks appointment/payment/visit.
- القبول: 3 عناصر، unread يظهر بالنقطة والنص وليس اللون فقط، لا mark-as-read أو stale/empty/error states.
- commit: `feat(notifications): implement unread notification center`.
- التالي: A-08.

### A-08 — PAT-16 Profile

- الحالة: `loaded` فقط.
- ينشئ: `profile/mock_data.dart`, `profile/screens/profile_screen.dart`.
- يستخدم: `PatientShell.root(scrollable:true)`, Card, InfoRows, SectionHeading, Button.
- private: `_ProfileHero`.
- **Retained-State Fidelity:** يعرض زري «تعديل البيانات» و«تسجيل الخروج» كما في HF. `onLogoutRequested` presentation-only ولا ينشئ logged-out state.
- التنقل: edit/notifications/root tab/logoutRequested callbacks.
- القبول: root title «حسابي»، profile hero وبيانات الحساب، الهاتف LTR، الزران مرئيان.
- commit: مع A-09.
- التالي: A-09.

### A-09 — PAT-17 Edit Profile

- الحالة: `editing` فقط.
- ينشئ: `edit_profile_screen.dart`.
- يستخدم: `PatientShell.detail(scrollable:true)`, TextField, Card, SectionHeading, Button.
- private: `_VerifiedPhoneCard`.
- StatefulWidget مع TextEditingController وdispose؛ حقل الاسم فقط، الهاتف readonly.
- زر الحفظ موجود كما في HF ويرسل `onSave` فقط؛ لا saved/error UI.
- القبول: keyboard لا يحجب bottom content، لا validation/saving/saved states.
- commit: `feat(profile): implement profile and edit screens`.
- التالي: A-10.

### A-10 — Feature QA

- يعتمد على A-03 إلى A-09؛ `HARD`.
- يفحص **8 شاشات و9 حالات** فقط.
- يفحص Retained-State Fidelity خصوصًا PAT-16 logout control.
- يفحص 360/390، scroll، bottom bars، RTL/LTR، canonical mocks، constructor contracts.
- `rg "app_routes|go_router|Provider|Bloc|Riverpod"` على Features A يجب ألا يكشف اعتمادًا ممنوعًا.
- commit عند الحاجة: `fix(ui): polish discovery notifications and profile`.
- التالي: A-11.

### A-11 — Validation Gate

- format لملفات A ثم format check لكل `lib`.
- `flutter analyze`.
- `flutter build apk --debug` إذا Android متاحة.
- `git diff --check` و`git status`.
- القبول: لا ملفات خارج الملكية.
- التالي: A-12.

### A-12 — PR Ready

- PR: `feature/patient-discovery-profile → develop`.
- وصف PR يذكر **8 شاشات و9 حالات**، Pilot screenshots، نتائج analyze/build، و`IMPLEMENTATION_BASELINE_SHA`.
- CodeRabbit fixes على نفس الفرع.
- ممنوع routing أو shared changes.
- commit review عند الحاجة: `fix(ui): address review feedback for discovery profile scope`.

## 9. PR Checklist

- [ ] 8 شاشات، 9 حالات فقط.
- [ ] PAT-01 بالحالتين وصور 360/390.
- [ ] `HomeScreen` غير متكدس؛ ملفات widgets الثلاثة موجودة ومبررة.
- [ ] PAT-16 يحافظ على logout button بصريًا بلا logged-out state.
- [ ] no router imports / no shared changes / no HF changes.
- [ ] canonical date = الجمعة 18 سبتمبر 2026.
- [ ] Scroll strategy مطبقة، PAT-15 بلا nested ListView.
- [ ] constructor/callback contracts مطابقة للMaster.
- [ ] format/analyze/build و`git diff --check` ناجحة.
- [ ] CodeRabbit threads محلولة قبل الدمج.
