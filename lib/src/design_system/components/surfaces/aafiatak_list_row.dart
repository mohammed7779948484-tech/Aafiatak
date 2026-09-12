import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Domain-neutral, RTL-safe list row for menus and repeated summary lists.
///
/// Feature-specific rows such as notifications, doctors, appointments, or
/// queue entries belong in their feature/domain-pattern layer.
class AafiatakListRow extends StatelessWidget {
  const AafiatakListRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.semanticLabel,
    this.contentPadding = EdgeInsets.zero,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
  final String? semanticLabel;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: onTap != null,
      enabled: enabled,
      label: semanticLabel,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AafiatakSizes.minimumTouchTarget,
        ),
        child: ListTile(
          contentPadding: contentPadding,
          minVerticalPadding: AafiatakSpacing.xs,
          enabled: enabled,
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: enabled ? onTap : null,
        ),
      ),
    );
  }
}
