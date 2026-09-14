import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../../components/components.dart';

/// Arrival window notice card matching the High-Fidelity `.arrival-window` pattern.
///
/// Features an explanatory caption, large bold Burgundy arrival time (LTR isolated),
/// and standard non-guarantee disclaimer copy.
class ArrivalWindowCard extends StatelessWidget {
  const ArrivalWindowCard({
    super.key,
    this.title,
    this.note,
    String? window,
    String? arrivalWindow,
    this.caption = 'نافذة الوصول التي خصصها النظام',
    this.disclaimer = 'هذه نافذة وصول وليست وقت دخول مضمونًا للطبيب.',
  }) : arrivalWindow = window ?? arrivalWindow ?? '';

  final String arrivalWindow;
  final String? title;
  final String? note;
  final String caption;
  final String disclaimer;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title ?? caption,
            style: AafiatakTypography.caption.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.xs),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              arrivalWindow,
              style: AafiatakTypography.h2.copyWith(
                color: AafiatakColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AafiatakSpacing.xs),
          Text(
            note ?? disclaimer,
            style: AafiatakTypography.bodySmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
