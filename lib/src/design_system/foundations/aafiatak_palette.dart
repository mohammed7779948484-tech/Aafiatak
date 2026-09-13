import 'package:flutter/material.dart';

/// Raw Burgundy Monochrome v2.1 palette values.
///
/// Product code should prefer semantic roles from [ColorScheme] or
/// [AafiatakSemanticColors] instead of referencing these raw tones directly.
abstract final class AafiatakPalette {
  const AafiatakPalette._();

  static const burgundy = Color(0xFF800020);
  static const burgundyDark = Color(0xFF5C0016);
  static const burgundyTint = Color(0xFFF7E9EC);

  static const charcoal = Color(0xFF1A1A1A);
  static const charcoalStrong = Color(0xFF1F1F1F);

  static const neutral600 = Color(0xFF6E6E6E);
  static const neutral400 = Color(0xFFB5B5B5);
  static const neutral300 = Color(0xFFD9D9D9);
  static const neutral200 = Color(0xFFE5E5E5);
  static const neutral100 = Color(0xFFEFEFEF);
  static const neutral50 = Color(0xFFF7F7F7);
  static const white = Color(0xFFFFFFFF);
}
