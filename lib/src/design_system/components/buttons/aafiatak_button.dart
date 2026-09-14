import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

enum AafiatakButtonVariant { primary, tonal, secondary, destructive, text }

/// Thin brand wrapper over Material 3 buttons.
class AafiatakButton extends StatelessWidget {
  const AafiatakButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AafiatakButtonVariant.primary,
    this.icon,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AafiatakButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final child = switch (variant) {
      AafiatakButtonVariant.primary => _filled(),
      AafiatakButtonVariant.tonal => _tonal(),
      AafiatakButtonVariant.secondary => _outlined(),
      AafiatakButtonVariant.destructive => _destructive(),
      AafiatakButtonVariant.text => _text(),
    };

    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }

  Widget _filled() => icon == null
      ? FilledButton(onPressed: onPressed, child: Text(label))
      : FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );

  Widget _tonal() => icon == null
      ? FilledButton.tonal(onPressed: onPressed, child: Text(label))
      : FilledButton.tonalIcon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );

  Widget _outlined() => icon == null
      ? OutlinedButton(onPressed: onPressed, child: Text(label))
      : OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );

  Widget _destructive() {
    final style = FilledButton.styleFrom(
      backgroundColor: AafiatakColors.errorContainer,
      foregroundColor: AafiatakColors.onErrorContainer,
    );
    return icon == null
        ? FilledButton(style: style, onPressed: onPressed, child: Text(label))
        : FilledButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
  }

  Widget _text() => icon == null
      ? TextButton(onPressed: onPressed, child: Text(label))
      : TextButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );
}
