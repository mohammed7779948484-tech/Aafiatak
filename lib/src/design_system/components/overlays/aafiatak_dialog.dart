import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakDialog extends StatelessWidget {
  const AafiatakDialog({
    super.key,
    this.icon,
    this.title,
    required this.content,
    this.actions = const <Widget>[],
    this.semanticLabel,
    this.scrollable = true,
  });

  final Widget? icon;
  final String? title;
  final Widget content;
  final List<Widget> actions;
  final String? semanticLabel;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: title == null ? null : Text(title!),
      content: content,
      actions: actions,
      semanticLabel: semanticLabel,
      scrollable: scrollable,
      actionsPadding: const EdgeInsetsDirectional.fromSTEB(
        AafiatakSpacing.md,
        0,
        AafiatakSpacing.md,
        AafiatakSpacing.md,
      ),
    );
  }
}

Future<T?> showAafiatakDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Theme.of(context).colorScheme.scrim,
    builder: builder,
  );
}
