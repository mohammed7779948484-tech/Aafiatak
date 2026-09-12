import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import 'aafiatak_feedback_tone.dart';

/// Domain-neutral persistent status panel.
///
/// Domain-specific appointment/payment/visit/queue status blocks should be
/// built later from this primitive rather than embedding business-state logic
/// here.
class AafiatakStatusBlock extends StatelessWidget {
  const AafiatakStatusBlock({
    super.key,
    required this.title,
    this.message,
    this.tone = AafiatakFeedbackTone.neutral,
    this.icon,
    this.action,
    this.trailing,
    this.semanticLabel,
  });

  final String title;
  final String? message;
  final AafiatakFeedbackTone tone;
  final Widget? icon;
  final Widget? action;
  final Widget? trailing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors(context);
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: AafiatakRadii.card,
          border: Border.all(
            color: colors.border,
            width: AafiatakBorders.subtle,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AafiatakSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                IconTheme(
                  data: IconThemeData(
                    color: colors.foreground,
                    size: AafiatakSizes.iconDefault,
                  ),
                  child: icon!,
                ),
                const SizedBox(width: AafiatakSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.foreground,
                      ),
                    ),
                    if (message != null) ...<Widget>[
                      const SizedBox(height: AafiatakSpacing.xxs),
                      Text(
                        message!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.foreground,
                        ),
                      ),
                    ],
                    if (action != null) ...<Widget>[
                      const SizedBox(height: AafiatakSpacing.xs),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: action!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...<Widget>[
                const SizedBox(width: AafiatakSpacing.sm),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
