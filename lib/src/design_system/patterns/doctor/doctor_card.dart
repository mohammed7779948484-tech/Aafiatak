import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../../components/components.dart';

/// Doctor card pattern matching the High-Fidelity `.doctor-card` component.
///
/// Features a 58x58 avatar, doctor name, specialty subtitle, and price badge
/// with LTR isolation and "سعر الخدمة" caption.
class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    this.initials = 'د.ع',
    String? avatarText,
    this.price = '15,000 ر.ي',
    this.priceSubtitle = 'سعر الخدمة',
    this.onTap,
  }) : avatarText = avatarText ?? initials;

  final String name;
  final String specialty;
  final String initials;
  final String avatarText;
  final String price;
  final String priceSubtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      elevated: true,
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AafiatakColors.primaryContainer,
              borderRadius: AafiatakRadii.lg,
              border: Border.all(
                color: const Color(0x1A800020), // rgba(128,0,32,.10)
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              avatarText,
              style: AafiatakTypography.labelLarge.copyWith(
                color: AafiatakColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(width: AafiatakSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  style: AafiatakTypography.labelLarge.copyWith(
                    color: AafiatakColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  specialty,
                  style: AafiatakTypography.bodySmall.copyWith(
                    color: AafiatakColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AafiatakSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  price,
                  style: AafiatakTypography.label.copyWith(
                    color: AafiatakColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                priceSubtitle,
                style: AafiatakTypography.caption.copyWith(
                  color: AafiatakColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
