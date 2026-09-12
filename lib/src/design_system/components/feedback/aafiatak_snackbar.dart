import 'package:flutter/material.dart';

import 'aafiatak_feedback_tone.dart';

abstract final class AafiatakSnackbar {
  const AafiatakSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    AafiatakFeedbackTone tone = AafiatakFeedbackTone.neutral,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool clearExisting = true,
  }) {
    final colors = tone.colors(context);
    final messenger = ScaffoldMessenger.of(context);
    if (clearExisting) messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: colors.solid,
        duration: duration,
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colors.onSolid),
        ),
        action: actionLabel == null || onAction == null
            ? null
            : SnackBarAction(
                label: actionLabel,
                textColor: colors.onSolid,
                onPressed: onAction,
              ),
      ),
    );
  }
}
