import 'package:flutter/material.dart';

import 'aafiatak_colors.dart';

/// أدوار النصوص المشتركة وفق التسلسل الطباعي في المرجع البصري.
///
/// الأسماء تطابق لغة التصميم (`display` و`h1` إلى `h3`)، بينما يوفّر
/// [textTheme] الربط مع أسماء Material. جميع الأدوار تستخدم IBM Plex Sans
/// Arabic المضمّن في المشروع.
abstract final class AafiatakTypography {
  const AafiatakTypography._();

  static const String fontFamily = 'IBMPlexSansArabic';

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 30 / 18,
    fontWeight: FontWeight.w400,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 27 / 16,
    fontWeight: FontWeight.w400,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 23 / 14,
    fontWeight: FontWeight.w400,
    color: AafiatakColors.textSecondary,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 20 / 12,
    fontWeight: FontWeight.w500,
    color: AafiatakColors.textSecondary,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: display,
    displayMedium: h1,
    displaySmall: h2,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: h3,
    titleLarge: h3,
    titleMedium: labelLarge,
    titleSmall: label,
    bodyLarge: bodyLarge,
    bodyMedium: body,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: label,
    labelSmall: caption,
  );
}
