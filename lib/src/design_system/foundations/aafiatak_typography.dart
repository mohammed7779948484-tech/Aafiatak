import 'package:flutter/material.dart';

import 'aafiatak_colors.dart';

/// Approved Aafiatak typography roles from the High-Fidelity handoff.
///
/// The canonical Flutter font-family key is `IBMPlexSansArabic`. Font binaries
/// are registered separately in `pubspec.yaml`; the token API stays stable.
abstract final class AafiatakTypography {
  const AafiatakTypography._();

  static const String arabicFamily = 'IBMPlexSansArabic';
  static const String latinFamily = 'IBMPlexSans';
  static const List<String> fallbackFamilies = <String>[
    'IBM Plex Sans Arabic',
    'Noto Sans Arabic',
    'Noto Sans',
  ];

  static const TextStyle display = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle h1 = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 18,
    height: 30 / 18,
    fontWeight: FontWeight.w400,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 16,
    height: 27 / 16,
    fontWeight: FontWeight.w400,
    color: AafiatakColors.textPrimary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle label = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
    fontSize: 14,
    height: 23 / 14,
    fontWeight: FontWeight.w400,
    color: AafiatakColors.textSecondary,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: arabicFamily,
    fontFamilyFallback: fallbackFamilies,
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
