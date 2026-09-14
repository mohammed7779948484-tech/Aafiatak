import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

enum AafiatakFeedbackTone {
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  hold,
  neutral,
}

@immutable
class AafiatakToneColors {
  const AafiatakToneColors({
    required this.foreground,
    required this.background,
    required this.border,
  });

  final Color foreground;
  final Color background;
  final Color border;
}

extension AafiatakFeedbackToneX on AafiatakFeedbackTone {
  AafiatakToneColors get colors {
    switch (this) {
      case AafiatakFeedbackTone.primary:
      case AafiatakFeedbackTone.success:
      case AafiatakFeedbackTone.hold:
        return const AafiatakToneColors(
          foreground: AafiatakColors.onPrimaryContainer,
          background: AafiatakColors.primaryContainer,
          border: Color(0x1F800020),
        );
      case AafiatakFeedbackTone.secondary:
      case AafiatakFeedbackTone.info:
      case AafiatakFeedbackTone.warning:
        return const AafiatakToneColors(
          foreground: AafiatakColors.textPrimary,
          background: AafiatakColors.surfaceContainer,
          border: AafiatakColors.outline,
        );
      case AafiatakFeedbackTone.error:
        return const AafiatakToneColors(
          foreground: AafiatakColors.onError,
          background: AafiatakColors.error,
          border: AafiatakColors.error,
        );
      case AafiatakFeedbackTone.neutral:
        return const AafiatakToneColors(
          foreground: AafiatakColors.textSecondary,
          background: AafiatakColors.surfaceContainer,
          border: AafiatakColors.outline,
        );
    }
  }
}
