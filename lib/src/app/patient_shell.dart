import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// التبويبات الرئيسية الثابتة في تجربة المريض.
///
/// يحتفظ كل تبويب باسمه وأيقونتيه فقط؛ أما تغيير المسار أو الشاشة فيبقى
/// مسؤولية طبقة التطبيق أو الـ Feature من خلال callback.
enum PatientTab {
  home('الرئيسية', Icons.home_outlined, Icons.home_rounded),
  appointments(
    'مواعيدي',
    Icons.calendar_today_outlined,
    Icons.calendar_month_rounded,
  ),
  profile('حسابي', Icons.person_outline_rounded, Icons.person_rounded);

  const PatientTab(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// شريط Material للشاشات الجذرية، ويدعم شعار عافيتك أو عنوان القسم.
///
/// استخدم وضع الشعار للرئيسية، ووضع العنوان لشاشات مثل «مواعيدي» و«حسابي».
/// زر الإشعارات [IconButton] أصلي، ويأتي تنسيقه من `IconButtonThemeData`.
class AafiatakRootAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AafiatakRootAppBar.brand({super.key, this.onNotificationPressed})
    : title = null;

  const AafiatakRootAppBar.titled({
    super.key,
    required this.title,
    this.onNotificationPressed,
  });

  final String? title;
  final VoidCallback? onNotificationPressed;

  @override
  Size get preferredSize => const Size.fromHeight(69);

  @override
  Widget build(BuildContext context) {
    final visibleTitle = title;

    return AppBar(
      toolbarHeight: 68,
      title: visibleTitle == null
          ? const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _BrandMark(),
                SizedBox(width: AafiatakSpacing.space12),
                Text(
                  'عافيتك',
                  style: TextStyle(
                    fontFamily: AafiatakTypography.fontFamily,
                    fontSize: 18,
                    height: 24 / 18,
                    color: AafiatakColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          : Text(visibleTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      actions: <Widget>[
        IconButton(
          onPressed: onNotificationPressed,
          tooltip: 'الإشعارات',
          icon: const Icon(Icons.notifications_none_rounded),
        ),
        const SizedBox(width: AafiatakSpacing.space8),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1),
      ),
    );
  }
}

/// شريط Material للشاشات الداخلية مع رجوع وعنوان ومعرّف شاشة اختياري.
///
/// لا ينفذ التنقل بنفسه عند تمرير [onBackPressed]؛ الشاشة أو الموجّه يحددان
/// السلوك. يعزل [screenId] باتجاه LTR لأنه معرّف تقني وليس نصًا عربيًا.
class AafiatakDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AafiatakDetailAppBar({
    super.key,
    required this.title,
    this.screenId,
    this.onBackPressed,
    this.trailing,
  });

  final String title;
  final String? screenId;
  final VoidCallback? onBackPressed;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(69);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 68,
      leading: BackButton(onPressed: onBackPressed),
      centerTitle: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (screenId != null)
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                screenId!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AafiatakTypography.caption,
              ),
            ),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
      actions: <Widget>[trailing ?? const SizedBox(width: 48)],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1),
      ),
    );
  }
}

/// تنقل المريض السفلي المبني مباشرة على [NavigationBar].
///
/// يعرض الحالة الحالية ويرسل اختيار المستخدم فقط؛ تحويل الاختيار إلى مسار
/// يبقى في التطبيق أو الشاشة ولا يوضع داخل هذا التركيب المشترك.
class AafiatakBottomNav extends StatelessWidget {
  const AafiatakBottomNav({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final PatientTab activeTab;
  final ValueChanged<PatientTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: PatientTab.values.indexOf(activeTab),
      onDestinationSelected: (index) => onTabSelected(PatientTab.values[index]),
      destinations: <NavigationDestination>[
        for (final tab in PatientTab.values)
          NavigationDestination(
            icon: Icon(tab.icon),
            selectedIcon: Icon(tab.selectedIcon),
            label: tab.label,
          ),
      ],
    );
  }
}

/// مساحة سفلية ثابتة لإجراء رئيسي مثل تأكيد الحجز.
///
/// تعتمد على [BottomAppBar] وتستقبل المحتوى فقط، لذلك لا تفرض منطقًا أو زرًا
/// بعينه على الشاشة.
class AafiatakBottomAction extends StatelessWidget {
  const AafiatakBottomAction({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AafiatakColors.borderSubtle)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AafiatakSpacing.space16),
          child: child,
        ),
      ),
    );
  }
}

/// الهيكل المشترك لشاشات المريض، وليس مكونًا بصريًا بدائيًا في Design System.
///
/// استخدمه بدل تكرار [Scaffold] وشريط التطبيق والتنقل في كل شاشة. يدعم شريطًا
/// جذريًا بالشعار أو بعنوان، وشريط تفاصيل يفرض عنوانًا غير فارغ.
/// يستخدم عرض الهاتف المتاح كاملًا، وتبقى قرارات التنقل وحالة الشاشة خارج هذا
/// الملف لدى التطبيق أو الـ Feature.
class PatientShell extends StatelessWidget {
  const PatientShell.root({
    super.key,
    required this.body,
    this.title = '',
    this.activeTab,
    this.onTabSelected,
    this.onNotificationPressed,
    this.bottomAction,
    this.scrollable = false,
  }) : root = true,
       screenId = null,
       onBackPressed = null,
       trailing = null,
       assert(
         (activeTab == null) == (onTabSelected == null),
         'يجب تمرير activeTab وonTabSelected معًا.',
       );

  const PatientShell.detail({
    super.key,
    required this.body,
    required this.title,
    this.screenId,
    this.onBackPressed,
    this.trailing,
    this.bottomAction,
    this.scrollable = false,
  }) : root = false,
       activeTab = null,
       onTabSelected = null,
       onNotificationPressed = null;

  final Widget body;
  final String? screenId;
  final String title;
  final bool root;
  final PatientTab? activeTab;
  final ValueChanged<PatientTab>? onTabSelected;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;
  final Widget? trailing;
  final Widget? bottomAction;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final bottomBar = bottomAction != null
        ? AafiatakBottomAction(child: bottomAction!)
        : activeTab != null
        ? AafiatakBottomNav(
            activeTab: activeTab!,
            onTabSelected: onTabSelected!,
          )
        : null;

    return Scaffold(
      appBar: root
          ? title.isEmpty
                ? AafiatakRootAppBar.brand(
                    onNotificationPressed: onNotificationPressed,
                  )
                : AafiatakRootAppBar.titled(
                    title: title,
                    onNotificationPressed: onNotificationPressed,
                  )
          : AafiatakDetailAppBar(
              title: title,
              screenId: screenId,
              onBackPressed: onBackPressed,
              trailing: trailing,
            ),
      body: SafeArea(
        top: false,
        child: scrollable ? SingleChildScrollView(child: body) : body,
      ),
      bottomNavigationBar: bottomBar,
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        color: AafiatakColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14),
          bottom: Radius.circular(18),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AafiatakColors.shadowSubtle,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.health_and_safety_outlined,
        color: AafiatakColors.surface,
        size: 20,
      ),
    );
  }
}
