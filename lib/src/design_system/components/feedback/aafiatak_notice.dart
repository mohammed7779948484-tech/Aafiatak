import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

import 'aafiatak_feedback_tone.dart';

/// Contextual inline notification block matching the High-Fidelity `.notice` pattern.
class AafiatakNotice extends StatelessWidget {
  const AafiatakNotice({super.key, required this.message, required this.tone});

  final String message;
  final AafiatakFeedbackTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.space16,
        vertical: AafiatakSpacing.space12,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: AafiatakRadii.large,
        border: Border.all(color: colors.border),
      ),
      child: Text(
        message,
        style: AafiatakTypography.bodySmall.copyWith(color: colors.foreground),
      ),
    );
  }
}
