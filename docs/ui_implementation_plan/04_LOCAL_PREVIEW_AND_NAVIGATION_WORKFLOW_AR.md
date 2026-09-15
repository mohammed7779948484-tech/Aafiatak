# سير المعاينة المحلية والتنقل أثناء تطوير واجهات Flutter

> **الحالة: إضافة إلزامية إلى خطة تنفيذ واجهات المريض.** هذا الملف يكمّل `00_MASTER_UI_IMPLEMENTATION_PLAN_AR.md` وملفات Developers A/B/C، ويحدد كيف يشغّل كل مطور شاشاته وحالاته ويتنقل بينها فعليًا أثناء التطوير قبل اكتمال `go_router` النهائي.

## 1. الهدف

لا يُقبل أن يكتب المطور الشاشات نظريًا ثم ينتظر مرحلة Route Integration لرؤيتها. كل مطور يجب أن يشغّل شاشاته على Flutter Emulator/جهاز أثناء البناء، يستخدم Hot Reload، يقارن مع High-Fidelity، ويجرب الحالات والتنقل داخل نطاقه قبل فتح Feature PR.

هذه الآلية تحقق شيئين معًا:

1. كل عضو يرى ويختبر عمله فعليًا من أول يوم.
2. لا نسمح للثلاثة بتعديل `main.dart` أو `app_router.dart` بالتوازي، وبالتالي لا نصنع تعارضات Git غير ضرورية.

## 2. القاعدة الأساسية: Local Preview منفصل عن التطبيق الحقيقي

أثناء العمل على Feature branch ينشئ المطور ملفًا **محليًا فقط**:

```text
lib/dev_preview.dart
```

هذا الملف ليس جزءًا من التطبيق النهائي، ولا يُرفع في Commit أو PR.

أضفه محليًا إلى `.git/info/exclude`:

```bash
printf '\n/lib/dev_preview.dart\n' >> .git/info/exclude
```

ثم تأكد:

```bash
git status --short
```

يجب ألا يظهر `lib/dev_preview.dart` ضمن الملفات المتتبعة.

ممنوع من أجل المعاينة تعديل:

```text
lib/main.dart
lib/src/app/aafiatak_app.dart
lib/src/app/routing/app_router.dart
lib/src/app/routing/app_routes.dart
```

الاستثناء الوحيد هو Developer B لاحقًا على فرع `integration/patient-ui-navigation` بعد دمج Feature PRs الثلاثة، وفق الخطة الرئيسية.

## 3. تشغيل المعاينة

يتأكد المطور أولًا من الأجهزة:

```bash
flutter devices
```

ثم يشغّل:

```bash
flutter run -t lib/dev_preview.dart
```

بعد ذلك يستخدم Hot Reload أثناء تعديل الشاشة بدل إعادة تشغيل التطبيق في كل مرة.

المعاينة يجب أن تستخدم Theme وRTL الحقيقيين للمشروع، من دون إضافة package جديد. نموذج مبسط:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

void main() {
  runApp(const DevPreviewApp());
}

class DevPreviewApp extends StatelessWidget {
  const DevPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AafiatakTheme.light,
      home: const PreviewHome(),
    );
  }
}
```

`PreviewHome` بسيط ومحلي داخل `dev_preview.dart`. لا يتحول إلى Design System component ولا production code.

## 4. Preview Menu إلزامي لكل عضو

بدل تغيير `home:` يدويًا كل مرة، يُفضّل أن يحتوي `dev_preview.dart` قائمة بسيطة لكل الشاشات والحالات التي يملكها العضو. كل عنصر يفتح شاشة/حالة محددة بواسطة `Navigator.push`.

لا تضف أي Debug Selector داخل ملفات الشاشات الحقيقية. اختيار الحالة لأغراض المعاينة يكون من `dev_preview.dart` عبر constructor/initial state المتفق عليه أو عبر الشاشة نفسها إذا كان الانتقال المحلي جزءًا من الـ28 حالة المعتمدة.

### Developer A — حالات المعاينة

يجب أن يستطيع فتح ومراجعة:

```text
PAT-01 patient-populated
PAT-01 guest-populated
PAT-02 results
PAT-03 active
PAT-04 active
PAT-05 loaded
PAT-15 populated-unread
PAT-16 loaded
PAT-17 editing
```

### Developer B — حالات المعاينة

```text
PAT-06 bookable
PAT-06 no-capacity
PAT-07 pre-hold-review
PAT-07 active-hold
PAT-08 ready
PAT-09 success-confirmed
PAT-10 confirmed-paid
PAT-10 confirmed-pay-at-facility
PAT-13 succeeded
```

### Developer C — حالات المعاينة

```text
PAT-11 upcoming-populated
PAT-12 confirmed
PAT-14 checked-in-waiting
PAT-14 called
PAT-14 completed
PAT-18 default
PAT-19 idle
PAT-20 waiting
PAT-21 editing
PAT-21 success
```

بهذا تكون **كل الحالات الـ28** قابلة للرؤية فعليًا أثناء التطوير قبل Route Integration النهائي.

## 5. التنقل داخل نطاق العضو أثناء التطوير

إذا كانت الشاشة الحالية والوجهة مملوكتين لنفس المطور، يربطهما داخل `dev_preview.dart` باستخدام `Navigator.push` و`MaterialPageRoute` فقط لأغراض المعاينة.

مثال مفاهيمي لـDeveloper B:

```dart
AvailabilityScreen(
  onReviewTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookingReviewScreen(
          onPaymentTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PaymentScreen(
                  onPaymentResultTap: () {
                    // افتح PAT-09 داخل preview.
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  },
  onAvailabilityAlertRequested: () {},
);
```

هذا **ليس** Routing production. الهدف أن يجرب المطور الأزرار، Back behavior، انتقال الشاشة، Scroll، Keyboard، وState flow داخل Feature الخاص به.

لا تستورد `go_router` داخل Feature screens أو داخل preview لهذا الغرض؛ `Navigator` المحلي كافٍ.

## 6. التنقل إلى شاشة يملكها عضو آخر

إذا كان callback يقود إلى Feature يملكه عضو آخر، لا ينتظر المطور اكتمال ذلك Feature ولا ينسخ شاشة زميله إلى فرعه.

مثال:

```text
Developer A:
PAT-03 Doctor Details
    ↓
PAT-06 Availability
Developer B
```

يبقى production screen مع العقد الحقيقي مثل:

```dart
final VoidCallback onAvailabilityTap;
```

وفي `dev_preview.dart` فقط، يربط callback بصفحة Placeholder محلية بسيطة:

```dart
onAvailabilityTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => const PreviewDestination(
        title: 'PAT-06 — Availability — owned by Developer B',
      ),
    ),
  );
},
```

الـPlaceholder يثبت أن الزر يستجيب والتنقل يعمل، من دون خلق dependency بين فروع الأعضاء.

لا يُنشأ Placeholder داخل `features/**` ولا يدخل Git.

## 7. تدفقات المعاينة المطلوبة لكل عضو

### Developer A

يجرب على الأقل:

```text
PAT-01 → PAT-02 → PAT-03/PAT-04/PAT-05
PAT-16 → PAT-17
PAT-01/Profile → PAT-15 عند الحاجة
```

أي انتقال إلى Booking/Appointments يذهب إلى Local Placeholder فقط حتى Route Integration.

### Developer B

يجرب كامل التدفق الذي يملكه:

```text
PAT-06 → PAT-07 → PAT-08 → PAT-09 → PAT-10
```

ويفتح PAT-13 مباشرة من Preview Menu لاختباره. الروابط من PAT-10/PAT-13 إلى Appointment/Home/Facility المملوكة لغيره تستخدم Placeholder محليًا.

### Developer C

يجرب:

```text
PAT-18 → PAT-19 → PAT-20
```

ولمسار التسجيل:

```text
PAT-18 → PAT-19 → PAT-20 → PAT-21
```

وكذلك:

```text
PAT-11 → PAT-12 → PAT-14
```

مع فتح حالات PAT-14 الثلاث من Preview Menu أو عبر `initialState`.

## 8. اختبار الحالات المتعددة

لا تضف Dropdown/Debug buttons إلى production screens فقط لتغيير الحالة.

الحالات ذات constructor/enum خارجي تُفتح من preview بالقيمة المطلوبة، مثل:

```dart
VisitQueueScreen(
  initialState: VisitQueueDemoState.waiting,
)
```

ثم Entry آخر في Preview Menu لـ`.called` وآخر لـ`.completed`.

PAT-10 يفتح مرتين من Preview Menu:

```text
BookingPaymentPolicy.paid
BookingPaymentPolicy.payAtFacility
```

PAT-01 يفتح بقيمتي audience المتفقتين. PAT-21 يمكن الوصول إلى `success` من التفاعل المحلي الطبيعي، ويمكن أيضًا توفير Entry معاينة مباشر فقط إذا كان constructor الحالي يسمح بذلك من دون تغيير public contract المتفق عليه.

إذا كانت الحالة الثانية ناتجة طبيعيًا من `setState` داخل الشاشة مثل PAT-07 أو PAT-21، يجب أيضًا اختبار الانتقال الفعلي إليها، وليس الاكتفاء بفتحها منفردة.

## 9. دورة العمل لكل شاشة

بعد إنشاء كل Screen Task في خطة العضو، الدورة الإلزامية هي:

```text
Implement
→ flutter run -t lib/dev_preview.dart
→ open exact PAT/state
→ compare with High-Fidelity
→ Hot Reload / fix
→ test interaction/navigation
→ test scroll/keyboard/back
→ check 360×800
→ check 390×844
→ capture screenshot when required
→ flutter analyze
→ then proceed to next task
```

لا ينتظر المطور نهاية Feature ليكتشف مشكلة overflow أو RTL أو constructor contract.

## 10. Visual QA على Emulator/Device

لكل Pilot، ولكل حالة بديلة مهمة، افحص على مقاسين مستهدفين تقريبًا:

```text
360×800
390×844
```

المطلوب:

- RTL صحيح.
- القيم التقنية/OTP/phone/references LTR عند الحاجة.
- لا `RenderFlex overflow`.
- Bottom action لا يحجب المحتوى.
- Keyboard لا يغطي الحقول/CTA.
- Scroll يصل لكل العناصر.
- Back يرجع إلى الشاشة السابقة في local preview.
- عناصر الحالة المختارة مطابقة للـHigh-Fidelity وفق قاعدة Retained-State Visual Fidelity.
- لا Debug controls تظهر داخل production screen.

لا تضف package مثل DevicePreview فقط لهذه المهمة.

## 11. قبل أي Commit وFeature PR

`dev_preview.dart` محلي وغير متتبع. قبل كل commit منطقي وقبل PR نفذ:

```bash
git status --short
git diff --check
dart format --output=none --set-exit-if-changed lib
flutter analyze
```

وعند بوابة PR النهائية، إذا Android متاح:

```bash
flutter build apk --debug
```

تحقق أن diff لا يحتوي:

```text
lib/dev_preview.dart
main.dart
app_router.dart
app_routes.dart
```

إلا `app_router.dart` و`app_routes.dart` لاحقًا في Integration PR المملوك لـDeveloper B فقط.

## 12. ما الذي يدخل Feature PR؟

يدخل فقط الكود الحقيقي المملوك للعضو:

```text
features/<owned-feature>/**
```

ولا يدخل Local Preview أو Placeholder أو Debug Menu.

يرفق PR screenshots للحالات المطلوبة ويذكر أن الشاشات شُغّلت فعليًا على Flutter عبر local preview.

## 13. Route Integration النهائي بعد دمج A/B/C

بعد دمج Feature PRs الثلاثة، ينشئ Developer B:

```text
integration/patient-ui-navigation
```

من أحدث `develop` ويطبق `go_router` الحقيقي في:

```text
lib/src/app/routing/app_routes.dart
lib/src/app/routing/app_router.dart
```

في هذه المرحلة فقط تتحول callbacks إلى Navigation حقيقي بين Features المختلفة.

مثال مفاهيمي:

```text
PAT-03 onAvailabilityTap
    ↓
context.push('/availability')
    ↓
PAT-06
```

ولا تتغير شاشة PAT-03 نفسها؛ فقط المستهلك للcallback يتغير من Local Preview إلى `go_router`.

## 14. Full Navigation QA بعد Route Integration

بعد التكامل يجب تشغيل التطبيق الحقيقي من entrypoint المعتاد:

```bash
flutter run
```

ثم اختبار الرحلات الفعلية، لا Preview:

```text
Home → Search → Details
Doctor/Service → Availability → Review → Payment → Result → Confirmation → Appointment
Home / Appointments / Profile root tabs
Notifications → Appointment / Payment / Visit
Auth login → Phone → WhatsApp OTP → Home
Auth register → Phone → WhatsApp OTP → Complete Profile → Home
Appointments → Appointment Details → Visit Queue
```

ويتم اختبار query/default mappings المحددة في Master، خصوصًا:

- PAT-10 `policy=facility` → `BookingPaymentPolicy.payAtFacility`.
- PAT-14 `state=checked-in-waiting` → `VisitQueueDemoState.waiting`.

بعد Route Integration يجب أن تكون **21 شاشة و28 حالة** قابلة للمراجعة داخل التطبيق الحقيقي بدون Debug controls.

## 15. تعديل تسلسل مهام الأعضاء — إلزامي

هذا الملف يضيف الخطوات التالية إلى خطط A/B/C من دون تغيير ملكية الشاشات أو نقاط الحمل:

1. بعد A-00/B-00/C-00: أنشئ Local Preview وأضفه إلى `.git/info/exclude`.
2. بعد كل Screen Task: شغّل الشاشة والحالات التي أنجزتها فعليًا عبر `flutter run -t lib/dev_preview.dart`.
3. إذا كانت الوجهة داخل نطاقك، اربطها مؤقتًا بـ`Navigator.push` في preview.
4. إذا كانت الوجهة لعضو آخر، استخدم Local Placeholder فقط.
5. في Pilot Gate: المعاينة والتفاعل والتنقل المحلي جزء من القبول، وليس screenshots فقط.
6. في Feature QA: مر على جميع حالاتك من Preview Menu.
7. قبل PR: تأكد أن preview/placeholder غير موجودين في Git.
8. بعد دمج A/B/C: Developer B ينفذ ويختبر `go_router` الحقيقي وفق Master.

## 16. Definition of Done الإضافي

لا تعتبر مهمة الشاشة أو Feature PR جاهزة إذا لم يتحقق التالي:

- تم تشغيل الشاشة فعليًا في Flutter Emulator/Device.
- تم فتح كل State مختارة تخص الشاشة.
- تمت تجربة callbacks المهمة.
- تمت تجربة التنقل المحلي بين الشاشات المملوكة لنفس العضو.
- تم تمثيل cross-owner destination بـPlaceholder محلي أثناء التطوير.
- تم اختبار Back/Scroll/Keyboard حيث تنطبق.
- تم فحص 360×800 و390×844 للحالات المهمة.
- لا Preview/Debug code داخل commit.
- Route Integration النهائي وحده يستخدم `go_router` لربط Features الثلاثة بعد الدمج.

بهذا تكون المعاينة البصرية والتنقل جزءًا من عملية التنفيذ اليومية، لا مرحلة مؤجلة إلى نهاية المشروع.
