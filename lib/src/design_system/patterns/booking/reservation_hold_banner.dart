import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Reservation hold attention banner matching the High-Fidelity `.hold-banner` pattern.
///
/// Features a light burgundy container (#F7E9EC), title, supporting copy,
/// and an LTR-isolated countdown timer in bold brand Burgundy.
class ReservationHoldBanner extends StatelessWidget {
  const ReservationHoldBanner({
    super.key,
    this.title = 'تم حجز السعة لك مؤقتًا',
    this.copy = 'أكمل الخطوة التالية قبل انتهاء الحجز المؤقت.',
    required this.countdown,
  });

  final String title;
  final String copy;
  final String countdown;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 76),
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.md,
        vertical: AafiatakSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AafiatakColors.holdContainer,
        borderRadius: AafiatakRadii.lg,
        border: Border.all(
          color: const Color(0x1F800020), // rgba(128,0,32,.12)
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: AafiatakTypography.label.copyWith(
                    color: AafiatakColors.onHoldContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  copy,
                  style: AafiatakTypography.caption.copyWith(
                    color: AafiatakColors.onHoldContainer.withValues(
                      alpha: 0.86,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AafiatakSpacing.sm),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              countdown,
              style: AafiatakTypography.h3.copyWith(
                color: AafiatakColors.hold,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
