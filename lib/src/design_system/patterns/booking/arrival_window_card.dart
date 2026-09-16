import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

/// بطاقة توضح نافذة الوصول والتنبيه بأنها ليست موعد دخول مضمونًا للطبيب.
///
/// تستقبل العنوان والوقت والملاحظة كنصوص جاهزة، وتعزل [arrivalWindow] باتجاه
/// LTR. لا تحسب المواعيد ولا تتصل بمصدر بيانات؛ هذا من مسؤولية الـ Feature.
class ArrivalWindowCard extends StatelessWidget {
  const ArrivalWindowCard({
    super.key,
    required this.title,
    required this.arrivalWindow,
    required this.note,
  });

  final String title;
  final String arrivalWindow;
  final String note;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title, style: AafiatakTypography.caption),
          const SizedBox(height: AafiatakSpacing.space8),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              arrivalWindow,
              style: AafiatakTypography.h2.copyWith(
                color: AafiatakColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AafiatakSpacing.space8),
          Text(note, style: AafiatakTypography.bodySmall),
        ],
      ),
    );
  }
}
