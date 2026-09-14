import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../../components/components.dart';

/// Service card pattern matching the High-Fidelity `.service-card` component.
///
/// Features a service badge, title, bold Burgundy price (LTR isolated),
/// and payment policy subtitle.
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    String? name,
    String? title,
    required this.price,
    required this.policy,
    this.badgeLabel = 'خدمة',
    this.badgeTone = AafiatakFeedbackTone.secondary,
    this.onTap,
  }) : name = title ?? name ?? '';

  final String name;
  final String price;
  final String policy;
  final String badgeLabel;
  final AafiatakFeedbackTone badgeTone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AafiatakBadge(label: badgeLabel, tone: badgeTone),
          const SizedBox(height: AafiatakSpacing.xs),
          Text(
            name,
            style: AafiatakTypography.labelLarge.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.xxs),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              price,
              style: AafiatakTypography.h3.copyWith(
                color: AafiatakColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AafiatakSpacing.xxs),
          Text(
            policy,
            style: AafiatakTypography.bodySmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
