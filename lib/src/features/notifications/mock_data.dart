/// بيانات الإشعارات الوهمية لميزة الإشعارات (قيم canonical).
library;

/// نوع الإشعار: يحدد أيقونة بلاطته ووجهة ضغطه في الشاشة.
enum NotificationKind { appointment, payment, visit }

/// إشعار واحد كما في المرجع: نوعه ونصوصه ووقته وحالة قراءته.
/// [unread] يحكم التدرج والحدود والنقطة والنص معًا، لا اللون وحده.
class AppNotification {
  const AppNotification({
    required this.kind,
    required this.title,
    required this.message,
    required this.time,
    required this.unread,
  });

  final NotificationKind kind;
  final String title;
  final String message;
  final String time;
  final bool unread;
}

const AppNotification notificationQueue = AppNotification(
  kind: NotificationKind.visit,
  title: 'تم النداء عليك',
  message: 'يرجى التوجه إلى غرفة الخدمة عند توجيه موظف الاستقبال.',
  time: 'اليوم · 12:04 م',
  unread: true,
);
const AppNotification notificationAppointment = AppNotification(
  kind: NotificationKind.appointment,
  title: 'تم تأكيد موعدك',
  message: 'موعدك مع د. سارة عبدالله مؤكد. نافذة الوصول 10:00 ص – 10:30 ص.',
  time: 'أمس · 7:32 م',
  unread: true,
);
const AppNotification notificationPayment = AppNotification(
  kind: NotificationKind.payment,
  title: 'تمت معالجة الدفع',
  message: 'تم التحقق من الدفع لموعد استشارة طب الأسرة.',
  time: 'أمس · 7:31 م',
  unread: false,
);

const List<AppNotification> kNotifications = [
  notificationQueue,
  notificationAppointment,
  notificationPayment,
];
