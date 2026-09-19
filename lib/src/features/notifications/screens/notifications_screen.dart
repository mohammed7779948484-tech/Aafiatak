import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/notifications/mock_data.dart';
import 'package:aafiatak/src/features/notifications/widgets/notification_tile.dart';
import 'package:flutter/material.dart';

/// شاشة «مركز الإشعارات»: قائمة تملك تمريرها بنفسها (ListView بلا
/// scrollable في الشل) وتوجه كل ضغطة حسب نوع الإشعار.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
    required this.onAppointmentSelected,
    required this.onPaymentSelected,
    required this.onVisitSelected,
    required this.onBackPressed,
  });

  final VoidCallback onAppointmentSelected;
  final VoidCallback onPaymentSelected;
  final VoidCallback onVisitSelected;
  final VoidCallback onBackPressed;

  /// يوجه ضغطة الإشعار إلى الـ callback المطابق لنوعه.
  void _openNotification(AppNotification notification) {
    switch (notification.kind) {
      case NotificationKind.appointment:
        onAppointmentSelected();
      case NotificationKind.payment:
        onPaymentSelected();
      case NotificationKind.visit:
        onVisitSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'الإشعارات',
      screenId: 'PAT-15',
      onBackPressed: onBackPressed,
      body: ListView.separated(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          start: 16,
          end: 16,
          bottom: 32,
        ),
        itemCount: kNotifications.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AafiatakSpacing.space8),
        itemBuilder: (context, index) => NotificationTile(
          notification: kNotifications[index],
          onTap: () => _openNotification(kNotifications[index]),
        ),
      ),
    );
  }
}
