import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum AafiatakFeedbackTone { neutral, success, warning, error, info, hold }

@immutable
class AafiatakFeedbackColors {
  const AafiatakFeedbackColors({
    required this.foreground,
    required this.background,
    required this.border,
    required this.solid,
    required this.onSolid,
  });

  final Color foreground;
  final Color background;
  final Color border;
  final Color solid;
  final Color onSolid;
}

extension AafiatakFeedbackToneX on AafiatakFeedbackTone {
  AafiatakFeedbackColors colors(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final semantic = context.semanticColors;

    return switch (this) {
      AafiatakFeedbackTone.neutral => AafiatakFeedbackColors(
        foreground: scheme.onSurface,
        background: scheme.surfaceContainerLow,
        border: scheme.outlineVariant,
        solid: scheme.onSurface,
        onSolid: scheme.surface,
      ),
      AafiatakFeedbackTone.success => AafiatakFeedbackColors(
        foreground: semantic.onSuccessContainer,
        background: semantic.successContainer,
        border: semantic.success,
        solid: semantic.success,
        onSolid: semantic.onSuccess,
      ),
      AafiatakFeedbackTone.warning => AafiatakFeedbackColors(
        foreground: semantic.onWarningContainer,
        background: semantic.warningContainer,
        border: semantic.warning,
        solid: semantic.warning,
        onSolid: semantic.onWarning,
      ),
      AafiatakFeedbackTone.error => AafiatakFeedbackColors(
        foreground: scheme.onErrorContainer,
        background: scheme.errorContainer,
        border: scheme.error,
        solid: scheme.error,
        onSolid: scheme.onError,
      ),
      AafiatakFeedbackTone.info => AafiatakFeedbackColors(
        foreground: semantic.onInfoContainer,
        background: semantic.infoContainer,
        border: semantic.info,
        solid: semantic.info,
        onSolid: semantic.onInfo,
      ),
      AafiatakFeedbackTone.hold => AafiatakFeedbackColors(
        foreground: semantic.onHoldAttentionContainer,
        background: semantic.holdAttentionContainer,
        border: semantic.holdAttention,
        solid: semantic.holdAttention,
        onSolid: semantic.onHoldAttention,
      ),
    };
  }
}
