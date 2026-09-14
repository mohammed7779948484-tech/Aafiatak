import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../data_display/aafiatak_badge.dart';
import '../surfaces/aafiatak_card.dart';
import 'aafiatak_feedback_tone.dart';

/// كتلة حالة بارزة لنتائج مثل نجاح الحجز أو تعذر الإجراء.
///
/// تجمع بطاقة Material وشارة وأيقونة فقط، ويحدد [tone] التنسيق المرئي. لا
/// تحتوي منطق أعمال أو تنقلًا؛ الشاشة تمرر الحالة والنص الناتجين من بياناتها.
class AafiatakStatusBlock extends StatelessWidget {
  const AafiatakStatusBlock({
    super.key,
    required this.title,
    required this.message,
    required this.tone,
    required this.icon,
    required this.tag,
  });

  final String title;
  final String message;
  final AafiatakFeedbackTone tone;
  final IconData icon;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors;

    return AafiatakCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: AafiatakRadii.large,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 24, color: colors.foreground),
          ),
          const SizedBox(width: AafiatakSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AafiatakBadge(label: tag, tone: tone),
                const SizedBox(height: AafiatakSpacing.space8),
                Text(
                  title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    color: AafiatakColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: AafiatakTypography.bodySmall.copyWith(
                    color: AafiatakColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
