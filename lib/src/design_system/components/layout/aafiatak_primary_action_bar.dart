import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Stable high-priority action area for phone transactional/form screens.
///
/// Place this widget in [Scaffold.bottomNavigationBar] when the primary action
/// should stay near the thumb zone. It intentionally owns only layout/surface
/// treatment; feature logic and action eligibility stay outside the Design
/// System.
class AafiatakPrimaryActionBar extends StatelessWidget {
  const AafiatakPrimaryActionBar({
    super.key,
    required this.primaryAction,
    this.secondaryAction,
    this.supporting,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AafiatakSpacing.md,
      AafiatakSpacing.sm,
      AafiatakSpacing.md,
      AafiatakSpacing.md,
    ),
    this.useSafeArea = true,
  });

  final Widget primaryAction;
  final Widget? secondaryAction;
  final Widget? supporting;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget content = Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (supporting != null) ...<Widget>[
            supporting!,
            const SizedBox(height: AafiatakSpacing.sm),
          ],
          if (secondaryAction != null) ...<Widget>[
            secondaryAction!,
            const SizedBox(height: AafiatakSpacing.xs),
          ],
          primaryAction,
        ],
      ),
    );

    if (useSafeArea) {
      content = SafeArea(top: false, child: content);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(
            color: scheme.outlineVariant,
            width: AafiatakBorders.subtle,
          ),
        ),
      ),
      child: content,
    );
  }
}
