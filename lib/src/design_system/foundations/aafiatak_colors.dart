import 'package:flutter/material.dart';

import 'aafiatak_palette.dart';

/// Semantic aliases used to construct the approved Aafiatak light theme.
///
/// The visual direction is Burgundy Monochrome v2.1: brand burgundy plus
/// neutral charcoal/grey surfaces. Status meaning is carried by iconography and
/// copy, not by introducing green/yellow/red semantic families.
abstract final class AafiatakColors {
  const AafiatakColors._();

  static const canvas = AafiatakPalette.neutral200;
  static const surface = AafiatakPalette.white;
  static const surfaceMuted = AafiatakPalette.neutral100;
  static const surfaceDim = AafiatakPalette.neutral200;
  static const surfaceBright = AafiatakPalette.white;
  static const surfaceContainerLowest = AafiatakPalette.white;
  static const surfaceContainerLow = AafiatakPalette.neutral50;
  static const surfaceContainer = AafiatakPalette.neutral100;
  static const surfaceContainerHigh = AafiatakPalette.neutral200;
  static const surfaceContainerHighest = AafiatakPalette.neutral300;

  static const textPrimary = AafiatakPalette.charcoal;
  static const textSecondary = AafiatakPalette.neutral600;
  static const outline = AafiatakPalette.neutral200;
  static const outlineStrong = AafiatakPalette.neutral400;

  static const primary = AafiatakPalette.burgundy;
  static const onPrimary = AafiatakPalette.white;
  static const primaryContainer = AafiatakPalette.burgundyTint;
  static const onPrimaryContainer = AafiatakPalette.burgundyDark;

  /// Secondary stays within the approved burgundy family.
  static const secondary = AafiatakPalette.burgundyDark;
  static const onSecondary = AafiatakPalette.white;
  static const secondaryContainer = AafiatakPalette.burgundyTint;
  static const onSecondaryContainer = AafiatakPalette.burgundyDark;

  /// Tertiary is neutral charcoal; no additional accent hue is introduced.
  static const tertiary = AafiatakPalette.charcoal;
  static const onTertiary = AafiatakPalette.white;
  static const tertiaryContainer = AafiatakPalette.neutral100;
  static const onTertiaryContainer = AafiatakPalette.charcoal;

  static const success = AafiatakPalette.burgundy;
  static const onSuccess = AafiatakPalette.white;
  static const successContainer = AafiatakPalette.burgundyTint;
  static const onSuccessContainer = AafiatakPalette.burgundyDark;

  static const warning = AafiatakPalette.charcoal;
  static const onWarning = AafiatakPalette.white;
  static const warningContainer = AafiatakPalette.neutral100;
  static const onWarningContainer = AafiatakPalette.charcoal;

  static const error = AafiatakPalette.charcoalStrong;
  static const onError = AafiatakPalette.white;
  static const errorContainer = AafiatakPalette.neutral100;
  static const onErrorContainer = AafiatakPalette.charcoal;

  static const info = AafiatakPalette.charcoal;
  static const onInfo = AafiatakPalette.white;
  static const infoContainer = AafiatakPalette.neutral100;
  static const onInfoContainer = AafiatakPalette.charcoal;

  /// ReservationHold is positive attention in the approved visual system.
  static const holdAttention = AafiatakPalette.burgundy;
  static const onHoldAttention = AafiatakPalette.white;
  static const holdAttentionContainer = AafiatakPalette.burgundyTint;
  static const onHoldAttentionContainer = AafiatakPalette.burgundyDark;

  static const focus = AafiatakPalette.burgundy;
  static const shadow = AafiatakPalette.charcoal;
  static const scrim = Color(0xB31A1A1A);
  static const inverseSurface = AafiatakPalette.charcoal;
  static const onInverseSurface = AafiatakPalette.white;
}
