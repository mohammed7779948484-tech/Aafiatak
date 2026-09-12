import 'package:flutter/material.dart';

import '../foundations/aafiatak_colors.dart';

@immutable
class AafiatakSemanticColors extends ThemeExtension<AafiatakSemanticColors> {
  const AafiatakSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.holdAttention,
    required this.onHoldAttention,
    required this.holdAttentionContainer,
    required this.onHoldAttentionContainer,
  });

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color holdAttention;
  final Color onHoldAttention;
  final Color holdAttentionContainer;
  final Color onHoldAttentionContainer;

  static const light = AafiatakSemanticColors(
    success: AafiatakColors.success,
    onSuccess: AafiatakColors.onSuccess,
    successContainer: AafiatakColors.successContainer,
    onSuccessContainer: AafiatakColors.onSuccessContainer,
    warning: AafiatakColors.warning,
    onWarning: AafiatakColors.onWarning,
    warningContainer: AafiatakColors.warningContainer,
    onWarningContainer: AafiatakColors.onWarningContainer,
    info: AafiatakColors.info,
    onInfo: AafiatakColors.onInfo,
    infoContainer: AafiatakColors.infoContainer,
    onInfoContainer: AafiatakColors.onInfoContainer,
    holdAttention: AafiatakColors.holdAttention,
    onHoldAttention: AafiatakColors.onHoldAttention,
    holdAttentionContainer: AafiatakColors.holdAttentionContainer,
    onHoldAttentionContainer: AafiatakColors.onHoldAttentionContainer,
  );

  @override
  AafiatakSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? holdAttention,
    Color? onHoldAttention,
    Color? holdAttentionContainer,
    Color? onHoldAttentionContainer,
  }) {
    return AafiatakSemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      holdAttention: holdAttention ?? this.holdAttention,
      onHoldAttention: onHoldAttention ?? this.onHoldAttention,
      holdAttentionContainer:
          holdAttentionContainer ?? this.holdAttentionContainer,
      onHoldAttentionContainer:
          onHoldAttentionContainer ?? this.onHoldAttentionContainer,
    );
  }

  @override
  AafiatakSemanticColors lerp(
    covariant AafiatakSemanticColors? other,
    double t,
  ) {
    if (other == null) return this;
    return AafiatakSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      onSuccessContainer: Color.lerp(
        onSuccessContainer,
        other.onSuccessContainer,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      onWarningContainer: Color.lerp(
        onWarningContainer,
        other.onWarningContainer,
        t,
      )!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t)!,
      holdAttention: Color.lerp(holdAttention, other.holdAttention, t)!,
      onHoldAttention: Color.lerp(onHoldAttention, other.onHoldAttention, t)!,
      holdAttentionContainer: Color.lerp(
        holdAttentionContainer,
        other.holdAttentionContainer,
        t,
      )!,
      onHoldAttentionContainer: Color.lerp(
        onHoldAttentionContainer,
        other.onHoldAttentionContainer,
        t,
      )!,
    );
  }
}

extension AafiatakThemeContext on BuildContext {
  AafiatakSemanticColors get semanticColors =>
      Theme.of(this).extension<AafiatakSemanticColors>() ??
      AafiatakSemanticColors.light;
}
