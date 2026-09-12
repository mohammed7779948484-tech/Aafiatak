import 'package:flutter/material.dart';

import '../foundations/foundations.dart';

/// Explicit Material 3 mapping. We intentionally avoid ColorScheme.fromSeed
/// so approved Aafiatak tokens remain the source of truth.
abstract final class AafiatakColorScheme {
  const AafiatakColorScheme._();

  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AafiatakColors.primary,
    onPrimary: AafiatakColors.onPrimary,
    primaryContainer: AafiatakColors.primaryContainer,
    onPrimaryContainer: AafiatakColors.onPrimaryContainer,
    primaryFixed: AafiatakPalette.damson200,
    primaryFixedDim: AafiatakPalette.damson300,
    onPrimaryFixed: AafiatakPalette.damson900,
    onPrimaryFixedVariant: AafiatakPalette.damson700,
    secondary: AafiatakColors.secondary,
    onSecondary: AafiatakColors.onSecondary,
    secondaryContainer: AafiatakColors.secondaryContainer,
    onSecondaryContainer: AafiatakColors.onSecondaryContainer,
    secondaryFixed: AafiatakPalette.seaGlass200,
    secondaryFixedDim: AafiatakPalette.seaGlass300,
    onSecondaryFixed: AafiatakPalette.seaGlass950,
    onSecondaryFixedVariant: AafiatakPalette.seaGlass800,
    tertiary: AafiatakColors.tertiary,
    onTertiary: AafiatakColors.onTertiary,
    tertiaryContainer: AafiatakColors.tertiaryContainer,
    onTertiaryContainer: AafiatakColors.onTertiaryContainer,
    tertiaryFixed: AafiatakPalette.copper200,
    tertiaryFixedDim: AafiatakPalette.copper300,
    onTertiaryFixed: AafiatakPalette.copper950,
    onTertiaryFixedVariant: AafiatakPalette.copper900,
    error: AafiatakColors.error,
    onError: AafiatakColors.onError,
    errorContainer: AafiatakColors.errorContainer,
    onErrorContainer: AafiatakColors.onErrorContainer,
    surface: AafiatakColors.surface,
    onSurface: AafiatakColors.textPrimary,
    surfaceDim: AafiatakColors.surfaceDim,
    surfaceBright: AafiatakColors.surfaceBright,
    surfaceContainerLowest: AafiatakColors.surfaceContainerLowest,
    surfaceContainerLow: AafiatakColors.surfaceContainerLow,
    surfaceContainer: AafiatakColors.surfaceContainer,
    surfaceContainerHigh: AafiatakColors.surfaceContainerHigh,
    surfaceContainerHighest: AafiatakColors.surfaceContainerHighest,
    onSurfaceVariant: AafiatakColors.textSecondary,
    outline: AafiatakColors.outlineStrong,
    outlineVariant: AafiatakColors.outline,
    shadow: AafiatakColors.shadow,
    scrim: AafiatakColors.scrim,
    inverseSurface: AafiatakColors.inverseSurface,
    onInverseSurface: AafiatakColors.onInverseSurface,
    inversePrimary: AafiatakPalette.damson300,
    surfaceTint: AafiatakColors.primary,
  );
}
