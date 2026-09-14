import 'package:flutter/material.dart';

import '../foundations/foundations.dart';

/// المصدر المركزي لتنسيق عناصر Material 3 في تطبيق عافيتك.
///
/// تعتمد الشاشات على [light] بدل تكرار الألوان والحواف محليًا. يربط
/// [colorScheme] أدوار Material بالقيم المرجعية دون تغيير معنى أي Token.
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
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(
        color: AafiatakColors.outline,
        thickness: 1,
        space: 1,
      ),
      // يضبط شريط التطبيق مرة واحدة لجميع الشاشات الجذرية والتفصيلية.
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
      // تعتمد AafiatakCard والبطاقات المباشرة على هذا السطح والشكل.
      cardTheme: const CardThemeData(
        color: AafiatakColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AafiatakRadii.large,
          side: BorderSide(color: AafiatakColors.outline, width: 1),
        ),
      ),
      // الأحجام والحواف مشتركة، بينما يحدد نوع الزر ألوانه الدلالية.
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 48)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: AafiatakSpacing.space16,
              vertical: AafiatakSpacing.space12,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AafiatakRadii.medium),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AafiatakColors.primary,
          backgroundColor: AafiatakColors.surface,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AafiatakSpacing.space16,
            vertical: AafiatakSpacing.space12,
          ),
          side: const BorderSide(color: AafiatakColors.outline, width: 1),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.medium,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AafiatakColors.primary,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AafiatakSpacing.space16,
            vertical: AafiatakSpacing.space8,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.medium,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      // الحدود وحالات التركيز والخطأ لكل TextFormField تأتي من هنا.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AafiatakColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AafiatakSpacing.space16,
          vertical: AafiatakSpacing.space16,
        ),
        border: const OutlineInputBorder(
          borderRadius: AafiatakRadii.medium,
          borderSide: BorderSide(color: AafiatakColors.inputBoundary, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.medium,
          borderSide: BorderSide(color: AafiatakColors.inputBoundary, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.medium,
          borderSide: BorderSide(color: AafiatakColors.focus, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.medium,
          borderSide: BorderSide(color: AafiatakColors.error, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AafiatakRadii.medium,
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
        prefixIconColor: AafiatakColors.primary,
        suffixIconColor: AafiatakColors.textSecondary,
      ),
      // يحاكي SearchBar حقل البحث المرتفع قليلًا في المرجع البصري.
      searchBarTheme: SearchBarThemeData(
        backgroundColor: const WidgetStatePropertyAll(AafiatakColors.surface),
        elevation: const WidgetStatePropertyAll(1),
        shadowColor: const WidgetStatePropertyAll(AafiatakColors.shadowSubtle),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        side: const WidgetStatePropertyAll(
          BorderSide(color: AafiatakColors.borderSubtle),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AafiatakRadii.large),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsetsDirectional.symmetric(horizontal: AafiatakSpacing.space16),
        ),
        textStyle: WidgetStatePropertyAll(textTheme.bodyMedium),
        hintStyle: WidgetStatePropertyAll(
          textTheme.bodyMedium?.copyWith(color: AafiatakColors.textSecondary),
        ),
        constraints: const BoxConstraints(minHeight: 58),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AafiatakColors.surface,
        selectedColor: AafiatakColors.primary,
        disabledColor: AafiatakColors.surfaceContainer,
        secondarySelectedColor: AafiatakColors.primaryContainer,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AafiatakColors.onPrimary;
            }
            return AafiatakColors.textPrimary;
          }),
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: AafiatakColors.onPrimaryContainer,
        ),
        side: const BorderSide(color: AafiatakColors.outline, width: 1),
        shape: const RoundedRectangleBorder(borderRadius: AafiatakRadii.full),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      // يترك NavigationBar مسؤولًا عن التفاعل مع تطبيق هوية عافيتك فقط.
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
      // يحافظ IconButton على هدف لمس 48dp وسطح قريب من النموذج المرجعي.
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AafiatakColors.primary,
          backgroundColor: AafiatakColors.surfaceTranslucent,
          minimumSize: const Size.square(48),
          side: const BorderSide(color: AafiatakColors.borderSubtle),
          shape: const RoundedRectangleBorder(
            borderRadius: AafiatakRadii.large,
          ),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: AafiatakColors.surface,
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
