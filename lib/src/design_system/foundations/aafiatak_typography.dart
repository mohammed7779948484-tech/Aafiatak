import 'package:flutter/material.dart';

import 'aafiatak_colors.dart';

/// أدوار النصوص المشتركة وفق التسلسل الطباعي في المرجع البصري.
///
/// استخدم `Theme.of(context).textTheme` أو هذه الأدوار بدل تعريف حجم ووزن في
/// كل شاشة. لا يحتوي المشروع على خط مضمّن، لذا يستخدم Flutter خط النظام الداعم
/// للعربية.
abstract final class AafiatakTypography {
  const AafiatakTypography._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    height: 30 / 18,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    height: 27 / 16,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    height: 23 / 14,
    color: AafiatakColors.textSecondary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    height: 20 / 12,
    fontWeight: FontWeight.w500,
    color: AafiatakColors.textSecondary,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: headlineLarge,
    displaySmall: headlineMedium,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: titleLarge,
    titleLarge: titleLarge,
    titleMedium: labelLarge,
    titleSmall: labelMedium,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
