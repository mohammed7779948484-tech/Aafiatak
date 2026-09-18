/// بيانات الاكتشاف الوهمية المشتركة بين شاشات discovery (قيم canonical).
library;

class Doctor {
  const Doctor({
    required this.name,
    required this.specialty,
    required this.price,
    required this.avatarText,
  });

  final String name;
  final String specialty;
  final String price;
  final String avatarText;
}

class ServiceItem {
  const ServiceItem({
    required this.title,
    required this.price,
    required this.paymentPolicy,
    required this.serviceText,
  });

  final String title;
  final String price;
  final String paymentPolicy;
  final String serviceText;
}

class UpcomingAppointment {
  const UpcomingAppointment({
    required this.doctorName,
    required this.serviceName,
    required this.date,
    required this.arrivalWindow,
  });

  final String doctorName;
  final String serviceName;
  final String date;
  final String arrivalWindow;
}

const Doctor doctor1 = Doctor(
  name: 'د. سارة عبدالله',
  specialty: 'طب الأسرة',
  price: '15,000 ر.ي',
  avatarText: 'س.ع',
);
const Doctor doctor2 = Doctor(
  name: 'د. محمد حسن',
  specialty: 'الطب العام',
  price: '12,000 ر.ي',
  avatarText: 'م.ح',
);
const ServiceItem serviceItem1 = ServiceItem(
  title: 'استشارة طب الأسرة',
  price: '15,000 ر.ي',
  paymentPolicy: 'الدفع الكامل إلكترونيًا',
  serviceText: 'خدمة',
);
const ServiceItem serviceItem2 = ServiceItem(
  title: 'متابعة طبية',
  price: '12,000 ر.ي',
  paymentPolicy: 'الدفع في المنشأة',
  serviceText: 'خدمة',
);
const UpcomingAppointment upcomingAppointment1 = UpcomingAppointment(
  doctorName: 'د. سارة عبدالله',
  serviceName: 'استشارة طب الأسرة',
  date: 'الجمعة 18 سبتمبر 2026',
  arrivalWindow: '10:00 – 10:30',
);

const List<Doctor> kDoctors = [doctor1, doctor2];
const List<ServiceItem> kServices = [serviceItem1, serviceItem2];
