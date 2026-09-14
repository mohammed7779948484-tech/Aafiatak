import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Aafiatak surface container matching the High-Fidelity `.surface` specs.
///
/// Supports standard white surface, soft muted surface, and subtle elevation shadow.
class AafiatakCard extends StatelessWidget {
  const AafiatakCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AafiatakSpacing.md),
    this.backgroundColor,
    this.elevated = false,
    this.onTap,
    this.borderRadius,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final bool elevated;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AafiatakRadii.lg;
    final effectiveBorder = borderColor ?? AafiatakColors.outline;
    final effectiveBg = backgroundColor ?? AafiatakColors.surface;

    final decoration = BoxDecoration(
      color: effectiveBg,
      borderRadius: effectiveRadius,
      border: Border.all(color: effectiveBorder, width: 1),
      boxShadow: elevated
          ? const <BoxShadow>[
              BoxShadow(
                color: Color(0x0E1A1A1A), // rgba(26,26,26,.055)
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ]
          : null,
    );

    Widget content = Padding(padding: padding, child: child);

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveRadius is BorderRadius
              ? effectiveRadius
              : AafiatakRadii.lg,
          child: content,
        ),
      );
    }

    return Container(decoration: decoration, child: content);
  }
}
