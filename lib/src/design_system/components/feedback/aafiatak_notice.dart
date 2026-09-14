import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

import 'aafiatak_feedback_tone.dart';

typedef AafiatakNoticeTone = AafiatakFeedbackTone;

/// Contextual inline notification block matching the High-Fidelity `.notice` pattern.
class AafiatakNotice extends StatelessWidget {
  const AafiatakNotice({
    super.key,
    String? text,
    String? message,
    this.tone = AafiatakFeedbackTone.info,
  }) : text = message ?? text ?? '';

  final String text;
  final AafiatakFeedbackTone tone;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (tone) {
      case AafiatakFeedbackTone.primary:
      case AafiatakFeedbackTone.success:
      case AafiatakFeedbackTone.hold:
        backgroundColor = AafiatakColors.primaryContainer;
        textColor = AafiatakColors.onPrimaryContainer;
      case AafiatakFeedbackTone.secondary:
      case AafiatakFeedbackTone.info:
      case AafiatakFeedbackTone.warning:
      case AafiatakFeedbackTone.neutral:
        backgroundColor = AafiatakColors.surfaceContainer;
        textColor = AafiatakColors.textPrimary;
      case AafiatakFeedbackTone.error:
        backgroundColor = AafiatakColors.surfaceContainer;
        textColor = AafiatakColors.textPrimary;
        borderSide = const BorderSide(
          color: Color(0x291A1A1A),
          width: 1,
        ); // rgba(26,26,26,.16)
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.md,
        vertical: AafiatakSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AafiatakRadii.lg,
        border: borderSide != BorderSide.none
            ? Border.fromBorderSide(borderSide)
            : null,
      ),
      child: Text(
        text,
        style: AafiatakTypography.bodySmall.copyWith(color: textColor),
      ),
    );
  }
}
