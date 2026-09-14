import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../../components/components.dart';

/// Appointment summary card pattern matching the High-Fidelity `appointmentSummary()` component.
///
/// Composes service badge, doctor name (H3), facility/branch line, and key-value rows
/// for appointment date and arrival window.
class AppointmentSummary extends StatelessWidget {
  const AppointmentSummary({
    super.key,
    required this.service,
    required this.doctor,
    required this.facility,
    this.branch,
    required this.date,
    required this.arrivalWindow,
    this.serviceTone = AafiatakFeedbackTone.primary,
    this.action,
  });

  final String service;
  final String doctor;
  final String facility;
  final String? branch;
  final String date;
  final String arrivalWindow;
  final AafiatakFeedbackTone serviceTone;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      elevated: true,
      padding: const EdgeInsets.all(AafiatakSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AafiatakBadge(label: service, tone: serviceTone),
          const SizedBox(height: AafiatakSpacing.xs),
          Text(
            doctor,
            style: AafiatakTypography.h3.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            branch != null ? '$facility · $branch' : facility,
            style: AafiatakTypography.bodySmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.sm),
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
          if (action != null) ...<Widget>[
            const SizedBox(height: AafiatakSpacing.sm),
            action!,
          ],
        ],
      ),
    );
  }
}
