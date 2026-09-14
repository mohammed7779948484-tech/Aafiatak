import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Navigation tabs available in the patient application shell.
enum PatientTab {
  home('الرئيسية', Icons.home_outlined, Icons.home_rounded),
  appointments(
    'مواعيدي',
    Icons.calendar_today_outlined,
    Icons.calendar_month_rounded,
  ),
  profile('حسابي', Icons.person_outline_rounded, Icons.person_rounded);

  const PatientTab(this.label, this.icon, this.activeIcon);

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

/// Root app bar for primary views (PAT-01 discovery, etc.).
class AafiatakRootAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AafiatakRootAppBar({
    super.key,
    this.titleBrand = true,
    this.title,
    this.onNotificationPressed,
  });

  final bool titleBrand;
  final String? title;
  final VoidCallback? onNotificationPressed;

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: AafiatakColors.canvas,
        border: Border(bottom: BorderSide(color: Color(0x10800020), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.space16,
        vertical: AafiatakSpacing.space8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (titleBrand)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AafiatakColors.brand,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AafiatakRadii.radius12),
                      topRight: Radius.circular(AafiatakRadii.radius12),
                      bottomLeft: Radius.circular(AafiatakRadii.radius16),
                      bottomRight: Radius.circular(AafiatakRadii.radius16),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.health_and_safety_outlined,
                      color: AafiatakColors.surface,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: AafiatakSpacing.space12),
                const Text(
                  'عافيتك',
                  style: TextStyle(
                    fontSize: 18,
                    height: 24 / 18,
                    fontWeight: FontWeight.w700,
                    color: AafiatakColors.brand,
                  ),
                ),
              ],
            )
          else
            Text(
              title ?? '',
              style: AafiatakTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          _ShellIconButton(
            icon: Icons.notifications_none_rounded,
            tooltip: 'الإشعارات',
            onPressed: onNotificationPressed,
          ),
        ],
      ),
    );
  }
}

/// Detail app bar for secondary/flow screens (PAT-02 to PAT-21).
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
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: AafiatakColors.canvas,
        border: Border(bottom: BorderSide(color: Color(0x10800020), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.space16,
        vertical: AafiatakSpacing.space8,
      ),
      child: Row(
        children: <Widget>[
          _ShellIconButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'رجوع',
            onPressed:
                onBackPressed ??
                () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (screenId != null)
                  Text(
                    screenId!,
                    style: AafiatakTypography.caption.copyWith(
                      color: AafiatakColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AafiatakColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 48, height: 48, child: trailing),
        ],
      ),
    );
  }
}

/// Bottom navigation bar conforming to the high-fidelity prototype.
class AafiatakBottomNav extends StatelessWidget {
  const AafiatakBottomNav({
    super.key,
    required this.activeTab,
    this.onTabSelected,
  });

  final PatientTab activeTab;
  final ValueChanged<PatientTab>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AafiatakColors.surface,
        border: Border(
          top: BorderSide(color: AafiatakColors.outline, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.space12,
        vertical: AafiatakSpacing.space8,
      ),
      child: Row(
        children: PatientTab.values.map((tab) {
          final isSelected = tab == activeTab;
          return Expanded(
            child: InkWell(
              onTap: onTabSelected != null ? () => onTabSelected!(tab) : null,
              borderRadius: BorderRadius.circular(AafiatakRadii.radius12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 48,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AafiatakColors.primaryContainer
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          AafiatakRadii.radiusFull,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          isSelected ? tab.activeIcon : tab.icon,
                          size: 20,
                          color: isSelected
                              ? AafiatakColors.brand
                              : AafiatakColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? AafiatakColors.brand
                            : AafiatakColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Sticky bottom action container for primary button / totals.
class AafiatakBottomAction extends StatelessWidget {
  const AafiatakBottomAction({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AafiatakSpacing.space16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AafiatakColors.surface,
        border: Border(
          top: BorderSide(color: AafiatakColors.outline, width: 1),
        ),
      ),
      padding: padding,
      child: SafeArea(top: false, child: child),
    );
  }
}

/// Patient application shell implementing phone container, headers, and navigation.
class PatientShell extends StatelessWidget {
  const PatientShell({
    super.key,
    required this.body,
    this.screenId,
    this.title,
    this.root = false,
    this.titleBrand = true,
    this.activeTab,
    this.onTabSelected,
    this.onBackPressed,
    this.onNotificationPressed,
    this.trailing,
    this.bottomAction,
    this.scrollable = false,
  });

  final Widget body;
  final String? screenId;
  final String? title;
  final bool root;
  final bool titleBrand;
  final PatientTab? activeTab;
  final ValueChanged<PatientTab>? onTabSelected;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;
  final Widget? trailing;
  final Widget? bottomAction;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = root
        ? AafiatakRootAppBar(
            titleBrand: titleBrand,
            title: title,
            onNotificationPressed: onNotificationPressed,
          )
        : AafiatakDetailAppBar(
            title: title ?? '',
            screenId: screenId,
            onBackPressed: onBackPressed,
            trailing: trailing,
          );

    final content = scrollable ? SingleChildScrollView(child: body) : body;

    return ColoredBox(
      color: AafiatakColors.canvas,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Scaffold(
            backgroundColor: AafiatakColors.canvas,
            appBar: appBar,
            body: SafeArea(
              top: false,
              bottom: activeTab == null && bottomAction == null,
              child: content,
            ),
            bottomNavigationBar: activeTab != null
                ? AafiatakBottomNav(
                    activeTab: activeTab!,
                    onTabSelected: onTabSelected,
                  )
                : null,
            bottomSheet: bottomAction != null
                ? AafiatakBottomAction(child: bottomAction!)
                : null,
          ),
        ),
      ),
    );
  }
}

class _ShellIconButton extends StatelessWidget {
  const _ShellIconButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xEBFFFFFF),
        borderRadius: BorderRadius.circular(AafiatakRadii.radius16),
        border: Border.all(color: const Color(0x141A1A1A), width: 1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AafiatakRadii.radius16),
          child: Center(
            child: Icon(icon, size: 22, color: AafiatakColors.brand),
          ),
        ),
      ),
    );
  }
}
