import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../feedback/aafiatak_feedback_tone.dart';

class AafiatakBadge extends StatelessWidget {
  const AafiatakBadge({
    super.key,
    required this.label,
    this.tone = AafiatakFeedbackTone.neutral,
    this.icon,
  });

  final String label;
  final AafiatakFeedbackTone tone;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors(context);
    final textStyle = Theme.of(context).textTheme.labelSmall
        ?.copyWith(color: colors.foreground);

    return Semantics(
      label: label,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: AafiatakRadii.full,
          border: Border.all(
            color: colors.border,
            width: AafiatakBorders.subtle,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AafiatakSpacing.sm,
            vertical: AafiatakSpacing.xxs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                IconTheme(
                  data: IconThemeData(
                    color: colors.foreground,
                    size: AafiatakSizes.iconInline,
                  ),
                  child: icon!,
                ),
                const SizedBox(width: AafiatakSpacing.xxs),
              ],
              Text(label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
