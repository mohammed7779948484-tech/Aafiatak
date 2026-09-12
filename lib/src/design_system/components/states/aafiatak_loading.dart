import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakLoading extends StatelessWidget {
  const AafiatakLoading({
    super.key,
    this.message,
    this.compact = false,
    this.semanticLabel,
  });

  final String? message;
  final bool compact;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox.square(
          dimension: compact
              ? AafiatakSizes.iconDefault
              : AafiatakSizes.iconLarge,
          child: const CircularProgressIndicator(
            strokeWidth: AafiatakSizes.progressStroke,
          ),
        ),
        if (message != null) ...<Widget>[
          const SizedBox(height: AafiatakSpacing.sm),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );

    return Semantics(
      liveRegion: true,
      excludeSemantics: true,
      label:
          semanticLabel ??
          message ??
          AppLocalizations.of(context).semanticsLoading,
      child: compact ? content : Center(child: content),
    );
  }
}
