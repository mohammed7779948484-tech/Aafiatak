import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AafiatakTheme', () {
    test('maps the approved Burgundy Monochrome v2.1 semantic anchors', () {
      final theme = AafiatakTheme.light;
      final scheme = theme.colorScheme;
      final semantic = theme.extension<AafiatakSemanticColors>();

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(scheme.primary, const Color(0xFF800020));
      expect(scheme.secondary, const Color(0xFF5C0016));
      expect(scheme.tertiary, const Color(0xFF1A1A1A));
      expect(theme.scaffoldBackgroundColor, const Color(0xFFE5E5E5));
      expect(scheme.surface, const Color(0xFFFFFFFF));
      expect(scheme.onSurface, const Color(0xFF1A1A1A));
      expect(scheme.onSurfaceVariant, const Color(0xFF6E6E6E));
      expect(scheme.outline, const Color(0xFFB5B5B5));
      expect(scheme.outlineVariant, const Color(0xFFE5E5E5));
      expect(scheme.error, const Color(0xFF1F1F1F));

      expect(semantic, isNotNull);
      expect(semantic!.success, const Color(0xFF800020));
      expect(semantic.warning, const Color(0xFF1A1A1A));
      expect(semantic.info, const Color(0xFF1A1A1A));
      expect(semantic.holdAttention, const Color(0xFF800020));
      expect(semantic.holdAttentionContainer, const Color(0xFFF7E9EC));
      expect(semantic.onHoldAttentionContainer, const Color(0xFF5C0016));
      expect(scheme.onPrimaryFixedVariant, const Color(0xFF5C0016));
      expect(scheme.onSecondaryFixedVariant, const Color(0xFF5C0016));
      expect(scheme.onTertiaryFixedVariant, const Color(0xFF1A1A1A));
    });

    test('keeps approved foundation scales stable', () {
      expect(AafiatakSpacing.scale, <double>[
        0,
        2,
        4,
        8,
        12,
        16,
        20,
        24,
        32,
        48,
        64,
      ]);
      expect(AafiatakSpacing.x3l, 40);
      expect(AafiatakRadii.xsValue, 4);
      expect(AafiatakRadii.controlValue, 6);
      expect(AafiatakRadii.smValue, 8);
      expect(AafiatakRadii.mdValue, 12);
      expect(AafiatakRadii.lgValue, 16);
      expect(AafiatakRadii.xlValue, 24);
      expect(AafiatakRadii.searchValue, 28);
      expect(AafiatakBorders.strong, 1.5);
      expect(AafiatakSizes.minimumTouchTarget, 48);
      expect(AafiatakSizes.buttonMinWidth, 88);
      expect(AafiatakMotion.instant, const Duration(milliseconds: 80));
      expect(AafiatakMotion.fast, const Duration(milliseconds: 140));
      expect(AafiatakMotion.standard, const Duration(milliseconds: 220));
      expect(AafiatakMotion.deliberate, const Duration(milliseconds: 320));
      expect(AafiatakMotion.shimmer, const Duration(milliseconds: 1350));
    });

    test('maps approved typography roles', () {
      expect(AafiatakTypography.display.fontSize, 32);
      expect(AafiatakTypography.h1.fontSize, 28);
      expect(AafiatakTypography.h2.fontSize, 24);
      expect(AafiatakTypography.h3.fontSize, 20);
      expect(AafiatakTypography.bodyLarge.fontSize, 18);
      expect(AafiatakTypography.body.fontSize, 16);
      expect(AafiatakTypography.labelLarge.fontSize, 16);
      expect(AafiatakTypography.label.fontSize, 14);
      expect(AafiatakTypography.bodySmall.fontSize, 14);
      expect(AafiatakTypography.caption.fontSize, 12);
      expect(AafiatakTypography.arabicFamily, 'IBMPlexSansArabic');
      expect(AafiatakTypography.textTheme.headlineMedium?.fontSize, 24);
      expect(AafiatakTypography.textTheme.headlineSmall?.fontSize, 20);
    });
  });
}
