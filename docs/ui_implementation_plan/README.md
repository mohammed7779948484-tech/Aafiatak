# UI Implementation Plan — نقطة الدخول للفريق

هذه المجلدات/الملفات هي الخطة التنفيذية المعتمدة لواجهات المريض.

ترتيب القراءة الإلزامي لكل عضو:

1. `00_MASTER_UI_IMPLEMENTATION_PLAN_AR.md` — مصدر الحقيقة العام: النطاق، 21 شاشة، 28 حالة، العقود، الملكية، Dependencies، Routes، QA.
2. ملف العضو:
   - Developer A → `01_DEVELOPER_A_PLAN_AR.md`
   - Developer B → `02_DEVELOPER_B_PLAN_AR.md`
   - Developer C → `03_DEVELOPER_C_PLAN_AR.md`
3. `04_LOCAL_PREVIEW_AND_NAVIGATION_WORKFLOW_AR.md` — **إلزامي لجميع الأعضاء** ويحدد كيف يشغّل كل مطور شاشاته وحالاته على Flutter أثناء التطوير، وكيف يختبر التنقل محليًا قبل Route Integration النهائي.

## قاعدة التعارض

- النطاق، الملكية، الحالات، العقود، والـRoutes النهائية يحكمها `00_MASTER_UI_IMPLEMENTATION_PLAN_AR.md`.
- آلية المعاينة المحلية، Hot Reload، اختبار الحالات أثناء التطوير، والتنقل المؤقت داخل Feature يحكمها `04_LOCAL_PREVIEW_AND_NAVIGATION_WORKFLOW_AR.md`.
- ملفات الأعضاء تحدد ترتيب مهام كل مطور، ويُضاف إليها سير المعاينة الموضح في الملف 04 بعد تجهيز الفرع وبعد كل Screen Task.

## قاعدة التنفيذ الحالية

بعد أي دمج جديد إلى `develop`، لا تستخدم SHA قديمًا محفوظًا في مستندات سابقة كنقطة بداية. يسجل المنسق أحدث `develop` SHA ويعلنه كـ`IMPLEMENTATION_BASELINE_SHA`، ثم تبدأ فروع A/B/C الثلاثة من نفس SHA.

لا يبدأ أي عضو تنفيذ الشاشات قبل قراءة الملفات الثلاثة المطلوبة أعلاه.
