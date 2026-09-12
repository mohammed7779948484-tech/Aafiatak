import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AafiatakTheme', () {
    test('maps the approved Mineral Bloom semantic anchors', () {
      final theme = AafiatakTheme.light;
      final scheme = theme.colorScheme;
      final semantic = theme.extension<AafiatakSemanticColors>();

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(scheme.primary, const Color(0xFF4A315D));
      expect(scheme.secondary, const Color(0xFF3F786E));
      expect(theme.scaffoldBackgroundColor, const Color(0xFFF7F3EE));
      expect(scheme.surface, const Color(0xFFFFFDF9));
      expect(scheme.onSurface, const Color(0xFF25232B));
      expect(scheme.error, const Color(0xFFA94452));

      expect(semantic, isNotNull);
      expect(semantic!.success, const Color(0xFF2F725F));
      expect(semantic.warning, const Color(0xFF9B651F));
      expect(semantic.info, const Color(0xFF496B98));
      expect(semantic.holdAttention, const Color(0xFFA85A41));
      expect(semantic.holdAttentionContainer, const Color(0xFFF6E6DC));
      expect(semantic.onHoldAttentionContainer, const Color(0xFF5D332B));
      expect(scheme.onPrimaryFixedVariant, const Color(0xFF4A315D));
      expect(scheme.onSecondaryFixedVariant, const Color(0xFF33564F));
      expect(scheme.onTertiaryFixedVariant, const Color(0xFF5D332B));
    });

    test('keeps approved foundation scales stable', () {
      expect(AafiatakSpacing.scale, <double>[
        0,
        4,
        8,
        12,
        16,
        20,
        24,
        32,
        40,
        48,
        64,
      ]);
      expect(AafiatakRadii.smValue, 8);
      expect(AafiatakRadii.mdValue, 12);
      expect(AafiatakRadii.lgValue, 16);
      expect(AafiatakRadii.xlValue, 24);
      expect(AafiatakSizes.minimumTouchTarget, 48);
      expect(AafiatakMotion.instant, const Duration(milliseconds: 80));
      expect(AafiatakMotion.fast, const Duration(milliseconds: 140));
      expect(AafiatakMotion.standard, const Duration(milliseconds: 220));
      expect(AafiatakMotion.deliberate, const Duration(milliseconds: 320));
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
      expect(AafiatakTypography.arabicFamily, 'IBM Plex Sans Arabic');
      expect(AafiatakTypography.textTheme.headlineMedium?.fontSize, 24);
      expect(AafiatakTypography.textTheme.headlineSmall?.fontSize, 20);
    });
  });
}
