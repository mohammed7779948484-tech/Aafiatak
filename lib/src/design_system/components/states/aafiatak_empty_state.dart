import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../buttons/aafiatak_button.dart';

/// Empty state surface block matching the High-Fidelity .empty-state pattern.
class AafiatakEmptyState extends StatelessWidget {
  const AafiatakEmptyState({
    super.key,
    required this.title,
    required this.copy,
    this.icon,
    this.action,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String copy;
  final Widget? icon;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    Widget? actionWidget = action;
    if (actionWidget == null && actionLabel != null && onAction != null) {
      actionWidget = AafiatakButton(
        label: actionLabel!,
        variant: AafiatakButtonVariant.tonal,
        onPressed: onAction,
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.md,
        vertical: AafiatakSpacing.x2l,
      ),
      decoration: BoxDecoration(
        color: AafiatakColors.surface,
        borderRadius: AafiatakRadii.lg,
        border: Border.all(color: AafiatakColors.outline, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AafiatakColors.surfaceContainer,
              borderRadius: AafiatakRadii.lg,
            ),
            alignment: Alignment.center,
            child: icon != null
                ? IconTheme(
                    data: const IconThemeData(
                      size: 24,
                      color: AafiatakColors.textPrimary,
                    ),
                    child: icon!,
                  )
                : const Icon(
                    Icons.info_outline,
                    size: 24,
                    color: AafiatakColors.textPrimary,
                  ),
          ),
          const SizedBox(height: AafiatakSpacing.sm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AafiatakTypography.h3.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.xs),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              copy,
              textAlign: TextAlign.center,
              style: AafiatakTypography.bodySmall.copyWith(
                color: AafiatakColors.textSecondary,
              ),
            ),
          ),
          if (actionWidget != null) ...<Widget>[
            const SizedBox(height: AafiatakSpacing.md),
            actionWidget,
          ],
        ],
      ),
    );
  }
}
