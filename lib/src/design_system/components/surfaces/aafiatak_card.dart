import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakCard extends StatelessWidget {
  const AafiatakCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsetsDirectional.all(AafiatakSpacing.md),
    this.onTap,
    this.semanticLabel,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    final cardChild = onTap == null
        ? content
        : InkWell(
            onTap: onTap,
            borderRadius: AafiatakRadii.card,
            child: content,
          );

    Widget card = Card(clipBehavior: clipBehavior, child: cardChild);

    // High-Fidelity uses the restrained e1 shadow only for interactive cards;
    // static content surfaces remain border-led and flat.
    if (onTap != null) {
      card = DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: AafiatakRadii.card,
          boxShadow: AafiatakElevation.card,
        ),
        child: card,
      );
    }

    return Semantics(
      container: true,
      button: onTap != null,
      label: semanticLabel,
      child: card,
    );
  }
}
