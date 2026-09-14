import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../data_display/aafiatak_badge.dart';
import 'aafiatak_feedback_tone.dart';

/// Status block widget matching the High-Fidelity `.status-block` pattern.
///
/// Features a white surface card, a 48x48 rounded icon chip styled by tone,
/// a tag badge, a bold title, and secondary supporting copy.
class AafiatakStatusBlock extends StatelessWidget {
  const AafiatakStatusBlock({
    super.key,
    required this.title,
    required this.message,
    required this.tone,
    required this.icon,
    required this.tag,
  });

  final String title;
  final String message;
  final AafiatakFeedbackTone tone;
  final IconData icon;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors;

    return Container(
      padding: const EdgeInsets.all(AafiatakSpacing.space16),
      decoration: BoxDecoration(
        color: AafiatakColors.surface,
        borderRadius: AafiatakRadii.large,
        border: Border.all(color: AafiatakColors.outline, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: AafiatakRadii.large,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 24, color: colors.foreground),
          ),
          const SizedBox(width: AafiatakSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AafiatakBadge(label: tag, tone: tone),
                const SizedBox(height: AafiatakSpacing.space8),
                Text(
                  title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    color: AafiatakColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: AafiatakTypography.bodySmall.copyWith(
                    color: AafiatakColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
