import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

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
          Text(title, style: AafiatakTypography.labelSmall),
          const SizedBox(height: AafiatakSpacing.space8),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              arrivalWindow,
              style: AafiatakTypography.headlineMedium.copyWith(
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
