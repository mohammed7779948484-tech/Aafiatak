import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// بيانات صف واحد داخل [AafiatakInfoRows].
///
/// فعّل [isLtr] للقيم التقنية فقط مثل الوقت أو الرقم المرجعي.
class InfoRowItem {
  const InfoRowItem({
    required this.label,
    required this.value,
    this.isLtr = false,
  });

  final String label;
  final String value;
  final bool isLtr;
}

/// قائمة عرض مختصرة لأزواج العنوان والقيمة.
///
/// تستخدم في الملخصات المتكررة، وتتعامل مع عزل قيم LTR دون أن تضيف منطق أعمال.
/// إذا كان شكل الصف خاصًا بميزة واحدة فضعه داخل `feature/widgets`.
class AafiatakInfoRows extends StatelessWidget {
  const AafiatakInfoRows({super.key, required this.rows});

  final List<InfoRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < rows.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(height: AafiatakSpacing.space12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  rows[i].label,
                  style: AafiatakTypography.bodySmall.copyWith(
                    color: AafiatakColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AafiatakSpacing.space12),
              Expanded(
                child: Directionality(
                  textDirection: rows[i].isLtr
                      ? TextDirection.ltr
                      : Directionality.of(context),
                  child: Text(
                    rows[i].value,
                    textAlign: rows[i].isLtr ? TextAlign.end : TextAlign.start,
                    style: AafiatakTypography.labelMedium.copyWith(
                      color: AafiatakColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
