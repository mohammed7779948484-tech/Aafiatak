import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../../booking/mock_data.dart';
import '../mock_data.dart';


class PaymentResultScreen extends StatelessWidget {
  const PaymentResultScreen({
    super.key,
    required this.onAppointmentTap,
  });

  final VoidCallback onAppointmentTap;


  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'نتيجة الدفع',
      screenId: 'PAT-09',
      scrollable: true,

      bottomAction: AafiatakButton.primary(
        label: 'عرض تفاصيل الموعد',
        fullWidth: true,
        onPressed: onAppointmentTap,
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          AafiatakSpacing.space16,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [

            const AafiatakStatusBlock(
              title:
              'تمت معالجة الدفع بنجاح',

              message:
              'تم التحقق من نجاح الدفع الكامل.',

              tone:
              AafiatakFeedbackTone.success,

              icon:
              Icons.check_rounded,

              tag: 'تم الدفع',
            ),

            const SizedBox(
              height: AafiatakSpacing.space16,
            ),

            const AafiatakStatusBlock(
              title:
              'تم تأكيد الموعد',

              message:
              'تم إنشاء موعد مؤكد لهذا الحجز.',

              tone:
              AafiatakFeedbackTone.success,

              icon:
              Icons.calendar_month_rounded,

              tag: 'حالة الحجز',
            ),

            const SizedBox(
              height: AafiatakSpacing.space16,
            ),

            AafiatakCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,

                children: [

                  const AafiatakSectionHeading(
                    label: 'تفاصيل العملية',
                  ),

                  const SizedBox(
                    height:
                    AafiatakSpacing.space12,
                  ),

                  AafiatakInfoRows(
                    rows: const [

                      InfoRowItem(
                        label: 'المبلغ',
                        value:
                        BookingMockData.amount,
                        isLtr: true,
                      ),

                      InfoRowItem(
                        label: 'مرجع الدفع',
                        value:
                        PaymentMockData
                            .paymentReference,
                        isLtr: true,
                      ),

                      InfoRowItem(
                        label: 'رقم الحجز',
                        value:
                        PaymentMockData
                            .bookingNumber,
                        isLtr: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
