import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../data_display/aafiatak_badge.dart';
import 'aafiatak_feedback_tone.dart';

/// Status block widget matching the High-Fidelity `.status-block` pattern.
///
/// Features a white surface card, a 48x48 rounded icon chip styled by tone,
/// an optional tag badge, a bold title, and secondary supporting copy.
class AafiatakStatusBlock extends StatelessWidget {
  const AafiatakStatusBlock({
    super.key,
    required this.title,
    String? message,
    String? copy,
    this.tone = AafiatakFeedbackTone.neutral,
    this.icon,
    this.tag,
    this.action,
  }) : message = copy ?? message;

  final String title;
  final String? message;
  final AafiatakFeedbackTone tone;
  final dynamic icon;
  final String? tag;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    Color iconBg;
    Color iconColor;

    switch (tone) {
      case AafiatakFeedbackTone.primary:
      case AafiatakFeedbackTone.success:
      case AafiatakFeedbackTone.hold:
        iconBg = AafiatakColors.primaryContainer;
        iconColor = AafiatakColors.onPrimaryContainer;
      case AafiatakFeedbackTone.secondary:
      case AafiatakFeedbackTone.info:
      case AafiatakFeedbackTone.warning:
      case AafiatakFeedbackTone.neutral:
        iconBg = AafiatakColors.surfaceContainer;
        iconColor = AafiatakColors.textPrimary;
      case AafiatakFeedbackTone.error:
        iconBg = AafiatakColors.error;
        iconColor = AafiatakColors.onError;
    }

    return Container(
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      decoration: BoxDecoration(
        color: AafiatakColors.surface,
        borderRadius: AafiatakRadii.lg,
        border: Border.all(color: AafiatakColors.outline, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: AafiatakRadii.lg,
            ),
            alignment: Alignment.center,
            child: icon is IconData
                ? Icon(icon as IconData, size: 24, color: iconColor)
                : icon is Widget
                ? IconTheme(
                    data: IconThemeData(size: 24, color: iconColor),
                    child: icon as Widget,
                  )
                : Icon(_defaultIconForTone(tone), size: 24, color: iconColor),
          ),
          const SizedBox(width: AafiatakSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (tag != null && tag!.isNotEmpty) ...<Widget>[
                  AafiatakBadge(label: tag!, tone: tone),
                  const SizedBox(height: AafiatakSpacing.xs),
                ],
                Text(
                  title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    color: AafiatakColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (message != null && message!.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    message!,
                    style: AafiatakTypography.bodySmall.copyWith(
                      color: AafiatakColors.textSecondary,
                    ),
                  ),
                ],
                if (action != null) ...<Widget>[
                  const SizedBox(height: AafiatakSpacing.xs),
                  action!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _defaultIconForTone(AafiatakFeedbackTone tone) {
    return switch (tone) {
      AafiatakFeedbackTone.primary ||
      AafiatakFeedbackTone.success => Icons.check,
      AafiatakFeedbackTone.warning => Icons.warning_amber_rounded,
      AafiatakFeedbackTone.error => Icons.close,
      AafiatakFeedbackTone.hold => Icons.access_time,
      _ => Icons.info_outline,
    };
  }
}
