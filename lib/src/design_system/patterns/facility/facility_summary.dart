import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

class FacilitySummary extends StatelessWidget {
  const FacilitySummary({
    super.key,
    required this.facilityName,
    required this.location,
    required this.branch,
    required this.onTap,
  });

  final String facilityName;
  final String location;
  final String branch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AafiatakBadge(label: branch, tone: AafiatakFeedbackTone.info),
          const SizedBox(height: AafiatakSpacing.space8),
          Text(
            facilityName,
            style: AafiatakTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(location, style: AafiatakTypography.bodySmall),
          const SizedBox(height: AafiatakSpacing.space12),
          ListTile(
            onTap: onTap,
            tileColor: AafiatakColors.surfaceLow,
            shape: const RoundedRectangleBorder(
              borderRadius: AafiatakRadii.medium,
            ),
            contentPadding: const EdgeInsetsDirectional.symmetric(
              horizontal: AafiatakSpacing.space12,
            ),
            title: Text(
              'عرض تفاصيل المنشأة',
              style: AafiatakTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: const Text(
              'الموقع، التواصل وساعات العمل',
              style: AafiatakTypography.bodySmall,
            ),
            trailing: const Icon(
              Icons.chevron_left,
              color: AafiatakColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
