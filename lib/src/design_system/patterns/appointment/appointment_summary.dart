import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

/// ملخص بصري لموعد يعرض الخدمة والطبيب والمنشأة ونافذة الوصول.
///
/// هذا Pattern خاص بعافيتك ويستقبل قيمًا جاهزة للعرض فقط. لا يحسب حالة الموعد
/// ولا يجلب بيانات ولا يغير المسار؛ الشاشة مسؤولة عن منطقها وأحداثها.
class AppointmentSummary extends StatelessWidget {
  const AppointmentSummary({
    super.key,
    required this.service,
    required this.doctor,
    required this.facility,
    required this.branch,
    required this.date,
    required this.arrivalWindow,
  });

  final String service;
  final String doctor;
  final String facility;
  final String branch;
  final String date;
  final String arrivalWindow;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      elevated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AafiatakBadge(label: service, tone: AafiatakFeedbackTone.primary),
          const SizedBox(height: AafiatakSpacing.space8),
          Text(
            doctor,
            style: AafiatakTypography.h3.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text('$facility · $branch', style: AafiatakTypography.bodySmall),
          const SizedBox(height: AafiatakSpacing.space12),
          AafiatakInfoRows(
            rows: <InfoRowItem>[
              InfoRowItem(label: 'اليوم', value: date),
              InfoRowItem(
                label: 'نافذة الوصول',
                value: arrivalWindow,
                isLtr: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
