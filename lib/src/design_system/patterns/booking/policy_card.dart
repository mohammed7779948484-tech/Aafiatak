import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../../components/components.dart';

/// Policy instruction card matching the High-Fidelity `.policy-card` pattern.
///
/// Features a title with a primary icon and an unordered bullet list of guidelines.
class PolicyCard extends StatelessWidget {
  const PolicyCard({
    super.key,
    required this.title,
    List<String>? guidelines,
    List<String>? items,
    this.icon = Icons.verified_user_outlined,
  }) : items = guidelines ?? items ?? const <String>[];

  final String title;
  final List<String> items;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 22, color: AafiatakColors.primary),
              const SizedBox(width: AafiatakSpacing.xs),
              Expanded(
                child: Text(
                  title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    color: AafiatakColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AafiatakSpacing.sm),
          for (final item in items) ...<Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: AafiatakSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 8, right: 4),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AafiatakColors.textSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: AafiatakTypography.bodySmall.copyWith(
                        color: AafiatakColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
