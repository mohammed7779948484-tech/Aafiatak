import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// تنبيه بصري بأن السعة محجوزة مؤقتًا مع عرض العد التنازلي.
///
/// يستقبل [countdown] جاهزًا ولا يشغّل مؤقتًا أو ينشئ حجزًا؛ منطق مدة الحجز
/// يبقى في الشاشة وإعداداتها. يوجد في Patterns لأنه تركيب خاص بتدفق عافيتك.
class ReservationHoldBanner extends StatelessWidget {
  const ReservationHoldBanner({super.key, required this.countdown});

  final String countdown;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 76),
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.space16,
        vertical: AafiatakSpacing.space12,
      ),
      decoration: BoxDecoration(
        color: AafiatakColors.primaryContainer,
        borderRadius: AafiatakRadii.large,
        border: Border.all(color: AafiatakColors.primaryBorderSubtle),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'تم حجز السعة لك مؤقتًا',
                  style: AafiatakTypography.label.copyWith(
                    color: AafiatakColors.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'أكمل الخطوة التالية قبل انتهاء الحجز المؤقت.',
                  style: AafiatakTypography.caption.copyWith(
                    color: AafiatakColors.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AafiatakSpacing.space12),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              countdown,
              style: AafiatakTypography.h3.copyWith(
                color: AafiatakColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
