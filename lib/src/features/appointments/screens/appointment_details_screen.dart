import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';


class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({
    super.key,
    required this.appointmentId,
    required this.onBackPressed,
  });

  final String appointmentId;
  final VoidCallback onBackPressed;


  @override
  Widget build(BuildContext context) {

    final currentAppointment =
    AppointmentsMockData.upcomingAppointments.firstWhere(
          (appointment) => appointment.id == appointmentId,
    );


    return PatientShell.detail(
      title: 'تفاصيل الموعد',

      onBackPressed: onBackPressed,

      scrollable: true,

      body: Padding(
        padding: const EdgeInsets.all(
          AafiatakSpacing.space16,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            Align(
              alignment: AlignmentDirectional.centerStart,

              child: AafiatakBadge(
                label: currentAppointment.statusLabel,
                tone: AafiatakFeedbackTone.success,
              ),
            ),


            const SizedBox(
              height: AafiatakSpacing.space16,
            ),


            const AafiatakSectionHeading(
              label: 'بيانات الموعد',
            ),


            const SizedBox(
              height: AafiatakSpacing.space12,
            ),


            AppointmentSummary(
              service: currentAppointment.serviceName,
              doctor: currentAppointment.doctorName,
              facility: currentAppointment.facilityName,
              branch: currentAppointment.branchName,
              date: currentAppointment.date,
              arrivalWindow: currentAppointment.time,
            ),


            const SizedBox(
              height: AafiatakSpacing.space20,
            ),


            const AafiatakSectionHeading(
              label: 'بيانات الحجز',
            ),


            const SizedBox(
              height: AafiatakSpacing.space12,
            ),


            AafiatakCard(
              child: AafiatakInfoRows(
                rows: [

                  InfoRowItem(
                    label: 'رقم الحجز',
                    value: currentAppointment.referenceNumber,
                    isLtr: true,
                  ),

                  InfoRowItem(
                    label: 'الحالة',
                    value: currentAppointment.statusLabel,
                  ),
                ],
              ),
            ),


            const SizedBox(
              height: AafiatakSpacing.space20,
            ),


            AafiatakStatusBlock(
              title: 'حالة الدفع',

              message: 'تم التحقق من الدفع الكامل.',

              tone: AafiatakFeedbackTone.success,

              icon: Icons.credit_card_rounded,

              tag: currentAppointment.paymentStatusLabel,
            ),


            const SizedBox(
              height: AafiatakSpacing.space16,
            ),


            AafiatakCard(
              child: AafiatakInfoRows(
                rows: [

                  InfoRowItem(
                    label: 'المبلغ',
                    value: currentAppointment.amount,
                  ),

                  InfoRowItem(
                    label: 'مرجع الدفع',
                    value: currentAppointment.paymentReference,
                    isLtr: true,
                  ),
                ],
              ),
            ),


            const SizedBox(
              height: AafiatakSpacing.space20,
            ),


            AafiatakStatusBlock(
              title: 'حالة الزيارة',

              message: 'لم يبدأ تسجيل الوصول بعد.',

              tone: AafiatakFeedbackTone.info,

              icon: Icons.schedule_rounded,

              tag: currentAppointment.visitStatusLabel,
            ),


            const SizedBox(
              height: AafiatakSpacing.space16,
            ),
          ],
        ),
      ),
    );
  }
}