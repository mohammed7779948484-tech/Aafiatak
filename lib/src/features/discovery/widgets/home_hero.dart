import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// القسم الافتتاحي للرئيسية: سطر تمهيدي بورجوندي، عنوان بطولي بلونين، ونص شرح.

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الرعاية أقرب مما تتوقع',
          style: AafiatakTypography.label.copyWith(
            color: AafiatakColors.primary,
          ),
        ),
        const SizedBox(height: AafiatakSpacing.space12),
        Text.rich(
          TextSpan(
            text: 'ابدأ رحلتك الصحية ',
            style: AafiatakTypography.display,
            children: [
              TextSpan(
                text: 'بوضوح وطمأنينة.',
                style: AafiatakTypography.display.copyWith(
                  color: AafiatakColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AafiatakSpacing.space12),
        Text(
          'ابحث عن طبيب أو تخصص أو قسم أو خدمة، ثم اطّلع على التوفر وأكمل الحجز بخطوات واضحة.',
          style: AafiatakTypography.body.copyWith(
            color: AafiatakColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
