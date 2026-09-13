import 'package:flutter/material.dart';

import '../foundations/foundations.dart';

/// Explicit Material 3 mapping for the approved Burgundy Monochrome v2.1
/// visual system. No seed-generated accent colors are allowed to leak into the
/// product theme.
abstract final class AafiatakColorScheme {
  const AafiatakColorScheme._();

  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AafiatakColors.primary,
    onPrimary: AafiatakColors.onPrimary,
    primaryContainer: AafiatakColors.primaryContainer,
    onPrimaryContainer: AafiatakColors.onPrimaryContainer,
    primaryFixed: AafiatakColors.primaryContainer,
    primaryFixedDim: AafiatakColors.primaryContainer,
    onPrimaryFixed: AafiatakColors.onPrimaryContainer,
    onPrimaryFixedVariant: AafiatakColors.onPrimaryContainer,
    secondary: AafiatakColors.secondary,
    onSecondary: AafiatakColors.onSecondary,
    secondaryContainer: AafiatakColors.secondaryContainer,
    onSecondaryContainer: AafiatakColors.onSecondaryContainer,
    secondaryFixed: AafiatakColors.secondaryContainer,
    secondaryFixedDim: AafiatakColors.secondaryContainer,
    onSecondaryFixed: AafiatakColors.onSecondaryContainer,
    onSecondaryFixedVariant: AafiatakColors.onSecondaryContainer,
    tertiary: AafiatakColors.tertiary,
    onTertiary: AafiatakColors.onTertiary,
    tertiaryContainer: AafiatakColors.tertiaryContainer,
    onTertiaryContainer: AafiatakColors.onTertiaryContainer,
    tertiaryFixed: AafiatakColors.tertiaryContainer,
    tertiaryFixedDim: AafiatakColors.surfaceContainerHigh,
    onTertiaryFixed: AafiatakColors.onTertiaryContainer,
    onTertiaryFixedVariant: AafiatakColors.onTertiaryContainer,
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
    inversePrimary: AafiatakColors.primaryContainer,
    surfaceTint: AafiatakColors.primary,
  );
}
