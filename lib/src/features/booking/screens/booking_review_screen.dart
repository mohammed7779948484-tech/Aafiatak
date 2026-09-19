import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';

class BookingReviewScreen extends StatelessWidget {
  const BookingReviewScreen({
    super.key,
    required this.onPaymentTap,
  });

  final VoidCallback onPaymentTap;


  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'مراجعة الحجز',
      screenId: 'PAT-07',
      scrollable: true,

      bottomAction: AafiatakButton.primary(
        label: 'متابعة إلى الدفع',
        icon: Icons.credit_card_rounded,
        fullWidth: true,
        onPressed: onPaymentTap,
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          AafiatakSpacing.space16,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [

            AafiatakCard(
              elevated: true,

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const AafiatakSectionHeading(
                    label: 'تفاصيل الموعد',
                  ),

                  const SizedBox(
                    height:
                    AafiatakSpacing.space12,
                  ),

                  AafiatakInfoRows(
                    rows: [
                      InfoRowItem(
                        label: 'الطبيب',
                        value:
                        BookingMockData.doctor,
                      ),

                      InfoRowItem(
                        label: 'الخدمة',
                        value:
                        BookingMockData.service,
                      ),

                      InfoRowItem(
                        label: 'التاريخ',
                        value:
                        BookingMockData.holdCountdown,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height:
              AafiatakSpacing.space16,
            ),

            AafiatakCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const AafiatakSectionHeading(
                    label: 'المبلغ المستحق',
                  ),

                  const SizedBox(
                    height:
                    AafiatakSpacing.space12,
                  ),

                  Directionality(
                    textDirection:
                    TextDirection.ltr,

                    child: Text(
                      BookingMockData.amount,

                      style:
                      AafiatakTypography.display
                          .copyWith(
                        color:
                        AafiatakColors.primary,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height:
              AafiatakSpacing.space16,
            ),

            const ReservationHoldBanner(
              countdown:
              BookingMockData.holdCountdown,
            ),

            const SizedBox(
              height:
              AafiatakSpacing.space16,
            ),

            const AafiatakNotice(
              message:
              'تم إنشاء حجز مؤقت. أكمل الدفع لتأكيد الموعد.',

              tone:
              AafiatakFeedbackTone.info,
            ),
          ],
        ),
      ),
    );
  }
}