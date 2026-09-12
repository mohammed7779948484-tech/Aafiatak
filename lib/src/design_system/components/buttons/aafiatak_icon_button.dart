import 'package:flutter/material.dart';

enum AafiatakIconButtonVariant { standard, filled, tonal, outlined }

/// Icon-only action with a required accessible tooltip.
class AafiatakIconButton extends StatelessWidget {
  const AafiatakIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.variant = AafiatakIconButtonVariant.standard,
  });

  final Widget icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final AafiatakIconButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      AafiatakIconButtonVariant.standard => IconButton(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
      AafiatakIconButtonVariant.filled => IconButton.filled(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
      AafiatakIconButtonVariant.tonal => IconButton.filledTonal(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
      AafiatakIconButtonVariant.outlined => IconButton.outlined(
        icon: icon,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    };
  }
}
