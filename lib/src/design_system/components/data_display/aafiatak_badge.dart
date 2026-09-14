import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../feedback/aafiatak_feedback_tone.dart';

typedef AafiatakBadgeTone = AafiatakFeedbackTone;

/// Pill badge widget matching the High-Fidelity .badge pattern.
///
/// Has a 28px min-height, full radius, 7px dot bullet, and monochrome tone styling.
class AafiatakBadge extends StatelessWidget {
  const AafiatakBadge({
    super.key,
    required this.label,
    this.tone = AafiatakFeedbackTone.neutral,
  });

  final String label;
  final AafiatakFeedbackTone tone;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (tone) {
      case AafiatakFeedbackTone.primary:
      case AafiatakFeedbackTone.success:
      case AafiatakFeedbackTone.hold:
        bg = AafiatakColors.primaryContainer;
        fg = AafiatakColors.onPrimaryContainer;
      case AafiatakFeedbackTone.secondary:
      case AafiatakFeedbackTone.info:
      case AafiatakFeedbackTone.warning:
        bg = AafiatakColors.surfaceContainer;
        fg = AafiatakColors.textPrimary;
      case AafiatakFeedbackTone.error:
        bg = AafiatakColors.error;
        fg = AafiatakColors.onError;
      case AafiatakFeedbackTone.neutral:
        bg = AafiatakColors.surfaceContainer;
        fg = AafiatakColors.textSecondary;
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 28),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: AafiatakRadii.full),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AafiatakTypography.caption.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
