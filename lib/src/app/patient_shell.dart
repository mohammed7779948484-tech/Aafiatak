import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

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

class AafiatakRootAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AafiatakRootAppBar({super.key, this.onNotificationPressed});

  final VoidCallback? onNotificationPressed;

  @override
  Size get preferredSize => const Size.fromHeight(69);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 68,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _BrandMark(),
          SizedBox(width: AafiatakSpacing.space12),
          Text(
            'عافيتك',
            style: TextStyle(
              color: AafiatakColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
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
            Text(
              screenId!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AafiatakTypography.labelSmall,
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

class AafiatakBottomAction extends StatelessWidget {
  const AafiatakBottomAction({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AafiatakColors.outline)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AafiatakSpacing.space16),
          child: child,
        ),
      ),
    );
  }
}

/// Shared phone shell. It uses the available device width without a web-preview cap.
class PatientShell extends StatelessWidget {
  const PatientShell({
    super.key,
    required this.body,
    this.screenId,
    this.title,
    this.root = false,
    this.activeTab,
    this.onTabSelected,
    this.onBackPressed,
    this.onNotificationPressed,
    this.trailing,
    this.bottomAction,
    this.scrollable = false,
  }) : assert(
         (activeTab == null) == (onTabSelected == null),
         'activeTab and onTabSelected must be provided together.',
       );

  final Widget body;
  final String? screenId;
  final String? title;
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
          ? AafiatakRootAppBar(onNotificationPressed: onNotificationPressed)
          : AafiatakDetailAppBar(
              title: title ?? '',
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
        borderRadius: AafiatakRadii.large,
      ),
      child: const Icon(
        Icons.health_and_safety_outlined,
        color: AafiatakColors.surface,
        size: 20,
      ),
    );
  }
}
