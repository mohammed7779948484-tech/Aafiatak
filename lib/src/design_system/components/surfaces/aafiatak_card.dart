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

    return Semantics(
      container: true,
      button: onTap != null,
      label: semanticLabel,
      child: Card(clipBehavior: clipBehavior, child: cardChild),
    );
  }
}
