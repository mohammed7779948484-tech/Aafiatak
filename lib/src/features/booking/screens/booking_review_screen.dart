import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';

enum _BookingReviewView { review, activeHold }

class BookingReviewScreen extends StatefulWidget {
  const BookingReviewScreen({
    super.key,
    required this.selectedDay,
    required this.onPaymentTap,
  });

  final AvailabilityDayMock selectedDay;
  final ValueChanged<AvailabilityDayMock> onPaymentTap;

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  _BookingReviewView _view = _BookingReviewView.review;

  void _createTemporaryHold() {
    setState(() {
      _view = _BookingReviewView.activeHold;
    });
  }

  void _continueToPayment() {
    widget.onPaymentTap(widget.selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveHold = _view == _BookingReviewView.activeHold;

    return PatientShell.detail(
      title: 'مراجعة الحجز',
      screenId: 'PAT-07',
      scrollable: true,
      bottomAction: hasActiveHold
          ? AafiatakButton.primary(
              label: 'متابعة إلى الدفع',
              icon: Icons.credit_card_rounded,
              fullWidth: true,
              onPressed: _continueToPayment,
            )
          : AafiatakButton.primary(
              label: 'إنشاء الحجز المؤقت',
              fullWidth: true,
              onPressed: _createTemporaryHold,
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
              date: widget.selectedDay.fullDate,
              arrivalWindow: BookingMockData.arrivalWindow,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AafiatakSectionHeading(label: 'المبلغ المستحق'),
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
            if (hasActiveHold) ...[
              const ReservationHoldBanner(
                countdown: BookingMockData.holdCountdown,
              ),
              const SizedBox(height: AafiatakSpacing.space16),
              const AafiatakNotice(
                message:
                    'تم إنشاء حجز مؤقت. أكمل الدفع قبل انتهاء المدة لتأكيد الموعد.',
                tone: AafiatakFeedbackTone.info,
              ),
            ] else
              const AafiatakNotice(
                message:
                    'راجع تفاصيل الموعد ثم أنشئ الحجز المؤقت للمتابعة إلى الدفع.',
                tone: AafiatakFeedbackTone.info,
              ),
          ],
        ),
      ),
    );
  }
}
