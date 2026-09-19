import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/discovery/mock_data.dart';
import 'package:flutter/material.dart';

/// قسم «موعدك القادم» في الرئيسية: يظهر للمريض المسجل فقط ويختفي عن الزائر.
/// يستقبل الموعد من الشاشة (من mock_data) ووجهة عرض التفاصيل كـ callback.

class UpcomingAppointmentSection extends StatelessWidget {
  const UpcomingAppointmentSection({
    super.key,
    required this.appointment,
    required this.onViewDetailsRequested,
  });
  final UpcomingAppointment appointment;
  final VoidCallback onViewDetailsRequested;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AafiatakSectionHeading(
          label: 'موعدك القادم',
          meta: 'يتطلب تسجيل الدخول',
        ),
        const SizedBox(height: AafiatakSpacing.space12),
        AafiatakCard(
          elevated: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AafiatakBadge(
                label: 'موعد قادم',
                tone: AafiatakFeedbackTone.secondary,
              ),
              const SizedBox(height: AafiatakSpacing.space12),
              Text(
                appointment.doctorName,
                style: AafiatakTypography.h3.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AafiatakSpacing.space4),
              Text(
                appointment.serviceName,
                style: AafiatakTypography.bodySmall,
              ),
              const SizedBox(height: AafiatakSpacing.space12),
              AafiatakInfoRows(
                rows: [
                  InfoRowItem(label: 'التاريخ', value: appointment.date),
                  InfoRowItem(
                    label: 'نافذة الوصول',
                    value: appointment.arrivalWindow,
                    isLtr: true,
                  ),
                ],
              ),
              const SizedBox(height: AafiatakSpacing.space12),
              AafiatakButton.text(
                label: 'عرض تفاصيل الموعد',
                fullWidth: true,
                onPressed: onViewDetailsRequested,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
