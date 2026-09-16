import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

/// بطاقة خدمة طبية تعرض التصنيف والعنوان والسعر وسياسة الدفع.
///
/// هي Pattern عرض خاص بعافيتك وليست طبقة بيانات. تمرر الشاشة النصوص و[onTap]،
/// وتبقى مسؤولية التحميل والتنقل داخل الـ Feature. استخدم Widget محليًا إذا لم
/// يتكرر هذا التركيب بين أكثر من شاشة.
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.price,
    required this.policy,
    required this.badgeLabel,
    required this.onTap,
  });

  final String title;
  final String price;
  final String policy;
  final String badgeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AafiatakBadge(
            label: badgeLabel,
            tone: AafiatakFeedbackTone.secondary,
          ),
          const SizedBox(height: AafiatakSpacing.space8),
          Text(
            title,
            style: AafiatakTypography.labelLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.space4),
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
          const SizedBox(height: AafiatakSpacing.space4),
          Text(policy, style: AafiatakTypography.bodySmall),
        ],
      ),
    );
  }
}
