import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../../booking/mock_data.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    super.key,
    required this.selectedDay,
    required this.onPaymentTap,
  });

  final AvailabilityDayMock selectedDay;
  final VoidCallback onPaymentTap;

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'الدفع الكامل',
      screenId: 'PAT-08',
      scrollable: true,
      bottomAction: AafiatakButton.primary(
        label: 'متابعة الدفع',
        icon: Icons.credit_card_rounded,
        fullWidth: true,
        onPressed: onPaymentTap,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AafiatakSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppointmentSummary(
              service: BookingMockData.service,
              doctor: BookingMockData.doctor,
              facility: BookingMockData.facility,
              branch: BookingMockData.branch,
              date: selectedDay.fullDate,
              arrivalWindow: BookingMockData.arrivalWindow,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            AafiatakCard(
              elevated: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AafiatakSectionHeading(label: 'المبلغ الكامل'),
                  const SizedBox(height: AafiatakSpacing.space12),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      BookingMockData.amount,
                      style: AafiatakTypography.display.copyWith(
                        color: AafiatakColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            const ReservationHoldBanner(
              countdown: BookingMockData.holdCountdown,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            const AafiatakNotice(
              message: 'سيتم الانتقال إلى الدفع الآمن، ولن يتم تأكيد الموعد إلا بعد نجاح عملية الدفع.',
              tone: AafiatakFeedbackTone.info,
            ),
          ],
        ),
      ),
    );
  }
}
