import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakInfoRow extends StatelessWidget {
  const AafiatakInfoRow({
    super.key,
    required this.label,
    this.value,
    this.leading,
    this.trailing,
    this.onTap,
    this.semanticLabel,
  });

  final String label;
  final String? value;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      container: true,
      button: onTap != null,
      label: semanticLabel,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: AafiatakSpacing.sm,
        leading: leading,
        title: Text(label, style: theme.textTheme.bodyMedium),
        subtitle: value == null
            ? null
            : Text(
                value!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
