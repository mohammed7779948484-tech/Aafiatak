import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import 'aafiatak_feedback_tone.dart';

class AafiatakBanner extends StatelessWidget {
  const AafiatakBanner({
    super.key,
    required this.message,
    this.title,
    this.tone = AafiatakFeedbackTone.info,
    this.icon,
    this.action,
    this.onDismiss,
    this.semanticLabel,
  });

  final String message;
  final String? title;
  final AafiatakFeedbackTone tone;
  final Widget? icon;
  final Widget? action;
  final VoidCallback? onDismiss;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors(context);
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      liveRegion: true,
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.background,
          border: Border(
            bottom: BorderSide(
              color: colors.border,
              width: AafiatakBorders.subtle,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AafiatakSpacing.md,
            AafiatakSpacing.sm,
            AafiatakSpacing.md,
            AafiatakSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: AafiatakSpacing.xxs,
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: colors.foreground,
                      size: AafiatakSizes.iconDefault,
                    ),
                    child: icon!,
                  ),
                ),
                const SizedBox(width: AafiatakSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (title != null) ...<Widget>[
                      Text(
                        title!,
                        style: textTheme.labelLarge?.copyWith(
                          color: colors.foreground,
                        ),
                      ),
                      const SizedBox(height: AafiatakSpacing.xxs),
                    ],
                    Text(
                      message,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.foreground,
                      ),
                    ),
                    if (action != null) ...<Widget>[
                      const SizedBox(height: AafiatakSpacing.xs),
                      action!,
                    ],
                  ],
                ),
              ),
              if (onDismiss != null) ...<Widget>[
                const SizedBox(width: AafiatakSpacing.xs),
                IconButton(
                  tooltip: AppLocalizations.of(context).dismissTooltip,
                  onPressed: onDismiss,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
