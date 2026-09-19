import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:flutter/material.dart';

import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';
import '../widgets/appointment_list_card.dart';


class AppointmentsScreen  extends StatelessWidget {
  const AppointmentsScreen ({
    super.key,

    required this.onAppointmentTap,
    required this.onNotificationsTap,
    required this.onTabSelected,

    });

    final ValueChanged<String> onAppointmentTap;
    final VoidCallback onNotificationsTap;
    final ValueChanged<PatientTab> onTabSelected;





  @override
  Widget build(BuildContext context) {
    final appointments =
        AppointmentsMockData.upcomingAppointments;
    return PatientShell.root(
      // التبويبه الموجودين فيها حاليا وتفعيل زر الاشعارات
        title: "مواعدي",
        activeTab: PatientTab.appointments,
        onTabSelected: onTabSelected,
        onNotificationPressed: onNotificationsTap,

        body:

        ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context , Index){
              final appointment = appointments[Index];

              return AppointmentListCard(
                  appointment: appointment,
                  onTap: (){
                    onAppointmentTap(appointment.id);
                  });
            }
        )
    );
  }
}
