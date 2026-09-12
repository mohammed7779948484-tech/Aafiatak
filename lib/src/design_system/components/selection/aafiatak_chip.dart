import 'package:flutter/material.dart';

/// Compact non-destructive filter/selection control built on Material 3.
class AafiatakChip extends StatelessWidget {
  const AafiatakChip({
    super.key,
    required this.label,
    required this.onSelected,
    this.selected = false,
    this.leading,
    this.enabled = true,
    this.semanticLabel,
  });

  final String label;
  final ValueChanged<bool>? onSelected;
  final bool selected;
  final Widget? leading;
  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final chip = FilterChip(
      avatar: leading,
      label: Text(label),
      selected: selected,
      onSelected: enabled ? onSelected : null,
      showCheckmark: true,
    );

    if (semanticLabel == null) return chip;

    return Semantics(
      label: semanticLabel,
      selected: selected,
      enabled: enabled && onSelected != null,
      button: true,
      onTap: enabled && onSelected != null
          ? () => onSelected!(!selected)
          : null,
      excludeSemantics: true,
      child: chip,
    );
  }
}
