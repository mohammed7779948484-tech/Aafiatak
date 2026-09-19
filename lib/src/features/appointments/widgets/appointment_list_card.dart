import 'package:flutter/material.dart';

import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';

class AppointmentListCard extends StatelessWidget {
  const AppointmentListCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  final AppointmentMock appointment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: AafiatakBadge(
              label: appointment.statusLabel,
              tone: AafiatakFeedbackTone.success,
            ),
          ),

          const SizedBox(
            height: AafiatakSpacing.space8,
          ),

          Text(
            appointment.doctorName,
            style: AafiatakTypography.h3,
          ),

          const SizedBox(
            height: AafiatakSpacing.space4,
          ),

          Text(
            appointment.serviceName,
            style: AafiatakTypography.body,
          ),

          const SizedBox(
            height: AafiatakSpacing.space16,
          ),

          AafiatakInfoRows(
            rows: [
              InfoRowItem(
                label: 'المنشأة',
                value: appointment.facilityName,
              ),
              InfoRowItem(
                label: 'الفرع',
                value: appointment.branchName,
              ),
              InfoRowItem(
                label: 'التاريخ',
                value: appointment.date,
              ),
              InfoRowItem(
                label: 'وقت الدخول',
                value: appointment.time,
                isLtr: true,
              ),
            ],
          ),

          const SizedBox(
            height: AafiatakSpacing.space20,
          ),

          AafiatakButton.secondary(
            label: 'عرض التفاصيل',
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}