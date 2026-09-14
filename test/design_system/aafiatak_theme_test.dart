import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AafiatakTheme', () {
    test('maps the approved Burgundy Monochrome semantic anchors', () {
      final theme = AafiatakTheme.light;
      final scheme = theme.colorScheme;

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
      expect(scheme.primary, const Color(0xFF800020));
      expect(theme.scaffoldBackgroundColor, const Color(0xFFE5E5E5));
      expect(scheme.surface, const Color(0xFFFFFFFF));
      expect(scheme.onSurface, const Color(0xFF1A1A1A));
      expect(scheme.primaryContainer, const Color(0xFFF7E9EC));
      expect(scheme.onPrimaryContainer, const Color(0xFF5C0016));

      expect(AafiatakColors.brand, const Color(0xFF800020));
      expect(AafiatakColors.canvas, const Color(0xFFE5E5E5));
      expect(AafiatakColors.surface, const Color(0xFFFFFFFF));
      expect(AafiatakColors.textPrimary, const Color(0xFF1A1A1A));
      expect(AafiatakColors.textSecondary, const Color(0xFF6E6E6E));
      expect(AafiatakColors.outline, const Color(0xFFE5E5E5));
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
      expect(AafiatakRadii.fullValue, 999);
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
