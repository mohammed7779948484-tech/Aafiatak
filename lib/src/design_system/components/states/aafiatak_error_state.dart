import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakErrorState extends StatelessWidget {
  const AafiatakErrorState({
    super.key,
    required this.title,
    required this.message,
    this.icon = const Icon(Icons.error_outline_rounded),
    this.action,
  });

  final String title;
  final String message;
  final Widget? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      container: true,
      liveRegion: true,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AafiatakSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  IconTheme(
                    data: IconThemeData(
                      color: theme.colorScheme.error,
                      size: AafiatakSizes.iconHero,
                    ),
                    child: icon!,
                  ),
                  const SizedBox(height: AafiatakSpacing.md),
                ],
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AafiatakSpacing.xs),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (action != null) ...<Widget>[
                  const SizedBox(height: AafiatakSpacing.lg),
                  action!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
