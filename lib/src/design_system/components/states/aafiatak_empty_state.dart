import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../buttons/aafiatak_button.dart';
import '../surfaces/aafiatak_card.dart';

class AafiatakEmptyState extends StatelessWidget {
  const AafiatakEmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AafiatakSpacing.space16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.info_outline,
              size: 48,
              color: AafiatakColors.textPrimary,
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AafiatakTypography.titleLarge,
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AafiatakTypography.bodySmall,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            AafiatakButton(
              label: actionLabel,
              variant: AafiatakButtonVariant.tonal,
              onPressed: onAction,
            ),
          ],
        ),
      ),
    );
  }
}
