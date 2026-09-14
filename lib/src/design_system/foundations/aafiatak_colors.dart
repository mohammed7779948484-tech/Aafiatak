import 'package:flutter/material.dart';

/// ألوان عافيتك الأساسية المبنية على اتجاه Burgundy Monochrome.
///
/// استخدم هذه الأدوار أو `ColorScheme` بدل كتابة ألوان عشوائية داخل الشاشات.
/// تحافظ الأدوار الدلالية على اتساق الواجهة، ولا تضيف ألوان حالة خضراء أو
/// برتقالية أو زرقاء خارج المرجع البصري.
abstract final class AafiatakColors {
  const AafiatakColors._();

  // أسطح الواجهة المحايدة مشتقة من الأبيض والرمادي المرجعيين.
  static const canvas = Color(0xFFE5E5E5);
  static const surface = Color(0xFFFFFFFF);

  static const surfaceLow = Color(0xFFF7F7F7);
  static const surfaceContainer = Color(0xFFEFEFEF);
  static const surfaceHigh = Color(0xFFEDEDED);
  static const surfaceHighest = Color(0xFFD9D9D9);

  // ألوان النصوص والمحتوى.
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6E6E6E);

  // الحدود والفواصل.
  static const outline = Color(0xFFE5E5E5);
  static const outlineStrong = Color(0xFFB5B5B5);
  // يحقق نسبة تباين 3.19:1 مقابل سطح الإدخال الأبيض (WCAG 1.4.11).
  static const inputBoundary = Color(0xFF909090);

  // درجات شفافة مشتركة للحدود والأسطح والظل الخفيف.
  static const borderSubtle = Color(0x141A1A1A);
  static const borderEmphasis = Color(0x291A1A1A);
  static const surfaceTranslucent = Color(0xEBFFFFFF);
  static const shadowSubtle = Color(0x0E1A1A1A);

  // اللون الأساسي البرغندي وحاويته الفاتحة.
  static const primary = Color(0xFF800020);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFF7E9EC);
  static const onPrimaryContainer = Color(0xFF5C0016);

  // الأدوار الثانوية تحافظ على القيم الأصلية في ملف tokens.css.
  static const secondary = Color(0xFF800020);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFEFEFEF);
  static const onSecondaryContainer = Color(0xFF1A1A1A);

  // الدور الثالث يستخدم درجة برغندية أعمق عند الحاجة.
  static const tertiary = Color(0xFF5C0016);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFF7E9EC);
  static const onTertiaryContainer = Color(0xFF5C0016);

  // الحالات الحرجة أحادية اللون: فحمي قوي أو حاوية رمادية فاتحة.
  static const error = Color(0xFF1F1F1F);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFEFEFEF);
  static const onErrorContainer = Color(0xFF1A1A1A);

  // أدوار Material الثابتة والتركيز والطبقة المعتمة.
  static const primaryFixed = Color(0xFFF7E9EC);
  static const primaryFixedDim = Color(0xFFEBD0D6);
  static const secondaryFixed = Color(0xFFEFEFEF);
  static const secondaryFixedDim = Color(0xFFD9D9D9);
  static const focus = Color(0xFF800020);
  static const scrim = Color(0x9E141213);
}
