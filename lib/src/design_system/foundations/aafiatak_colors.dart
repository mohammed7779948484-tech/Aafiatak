import 'package:flutter/material.dart';

/// لوحة عافيتك الأساسية المبنية على اتجاه Burgundy Monochrome.
///
/// لكل قيمة فعلية تعريف واحد هنا، بينما تربط [AafiatakTheme] أدوار Material
/// بهذه القيم. استخدم `ColorScheme` في عناصر Material وهذه الرموز في التركيبات
/// الخاصة بعافيتك بدل كتابة ألوان محلية داخل الشاشات.
abstract final class AafiatakColors {
  const AafiatakColors._();

  // الأسطح المحايدة.
  static const canvas = Color(0xFFE5E5E5);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceLow = Color(0xFFF7F7F7);
  static const surfaceContainer = Color(0xFFEFEFEF);

  // المحتوى والمحور المحايد.
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6E6E6E);
  static const outlineStrong = Color(0xFFB5B5B5);

  // الاسم الدلالي الوحيد للقيمة المشتركة بين الخلفية والحدود المرجعية.
  static const outline = canvas;

  // انحراف مقصود عن حد النموذج #E5E5E5: يحقق 3.19:1 مقابل الأبيض
  // لتلبية WCAG 1.4.11 لحدود عناصر الإدخال.
  static const inputBoundary = Color(0xFF909090);

  // اللون البرغندي ودرجاته الفعلية.
  static const primary = Color(0xFF800020);
  static const primaryContainer = Color(0xFFF7E9EC);
  static const onPrimaryContainer = Color(0xFF5C0016);

  // درجات شفافة ذات مستهلكين حقيقيين في النظام المشترك.
  static const borderSubtle = Color(0x141A1A1A);
  static const primaryBorderFaint = Color(0x1A800020);
  static const primaryBorderSubtle = Color(0x1F800020);
  static const surfaceTranslucent = Color(0xEBFFFFFF);
  static const shadowSubtle = Color(0x0E1A1A1A);
}
