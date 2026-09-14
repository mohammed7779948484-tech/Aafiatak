import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.avatarText,
    required this.price,
    required this.onTap,
  });

  final String name;
  final String specialty;
  final String avatarText;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      elevated: true,
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AafiatakColors.primaryContainer,
              borderRadius: AafiatakRadii.large,
              border: Border.all(color: const Color(0x1A800020)),
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
          const SizedBox(width: AafiatakSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  style: AafiatakTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(specialty, style: AafiatakTypography.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: AafiatakSpacing.space12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  price,
                  style: AafiatakTypography.labelMedium.copyWith(
                    color: AafiatakColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              const Text('سعر الخدمة', style: AafiatakTypography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
