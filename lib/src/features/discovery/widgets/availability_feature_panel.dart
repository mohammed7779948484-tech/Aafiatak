import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

/// اللوحة البورجوندية التعريفية في الرئيسية: تشرح نافذة الوصول
/// قبل بدء الحجز. شكلها الخاص (شارة بيضاء شفافة وتدرج وزخارف هندسية)
/// يخص ميزة الاكتشاف وحدها، لذلك تسكن هنا لا في Design System.

class AvailabilityFeaturePanel extends StatelessWidget {
  const AvailabilityFeaturePanel({
    super.key,
    required this.onAvailabilityRequested,
  });

  final VoidCallback onAvailabilityRequested;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AafiatakSpacing.space20),
      constraints: const BoxConstraints(minHeight: 196),
      decoration: const BoxDecoration(
        borderRadius: AafiatakRadii.extraLarge,
        gradient: LinearGradient(
          colors: [AafiatakColors.primary, AafiatakColors.onPrimaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33800020),
            offset: Offset(0, 12),
            blurRadius: 26,
          ),
        ],
      ),

      child: Stack(
        children: [
          Positioned(
            left: -54,
            top: -62,
            child: Transform.rotate(
              angle: 11 * math.pi / 180,
              child: Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x26FFFFFF), width: 1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(58),
                    bottom: Radius.circular(88),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -22,
            bottom: -34,
            child: Container(
              height: 76,
              width: 76,

              decoration: const BoxDecoration(
                borderRadius: AafiatakRadii.full,
                color: Color(0x1FFFFFFF),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              const _PanelBadge(label: 'نافذة وصول واضحة'),
              const SizedBox(height: AafiatakSpacing.space12),
              Text(
                'اعرف التوفر قبل أن تبدأ الحجز',
                style: AafiatakTypography.h2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AafiatakSpacing.space12),
              Text(
                'اختر الخدمة واليوم، وسيعرض النظام نافذة الوصول المتاحة دون أن يوهمك بوقت دخول مضمون للطبيب.',
                style: AafiatakTypography.bodySmall.copyWith(
                  color: const Color(0xCCFFFFFF),
                ),
              ),
              const SizedBox(height: AafiatakSpacing.space12),
              AafiatakButton.secondary(
                label: 'استكشف التوفر',
                icon: Icons.arrow_back_outlined,
                onPressed: onAvailabilityRequested,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// شارة اللوحة: نسخة بيضاء شفافة من نمط الشارة العام،
/// مصممة لتُقرأ فوق الخلفية البورجوندية الداكنة.

class _PanelBadge extends StatelessWidget {
  const _PanelBadge({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 28),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: const BoxDecoration(
        color: Color(0x24FFFFFF),
        borderRadius: AafiatakRadii.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AafiatakTypography.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
