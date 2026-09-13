import 'package:flutter/material.dart';

import '../foundations/foundations.dart';
import 'aafiatak_color_scheme.dart';
import 'aafiatak_semantic_colors.dart';

abstract final class AafiatakTheme {
  const AafiatakTheme._();

  static ThemeData get light {
    const scheme = AafiatakColorScheme.light;
    const textTheme = AafiatakTypography.textTheme;

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AafiatakColors.canvas,
      fontFamily: AafiatakTypography.arabicFamily,
      fontFamilyFallback: AafiatakTypography.fallbackFamilies,
      textTheme: textTheme,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: const <ThemeExtension<dynamic>>[AafiatakSemanticColors.light],
    );

    return base.copyWith(
      appBarTheme: AppBarThemeData(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(size: AafiatakSizes.iconDefault),
        actionsIconTheme: const IconThemeData(size: AafiatakSizes.iconDefault),
        titleTextStyle: textTheme.titleMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: IconThemeData(
        color: scheme.onSurface,
        size: AafiatakSizes.iconDefault,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(
            AafiatakSizes.buttonMinWidth,
            AafiatakSizes.buttonHeight,
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AafiatakSpacing.xl,
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
          foregroundColor: scheme.primary,
          minimumSize: const Size(
            AafiatakSizes.buttonMinWidth,
            AafiatakSizes.buttonHeight,
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AafiatakSpacing.xl,
            vertical: AafiatakSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.button,
          ),
          side: BorderSide(
            color: scheme.outline,
            width: AafiatakBorders.strong,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(
            AafiatakSizes.buttonMinWidth,
            AafiatakSizes.minimumTouchTarget,
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AafiatakSpacing.md,
            vertical: AafiatakSpacing.xs,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AafiatakRadii.sm),
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(
            Size.square(AafiatakSizes.minimumTouchTarget),
          ),
          iconSize: const WidgetStatePropertyAll<double>(
            AafiatakSizes.iconDefault,
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return scheme.onSurface.withValues(alpha: 0.38);
            }
            return scheme.onSurface;
          }),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: AafiatakRadii.md),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        // The scaffold handoff used a translucent darker fill. We keep the
        // approved low-neutral surface here so #6E6E6E labels/hints remain
        // above the 4.5:1 contrast target.
        fillColor: scheme.surfaceContainerLow,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        helperMaxLines: 3,
        errorMaxLines: 3,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(
          AafiatakSpacing.md,
          AafiatakSizes.inputVerticalPadding,
          AafiatakSpacing.md,
          AafiatakSizes.inputVerticalPadding,
        ),
        labelStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        floatingLabelStyle: textTheme.bodySmall?.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        helperStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: scheme.error),
        border: OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(
            color: scheme.outline,
            width: AafiatakBorders.subtle,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(
            color: scheme.outline,
            width: AafiatakBorders.subtle,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(
            color: scheme.primary,
            width: AafiatakBorders.focus,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(
            color: scheme.error,
            width: AafiatakBorders.subtle,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(
            color: scheme.error,
            width: AafiatakBorders.focus,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AafiatakRadii.input,
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.65),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: AafiatakElevation.level0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: AafiatakRadii.card,
          side: BorderSide(
            color: scheme.outlineVariant,
            width: AafiatakBorders.subtle,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: AafiatakBorders.subtle,
        space: AafiatakSpacing.md,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: AafiatakSizes.navigationBarHeight,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.secondaryContainer,
        elevation: 8,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: AafiatakSizes.iconDefault,
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
          );
        }),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AafiatakSpacing.md,
          vertical: AafiatakSpacing.xxs,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AafiatakRadii.md,
        ),
        visualDensity: VisualDensity.comfortable,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        selectedColor: scheme.primaryContainer,
        secondarySelectedColor: scheme.primaryContainer,
        disabledColor: scheme.onSurface.withValues(alpha: 0.08),
        side: BorderSide(color: scheme.outlineVariant),
        shape: const RoundedRectangleBorder(borderRadius: AafiatakRadii.full),
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AafiatakSpacing.sm,
          vertical: AafiatakSpacing.xs,
        ),
        showCheckmark: true,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(
            Size(0, AafiatakSizes.minimumTouchTarget),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsetsDirectional.symmetric(horizontal: AafiatakSpacing.md),
          ),
          textStyle: WidgetStatePropertyAll<TextStyle?>(textTheme.labelMedium),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: AafiatakRadii.md),
          ),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(color: scheme.outline),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.secondaryContainer;
            }
            return scheme.surfaceContainerLow;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.onSecondaryContainer;
            }
            return scheme.onSurfaceVariant;
          }),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        actionTextColor: scheme.inversePrimary,
        elevation: 4,
        shape: const RoundedRectangleBorder(borderRadius: AafiatakRadii.md),
        insetPadding: const EdgeInsets.fromLTRB(
          AafiatakSpacing.md,
          0,
          AafiatakSpacing.md,
          AafiatakSpacing.md,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AafiatakRadii.dialog),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: scheme.surface,
        modalBarrierColor: scheme.scrim,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: AafiatakRadii.bottomSheet,
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        elevation: const WidgetStatePropertyAll<double>(0),
        backgroundColor: WidgetStatePropertyAll<Color>(
          scheme.surfaceContainerLow,
        ),
        surfaceTintColor: const WidgetStatePropertyAll<Color>(
          Colors.transparent,
        ),
        side: WidgetStatePropertyAll<BorderSide>(
          BorderSide(color: scheme.outlineVariant),
        ),
        shape: const WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: AafiatakRadii.search),
        ),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsetsDirectional.symmetric(horizontal: AafiatakSpacing.md),
        ),
        textStyle: WidgetStatePropertyAll<TextStyle?>(textTheme.bodyMedium),
        hintStyle: WidgetStatePropertyAll<TextStyle?>(
          textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.primaryContainer,
        circularTrackColor: scheme.primaryContainer,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.primary,
        selectionColor: scheme.primaryContainer,
        selectionHandleColor: scheme.primary,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: AafiatakRadii.control,
        ),
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return scheme.onSurfaceVariant;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return scheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primaryContainer;
          }
          return scheme.surfaceContainerHighest;
        }),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface.withValues(alpha: 0.9),
          borderRadius: AafiatakRadii.sm,
        ),
        textStyle: textTheme.labelSmall?.copyWith(
          color: scheme.onInverseSurface,
        ),
      ),
    );
  }
}
