import 'package:flutter/material.dart';

/// Canonical High-Fidelity Burgundy Monochrome color foundations.
///
/// Source anchors:
/// - Brand: #800020
/// - Base surface: #FFFFFF
/// - Sub-neutral / Canvas: #E5E5E5
abstract final class AafiatakColors {
  const AafiatakColors._();

  // Three source anchors
  static const canvas = Color(0xFFE5E5E5);
  static const surface = Color(0xFFFFFFFF);

  // Surfaces & Backgrounds
  static const surfaceLow = Color(0xFFF7F7F7);
  static const surfaceContainer = Color(0xFFEFEFEF);
  static const surfaceHigh = Color(0xFFEDEDED);
  static const surfaceHighest = Color(0xFFD9D9D9);

  // Typography & Content
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6E6E6E);

  // Borders & Dividers
  static const outline = Color(0xFFE5E5E5);
  static const outlineStrong = Color(0xFFB5B5B5);

  // Primary (Brand Burgundy)
  static const primary = Color(0xFF800020);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFF7E9EC);
  static const onPrimaryContainer = Color(0xFF5C0016);

  // Secondary
  static const secondary = Color(0xFF800020);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFF7E9EC);
  static const onSecondaryContainer = Color(0xFF5C0016);

  // Tertiary
  static const tertiary = Color(0xFF5C0016);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFF7E9EC);
  static const onTertiaryContainer = Color(0xFF5C0016);

  // Error / Critical: Solid charcoal chip or light container
  static const error = Color(0xFF1F1F1F);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFEFEFEF);
  static const onErrorContainer = Color(0xFF1A1A1A);

  // Fixed & Overlays
  static const primaryFixed = Color(0xFFF7E9EC);
  static const primaryFixedDim = Color(0xFFEBD0D6);
  static const secondaryFixed = Color(0xFFEFEFEF);
  static const secondaryFixedDim = Color(0xFFD9D9D9);
  static const focus = Color(0xFF800020);
  static const scrim = Color(0x9E141213); // rgba(20,18,19,.62)
}
