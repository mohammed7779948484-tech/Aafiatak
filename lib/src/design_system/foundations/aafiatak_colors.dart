import 'package:flutter/material.dart';

import 'aafiatak_palette.dart';

/// Semantic aliases used to construct the Aafiatak Material theme.
abstract final class AafiatakColors {
  const AafiatakColors._();

  static const canvas = AafiatakPalette.neutral100;
  static const surface = AafiatakPalette.neutral50;
  static const surfaceMuted = Color(0xFFF1ECE6);
  static const surfaceDim = Color(0xFFE6DED5);
  static const surfaceBright = surface;
  static const surfaceContainerLowest = Colors.white;
  static const surfaceContainerLow = Color(0xFFFBF8F4);
  static const surfaceContainer = Color(0xFFF5F0EA);
  static const surfaceContainerHigh = AafiatakPalette.neutral200;
  static const surfaceContainerHighest = Color(0xFFE7E0D8);

  static const textPrimary = AafiatakPalette.neutral900;
  static const textSecondary = Color(0xFF6B666E);
  static const outline = Color(0xFFD8D0C8);
  static const outlineStrong = AafiatakPalette.neutral500;

  static const primary = AafiatakPalette.damson700;
  static const onPrimary = Colors.white;
  static const primaryContainer = AafiatakPalette.damson100;
  static const onPrimaryContainer = AafiatakPalette.damson900;

  /// Higher-contrast interactive Sea Glass semantic role.
  static const secondary = Color(0xFF3F786E);
  static const onSecondary = Colors.white;
  static const secondaryContainer = AafiatakPalette.seaGlass100;
  static const onSecondaryContainer = AafiatakPalette.seaGlass900;

  static const tertiary = AafiatakPalette.copper600;
  static const onTertiary = Colors.white;
  static const tertiaryContainer = AafiatakPalette.copper100;
  static const onTertiaryContainer = AafiatakPalette.copper900;

  static const success = Color(0xFF2F725F);
  static const onSuccess = Colors.white;
  static const successContainer = Color(0xFFE7F4EF);
  static const onSuccessContainer = Color(0xFF1F5647);

  static const warning = Color(0xFF9B651F);
  static const onWarning = Colors.white;
  static const warningContainer = Color(0xFFFAEEDB);
  static const onWarningContainer = Color(0xFF6D4518);

  static const error = Color(0xFFA94452);
  static const onError = Colors.white;
  static const errorContainer = Color(0xFFF9E9EC);
  static const onErrorContainer = Color(0xFF7A2936);

  static const info = Color(0xFF496B98);
  static const onInfo = Colors.white;
  static const infoContainer = Color(0xFFEAF0F8);
  static const onInfoContainer = Color(0xFF2F527B);

  /// ReservationHold attention is deliberately not warning/error.
  static const holdAttention = AafiatakPalette.copper600;
  static const onHoldAttention = Colors.white;
  static const holdAttentionContainer = AafiatakPalette.copper100;
  static const onHoldAttentionContainer = AafiatakPalette.copper900;

  static const focus = AafiatakPalette.damson500;
  static const shadow = AafiatakPalette.neutral950;
  static const scrim = Color(0xB3171519);
  static const inverseSurface = AafiatakPalette.neutral900;
  static const onInverseSurface = AafiatakPalette.neutral100;
}
