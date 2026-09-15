# خطة Developer A — Discovery + Notifications + Profile

## بطاقة المهمة والفرع

- الفرع: `feature/patient-discovery-profile`.
- baseline: `2c130c407979fc555652ae643d19369f2f7aad0c`.
- الملكية: `features/discovery/**` و`features/notifications/**` و`features/profile/**`.
- الشاشات: PAT-01، PAT-02، PAT-03، PAT-04، PAT-05، PAT-15، PAT-16، PAT-17.
- الحالات: PAT-01 `patient-populated/guest-populated`؛ وباقي الشاشات `results`, `active`, `active`, `loaded`, `populated-unread`, `loaded`, `editing`.
- الحمل: 20.5 نقطة تنفيذ + 1.5 QA/PR = **22.0**.
- Pilot: PAT-01، لأنه يختبر root shell والتركيب الطويل وDomain Patterns والنسخة guest/patient.

القيم المشتركة التي لا يجوز تغييرها: `doc-001 / د. سارة عبدالله`، `fac-aafiatak-tahrir / مركز عافيتك التخصصي / فرع التحرير`، `svc-family-consult / استشارة طب الأسرة / 15,000 ر.ي`، `apt-af-28931 / AF-28931 / الأربعاء 18 سبتمبر 2026 / 10:00 – 10:30`، والمريض `أحمد بلال / أب / +[رمز الدولة] ••• ••15`.

## حدود الملكية

### الملفات التي تملكها

```text
lib/src/features/discovery/mock_data.dart
lib/src/features/discovery/screens/home_screen.dart
lib/src/features/discovery/screens/search_screen.dart
lib/src/features/discovery/screens/doctor_details_screen.dart
lib/src/features/discovery/screens/service_details_screen.dart
lib/src/features/discovery/screens/facility_details_screen.dart
lib/src/features/notifications/mock_data.dart
lib/src/features/notifications/screens/notifications_screen.dart
lib/src/features/notifications/widgets/notification_tile.dart
lib/src/features/profile/mock_data.dart
lib/src/features/profile/screens/profile_screen.dart
lib/src/features/profile/screens/edit_profile_screen.dart
```

### ممنوع لمسها

`lib/src/design_system/**`، `lib/src/app/**` بما فيها `patient_shell.dart` وملفا routing، `lib/main.dart`، `pubspec.yaml`، `pubspec.lock`، `features/starter/**`، وكل `Aafiatak_High_Fidelity_Prototype_v3.0/**`، وFeatures العضوين B وC. لا تضف dependency أو l10n أو ملف mock مشترك.

### عقد التنقل الذي تستهلكه

لا تستورد `AppRoutes` ولا تستخدم `context.go/push`. مرر callbacks في constructors: home يستقبل search/availability/doctor/service/facility/appointment/notifications/root-tab؛ search يستقبل doctor/service/facility؛ details تستقبل الوجهات المبينة في المهام؛ notification dispatch يبقى في الشاشة حسب `NotificationKind`. سيصل Developer B هذه callbacks في integration PR.

| route name | path | علاقتك به |
|---|---|---|
| `home` | `/` | PAT-01؛ `audience=patient|guest` للـQA |
| `search` | `/search` | PAT-02 |
| `doctorDetails` | `/doctors/:doctorId` | PAT-03، id=`doc-001` |
| `serviceDetails` | `/services/:serviceId` | PAT-04، id=`svc-family-consult` |
| `facilityDetails` | `/facilities/:facilityId` | PAT-05، id=`fac-aafiatak-tahrir` |
| `availability` | `/availability` | destination يملكه B |
| `appointmentDetails` | `/appointments/:appointmentId` | destination للإشعار/home، id=`apt-af-28931` |
| `paymentDetails` | `/appointments/:appointmentId/payment` | destination payment notification |
| `visitQueue` | `/appointments/:appointmentId/visit` | destination queue notification |
| `notifications` | `/notifications` | PAT-15 |
| `profile` | `/profile` | PAT-16 |
| `editProfile` | `/profile/edit` | PAT-17 |
| `appointments` | `/appointments` | root tab destination يملكه C |

قاعدة `Must Not Touch` أعلاه تنطبق على كل Task أدناه حتى لو لم تُكرر داخل بند المهمة.

## التسلسل الصارم

### A-00 — تجهيز الفرع

- الهدف: ضمان بدء العمل من baseline نفسه.
- يعتمد على: اعتماد الخطة؛ النوع `SHARED`.
- ينشئ/يعدل: لا شيء.
- التنفيذ: `git fetch --all --prune` ثم `git switch -c feature/patient-discovery-profile 2c130c407979fc555652ae643d19369f2f7aad0c` ثم `flutter pub get` و`git status`.
- القبول/التحقق: HEAD مطابق وworking tree نظيفة.
- commit: لا commit.
- التالي: A-01.

### A-01 — Pilot: PAT-01 Home

- الهدف: تنفيذ الصفحة الرئيسية بالحالتين المعتمدتين فقط.
- يعتمد على: A-00؛ `SHARED` baseline/DS/mock contract. PAT-02/PAT-06/PAT-12 تبعيات `SOFT` عبر callbacks.
- المرجع: `src/ts/screens/PAT01.ts` وحالتي `patient-populated`, `guest-populated` وCSS `home-hero/home-discovery`.
- ينشئ: `lib/src/features/discovery/mock_data.dart` و`lib/src/features/discovery/screens/home_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.root`, `AafiatakSearchField`, `AafiatakButton`, `AafiatakCard`, `AafiatakBadge`, `AafiatakSectionHeading`, `AafiatakInfoRows`, `DoctorCard`, `ServiceCard`.
- Feature-local files: لا شيء؛ التكرار بين الشاشات تغطيه Patterns الحالية.
- private: `_HomeHero`, `_QuickActions`, `_UpcomingAppointmentSection`, `_AvailabilityFeaturePanel`.
- Mock Data: اكتب subset كامل discovery للdoctor/facility/services/appointment بالقيم canonical؛ static CTA/title copy يبقى في الشاشة.
- الحالة: `StatelessWidget` مع enum `HomeAudience { patient, guest }` وconstructor default patient؛ guest يحذف قسم الموعد القادم فقط.
- التنقل: entry `/`; callbacks إلى search، availability، doctor، service، facility، appointment، notifications، و`ValueChanged<PatientTab>` للجذر.
- ملاحظات: لا تنقل قيد 430px من الويب؛ استخدم العرض المتاح و`EdgeInsetsDirectional`.
- القبول: ترتيب hero→search→CTA→quick actions→optional appointment→feature panel→doctors→services؛ الفرق بين الحالتين محدد؛ brand app bar وhome nav؛ لا loading/empty/offline/error.
- التحقق: format للملفين، analyze، screenshots 360×800 و390×844 للحالتين، وفحص scroll/bottom nav.
- commit: `feat(discovery): implement home pilot states`.
- التالي: A-02.

### A-02 — Pilot Gate

- الهدف: مراجعة معيار الفريق قبل التوسع.
- يعتمد على: A-01؛ `HARD`.
- ينشئ/يعدل: إصلاحات في ملفي A-01 فقط عند الحاجة.
- فحص: public DS import، RTL، عدم over-componentization، canonical mock، callbacks بلا router import، لا overflow أو لون محلي.
- القبول: checklist موقع ذاتيًا وصور الحالتين و`flutter analyze` نظيف.
- commit: ضم الإصلاحات الصغيرة إلى commit pilot أو `fix(discovery): align home pilot with ui baseline`.
- التالي: A-03.

### A-03 — PAT-02 Search Results

- الهدف: عرض نتائج البحث المختلطة المعتمدة فقط.
- يعتمد على: A-02 `HARD`؛ وجهات details `SOFT`.
- المرجع/الحالة: `PAT02.ts`, `results` فقط.
- ينشئ: `lib/src/features/discovery/screens/search_screen.dart`.
- يعدل: لا شيء؛ يقرأ `discovery/mock_data.dart`.
- يستخدم: `PatientShell.detail`, `AafiatakSearchField`, `AafiatakBadge`, `AafiatakCard`, Material `FilterChip` أو `ChoiceChip` من theme.
- Feature-local: لا ملف. private: `_SearchFilters`, `_SearchSummary`, `_SearchResultTile`.
- Mock: query «طب الأسرة» وثلاث نتائج Doctor/Service/Facility canonical.
- الحالة: `StatelessWidget`; chips مرئية فقط، ولا تنفيذ filter/no-results.
- التنقل: home → search؛ result callbacks إلى PAT-03/04/05.
- القبول: 3 نتائج، النوع ليس لونًا فقط، chevron RTL صحيح، لا initial/searching/no-results/error.
- التحقق: format/analyze وفحص keyboard inset و360px.
- commit: يمكن جمعه مع A-04..A-06 تحت `feat(discovery): implement search and detail screens`.
- التالي: A-04.

### A-04 — PAT-03 Doctor Details

- الهدف: تفاصيل الطبيب active.
- يعتمد على: A-02 وملف discovery mock من A-01؛ `HARD`. PAT-06 `SOFT`.
- المرجع/الحالة: `PAT03.ts`, active.
- ينشئ: `lib/src/features/discovery/screens/doctor_details_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakSectionHeading`, `AafiatakInfoRows`, `AafiatakButton`, `FacilitySummary`, `ServiceCard`.
- private: `_DoctorProfileHeader`, `_ProfessionalBio`; لا Feature-local file.
- Mock: doctor bio/qualification/department/services/hours/facility.
- الحالة: `StatelessWidget`.
- التنقل: search/home/facility entry؛ callbacks facility، service، availability.
- القبول: هوية الطبيب، نبذة، منشأة، خدمتان، ساعات؛ bottom action متاح؛ لا inactive/no-availability/loading/error.
- التحقق: scroll طويل وLTR للساعات وanalyze.
- commit: مع حزمة discovery details.
- التالي: A-05.

### A-05 — PAT-04 Service Details

- الهدف: تنفيذ الخدمة active وسياسة الدفع الثابتة.
- يعتمد على: A-02 وA-01 mock؛ `HARD`. PAT-06 `SOFT`.
- المرجع/الحالة: `PAT04.ts`, active.
- ينشئ: `lib/src/features/discovery/screens/service_details_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakBadge`, `AafiatakCard`, `AafiatakSectionHeading`, `AafiatakButton`, `PolicyCard`, `FacilitySummary`.
- private: `_ServiceHero`, `_ServicePricePanel`, `_EstimatedDuration`.
- Mock: service id/name/amount/full payment/duration/doctor/facility.
- الحالة: `StatelessWidget`.
- التنقل: discovery entries؛ callbacks facility وavailability.
- القبول: amount LTR و`ر.ي`، policy معروضة وغير قابلة للتبديل، 3 PolicyCards، bottom CTA؛ لا no-capacity/inactive/error.
- التحقق: 360px، text scale عادي، format/analyze.
- commit: مع حزمة discovery details.
- التالي: A-06.

### A-06 — PAT-05 Facility Details

- الهدف: loaded facility بلا تكامل خرائط.
- يعتمد على: A-02 وA-01 mock؛ `HARD`.
- المرجع/الحالة: `PAT05.ts`, loaded.
- ينشئ: `lib/src/features/discovery/screens/facility_details_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakBadge`, `AafiatakCard`, `AafiatakSectionHeading`, `AafiatakInfoRows`, `AafiatakButton`, `AafiatakNotice`, `DoctorCard`, `ServiceCard`.
- private: `_FacilityIdentity`, `_LocationPreview`.
- Mock: address/city/region/masked phone/hours + doctor/services.
- الحالة: `StatelessWidget`؛ «اتصال» و«عرض الموقع» UI callbacks فقط.
- التنقل: entry من discovery/confirmation/appointment؛ doctor/service callbacks.
- القبول: preview محايد، لا map SDK، phone LTR، notice السعة المنشورة، لا location-unavailable/loading/error.
- التحقق: taps تستدعي callbacks وformat/analyze.
- commit: `feat(discovery): implement search and detail screens`.
- التالي: A-07.

### A-07 — PAT-15 Notifications

- الهدف: populated-unread قابل للقراءة والتنقل حسب النوع.
- يعتمد على: A-02؛ `HARD` pilot gate. PAT-12/13/14 `SOFT`.
- المرجع/الحالة: `PAT15.ts`, populated-unread.
- ينشئ: `lib/src/features/notifications/mock_data.dart`, `lib/src/features/notifications/widgets/notification_tile.dart`, `lib/src/features/notifications/screens/notifications_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakCard`, `AafiatakFeedbackTone`, Material icons.
- Feature Widget: `NotificationTile` لأنه يتكرر 3 مرات ويعزل layout وunread semantics؛ لا ينفذ navigation. private في الشاشة: `_NotificationList` فقط إن حسن القراءة.
- Mock: queue/appointment/payment notifications من HF، الأولان unread، timestamps canonical.
- الحالة: `StatelessWidget`; لا mark-as-read behavior.
- التنقل: app bars entry؛ الشاشة تحول `NotificationKind` إلى onVisit/onAppointment/onPayment callbacks.
- القبول: unread يظهر بالنقطة وبنص «غير مقروء»، 3 عناصر بترتيب زمني، لا deep-link-stale/empty/error.
- التحقق: Semantics، 360px، format/analyze.
- commit: `feat(notifications): implement unread notification center`.
- التالي: A-08.

### A-08 — PAT-16 Profile

- الهدف: loaded profile root.
- يعتمد على: A-02؛ `HARD` pilot gate.
- المرجع/الحالة: `PAT16.ts`, loaded.
- ينشئ: `lib/src/features/profile/mock_data.dart`, `lib/src/features/profile/screens/profile_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.root`, `AafiatakCard`, `AafiatakInfoRows`, `AafiatakSectionHeading`, `AafiatakButton`.
- private: `_ProfileHero`; لا widgets directory.
- Mock: canonical patient name/initials/masked phone.
- الحالة: `StatelessWidget`.
- التنقل: root tab entry؛ edit وnotifications وroot tab callbacks.
- القبول: profile hero وبيانات الحساب وedit؛ لا session/logout states ولا زر logout يؤدي لحالة غير معتمدة.
- التحقق: bottom nav active profile، phone LTR، format/analyze.
- commit: يمكن جمعه مع A-09.
- التالي: A-09.

### A-09 — PAT-17 Edit Profile

- الهدف: editing form للاسم فقط.
- يعتمد على: A-08 mock؛ `HARD`.
- المرجع/الحالة: `PAT17.ts`, editing.
- ينشئ: `lib/src/features/profile/screens/edit_profile_screen.dart`.
- يعدل: لا شيء.
- يستخدم: `PatientShell.detail`, `AafiatakTextField`, `AafiatakCard`, `AafiatakSectionHeading`, `AafiatakButton`.
- private: `_VerifiedPhoneCard`.
- Mock: initial full name وmasked verified phone من profile mock.
- الحالة: `StatefulWidget` مع `TextEditingController` وdispose؛ لا validation/saving/saved/error UI. الحفظ يستدعي callback فقط.
- التنقل: profile entry؛ save/back إلى profile وفق router callback.
- القبول: الاسم قابل للتحرير، الهاتف مرئي وغير قابل للتعديل، keyboard مناسب، لا حقول إضافية.
- التحقق: lifecycle controller، keyboard overflow، format/analyze.
- commit: `feat(profile): implement profile and edit screens`.
- التالي: A-10.

### A-10 — Feature QA

- يعتمد على: A-03..A-09؛ `HARD`.
- ينشئ: لا شيء. يعدل: ملفات ملكية A فقط لإصلاح visual/RTL.
- افحص الحالات التسع المعتمدة، قيم mock، callbacks، long scroll، bottom bars، 360/390، وعدم وجود state زائد.
- تحقق أن `rg "app_routes|go_router|Provider|Bloc|Riverpod" lib/src/features/discovery lib/src/features/notifications lib/src/features/profile` لا يكشف اعتمادًا ممنوعًا.
- commit: `fix(ui): polish discovery notifications and profile` عند الحاجة.
- التالي: A-11.

### A-11 — Validation Gate

- يعتمد على: A-10؛ `HARD`.
- الأوامر: `dart format lib/src/features/discovery lib/src/features/notifications lib/src/features/profile`; ثم format check لكل `lib`; `flutter analyze`; `flutter build apk --debug` إن كانت Android متاحة؛ `git diff --check`; `git status`.
- القبول: كل الأوامر ناجحة ولا ملفات خارج الملكية.
- commit: لا commit إلا formatting/fix ضمن commit QA.
- التالي: A-12.

### A-12 — PR Ready

- يعتمد على: A-11؛ `HARD`.
- قبل الدفع: راجع `git diff 2c130c4...HEAD --name-only` وHigh-Fidelity diff يجب أن يكون فارغًا.
- PR: `feature/patient-discovery-profile → develop`، مع قائمة PAT، الحالات العشر، screenshots للPilot، نتائج analyze/build، وعقد callbacks التي ينتظرها integration owner.
- CodeRabbit: عالج الملاحظات الصحيحة على الفرع نفسه؛ لا توسع scope أو تعدل shared files.
- branch ready عندما تكون checks نظيفة وreview threads محلولة ولا توجد TODOs معمارية.
- commit أخير عند الحاجة: `fix(ui): address review feedback for discovery profile scope`.
- التالي: انتظار الدمج؛ لا تنفيذ routing.

## PR checklist المختصر

- [ ] 8 شاشات و9 حالات فقط.
- [ ] Pilot PAT-01 موثق بالحالتين.
- [ ] لا ملف غير مملوك ولا تعديل High-Fidelity.
- [ ] لا duplicate global component، ولا widgets directory فارغ.
- [ ] canonical mock values ثابتة.
- [ ] callbacks تطابق route contract ولا `go_router` داخل Feature.
- [ ] RTL/LTR والـoverflow مفحوصة.
- [ ] format/analyze/build و`git diff --check` ناجحة.
- [ ] PR إلى `develop` وCodeRabbit fixes على الفرع نفسه.
