import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Linear or circular progress with a consistent accessible label.
class AafiatakProgress extends StatelessWidget {
  const AafiatakProgress.linear({
    super.key,
    this.value,
    this.semanticLabel,
    this.semanticValue,
  }) : isCircular = false;

  const AafiatakProgress.circular({
    super.key,
    this.value,
    this.semanticLabel,
    this.semanticValue,
  }) : isCircular = true;

  final bool isCircular;
  final double? value;
  final String? semanticLabel;
  final String? semanticValue;

  @override
  Widget build(BuildContext context) {
    final label =
        semanticLabel ?? AppLocalizations.of(context).semanticsProgress;

    return isCircular
        ? CircularProgressIndicator(
            value: value,
            semanticsLabel: label,
            semanticsValue: semanticValue,
          )
        : LinearProgressIndicator(
            value: value,
            semanticsLabel: label,
            semanticsValue: semanticValue,
          );
  }
}
