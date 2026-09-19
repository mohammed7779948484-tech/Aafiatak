import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// المعاني الدلالية المشتركة بين مكونات التغذية الراجعة.
///
/// لا يعني اشتراك المكونات في هذا النوع أنها تعرض اللون بالطريقة نفسها؛
/// تختار الشارة والملاحظة وكتلة الحالة التكوين المناسب للسياق.
enum AafiatakFeedbackTone { primary, secondary, success, warning, info }

/// مجموعة ألوان بسيطة تستخدمها مكونات الحالة المشتركة.
@immutable
class AafiatakToneColors {
  const AafiatakToneColors._({
    required this.foreground,
    required this.background,
  });

  final Color foreground;
  final Color background;
}

/// يوفر التنسيق الافتراضي للشارات وأيقونات الحالة دون تكرار Switch بينها.
extension AafiatakFeedbackToneX on AafiatakFeedbackTone {
  AafiatakToneColors get colors {
    switch (this) {
      case AafiatakFeedbackTone.primary:
      case AafiatakFeedbackTone.success:
        return const AafiatakToneColors._(
          foreground: AafiatakColors.onPrimaryContainer,
          background: AafiatakColors.primaryContainer,
        );
      case AafiatakFeedbackTone.secondary:
      case AafiatakFeedbackTone.info:
      case AafiatakFeedbackTone.warning:
        return const AafiatakToneColors._(
          foreground: AafiatakColors.textPrimary,
          background: AafiatakColors.surfaceContainer,
        );
    }
  }
}
