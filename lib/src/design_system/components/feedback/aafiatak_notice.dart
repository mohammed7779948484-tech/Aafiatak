import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

import 'aafiatak_feedback_tone.dart';

/// ملاحظة سياقية قصيرة لعرض معلومات أو تحذير أو نتيجة داخل الشاشة.
///
/// تستقبل [tone] لتحديد المعنى، لكنها لا تنفذ أي منطق أعمال. حالات التحقق
/// والإجراءات المدمرة تستخدم أدوار الخطأ في Material ولا تضيف نبرة تطبيق خاصة.
class AafiatakNotice extends StatelessWidget {
  const AafiatakNotice({super.key, required this.message, required this.tone});

  final String message;
  final AafiatakFeedbackTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = tone.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AafiatakSpacing.space16,
        vertical: AafiatakSpacing.space12,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: AafiatakRadii.large,
      ),
      child: Text(
        message,
        style: AafiatakTypography.bodySmall.copyWith(color: colors.foreground),
      ),
    );
  }
}
