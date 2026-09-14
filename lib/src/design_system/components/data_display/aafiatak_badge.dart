import 'package:flutter/material.dart';

import '../feedback/aafiatak_feedback_tone.dart';
import '../../foundations/foundations.dart';

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
    final colors = tone.colors;

    return Container(
      constraints: const BoxConstraints(minHeight: 28),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: AafiatakRadii.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: colors.foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AafiatakTypography.labelSmall.copyWith(
              color: colors.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
