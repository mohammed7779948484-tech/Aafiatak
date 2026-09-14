import 'package:flutter/material.dart';

import '../foundations/foundations.dart';

/// Simplified Material 3 theme matching the High-Fidelity Burgundy Monochrome design.
abstract final class AafiatakTheme {
  const AafiatakTheme._();

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AafiatakColors.primary,
    onPrimary: AafiatakColors.onPrimary,
    primaryContainer: AafiatakColors.primaryContainer,
    onPrimaryContainer: AafiatakColors.onPrimaryContainer,
    primaryFixed: AafiatakColors.primaryFixed,
    primaryFixedDim: AafiatakColors.primaryFixedDim,
    onPrimaryFixed: AafiatakColors.onPrimaryContainer,
    secondary: AafiatakColors.secondary,
    onSecondary: AafiatakColors.onSecondary,
    secondaryContainer: AafiatakColors.secondaryContainer,
    onSecondaryContainer: AafiatakColors.onSecondaryContainer,
    secondaryFixed: AafiatakColors.secondaryFixed,
    secondaryFixedDim: AafiatakColors.secondaryFixedDim,
    onSecondaryFixed: AafiatakColors.textPrimary,
    tertiary: AafiatakColors.tertiary,
    onTertiary: AafiatakColors.onTertiary,
    tertiaryContainer: AafiatakColors.tertiaryContainer,
    onTertiaryContainer: AafiatakColors.onTertiaryContainer,
    error: AafiatakColors.error,
    onError: AafiatakColors.onError,
    errorContainer: AafiatakColors.errorContainer,
    onErrorContainer: AafiatakColors.onErrorContainer,
    surface: AafiatakColors.surface,
    onSurface: AafiatakColors.textPrimary,
    surfaceDim: AafiatakColors.canvas,
    surfaceBright: AafiatakColors.surface,
    surfaceContainerLowest: AafiatakColors.surface,
    surfaceContainerLow: AafiatakColors.surfaceLow,
    surfaceContainer: AafiatakColors.surfaceContainer,
    surfaceContainerHigh: AafiatakColors.surfaceHigh,
    surfaceContainerHighest: AafiatakColors.surfaceHighest,
    onSurfaceVariant: AafiatakColors.textSecondary,
    outline: AafiatakColors.outline,
    outlineVariant: AafiatakColors.outlineStrong,
    scrim: AafiatakColors.scrim,
  );

  static ThemeData get light {
    const textTheme = AafiatakTypography.textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AafiatakColors.canvas,
      fontFamily: AafiatakTypography.arabicFamily,
      fontFamilyFallback: AafiatakTypography.fallbackFamilies,
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(
        color: AafiatakColors.outline,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AafiatakColors.canvas,
        foregroundColor: AafiatakColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AafiatakColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AafiatakRadii.card,
          side: BorderSide(color: AafiatakColors.outline, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AafiatakColors.primary,
          foregroundColor: AafiatakColors.onPrimary,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AafiatakSpacing.md,
            vertical: AafiatakSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.button,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AafiatakColors.primary,
          backgroundColor: AafiatakColors.surface,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AafiatakSpacing.md,
            vertical: AafiatakSpacing.sm,
          ),
          side: const BorderSide(color: AafiatakColors.outline, width: 1),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.button,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AafiatakColors.primary,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AafiatakSpacing.md,
            vertical: AafiatakSpacing.xs,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.button,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AafiatakColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AafiatakSpacing.md,
          vertical: AafiatakSpacing.md,
        ),
        border: const OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(color: AafiatakColors.outline, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(color: AafiatakColors.outline, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(color: AafiatakColors.focus, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(color: AafiatakColors.error, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(color: AafiatakColors.error, width: 2),
        ),
        labelStyle: textTheme.bodySmall?.copyWith(
          color: AafiatakColors.textSecondary,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AafiatakColors.textSecondary,
        ),
        helperStyle: textTheme.bodySmall?.copyWith(
          color: AafiatakColors.textSecondary,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(
          color: AafiatakColors.textPrimary,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AafiatakColors.surface,
        selectedColor: AafiatakColors.primary,
        disabledColor: AafiatakColors.surfaceContainer,
        secondarySelectedColor: AafiatakColors.primaryContainer,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: AafiatakColors.textPrimary,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: AafiatakColors.onPrimary,
        ),
        side: const BorderSide(color: AafiatakColors.outline, width: 1),
        shape: const RoundedRectangleBorder(borderRadius: AafiatakRadii.full),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AafiatakColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AafiatakColors.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(
              color: AafiatakColors.primary,
              fontWeight: FontWeight.w700,
            );
          }
          return textTheme.labelSmall?.copyWith(
            color: AafiatakColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AafiatakColors.primary);
          }
          return const IconThemeData(color: AafiatakColors.textSecondary);
        }),
      ),
    );
  }
}
