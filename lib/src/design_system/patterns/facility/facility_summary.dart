import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../../components/components.dart';

/// Facility summary card pattern matching the High-Fidelity `facilitySummary()` component.
///
/// Shows branch badge, facility name, location subtitle, and a tapped action preview.
class FacilitySummary extends StatelessWidget {
  const FacilitySummary({
    super.key,
    String? name,
    String? facilityName,
    required this.location,
    this.branch = 'الفرع الرئيسي',
    this.actionTitle = 'عرض تفاصيل المنشأة',
    this.actionSubtitle = 'الموقع، التواصل وساعات العمل',
    this.onTap,
  }) : facilityName = name ?? facilityName ?? '';

  final String facilityName;
  final String location;
  final String branch;
  final String actionTitle;
  final String actionSubtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AafiatakBadge(label: branch, tone: AafiatakFeedbackTone.info),
          const SizedBox(height: AafiatakSpacing.xs),
          Text(
            facilityName,
            style: AafiatakTypography.h3.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            location,
            style: AafiatakTypography.bodySmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.sm),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: AafiatakRadii.md,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AafiatakColors.surfaceLow,
                  borderRadius: AafiatakRadii.md,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            actionTitle,
                            style: AafiatakTypography.labelLarge.copyWith(
                              color: AafiatakColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            actionSubtitle,
                            style: AafiatakTypography.bodySmall.copyWith(
                              color: AafiatakColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_left,
                      color: AafiatakColors.primary,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
