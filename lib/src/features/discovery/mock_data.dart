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
    required this.id,
    required this.title,
    required this.price,
    required this.paymentPolicy,
    required this.serviceText,
    required this.estimatedDuration,
  });

  final String id;
  final String title;
  final String price;
  final String paymentPolicy;
  final String serviceText;
  final String estimatedDuration;
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

/// تصنيف نتيجة البحث: يحدد شارة الصف ووجهة ضغطه في الشاشة.
enum SearchKind { doctor, service, facility }

/// صف نتيجة بحث واحد كما في المرجع: معرّفه القانوني، نوعه، وعنواناه.
/// المعرّف لا يُعرض؛ تمرره الشاشة إلى الـ callback المطابق للنوع.
class SearchResult {
  const SearchResult({
    required this.id,
    required this.kind,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final SearchKind kind;
  final String title;
  final String subtitle;
}

/// التفاصيل المهنية الكاملة لطبيب: تكمّل [Doctor] المختصر المعروض
/// في البطاقات. [doctorId] يربطها بمعرّفها القانوني في العقد العام.
class DoctorDetails {
  const DoctorDetails({
    required this.doctorId,
    required this.department,
    required this.qualification,
    required this.bio,
    required this.workingDays,
    required this.workingHours,
  });

  final String doctorId;
  final String department;
  final String qualification;
  final String bio;
  final String workingDays;
  final String workingHours;
}

/// منشأة صحية قانونية: تظهر مجملة في الملخصات، وتفصيلها الكامل
/// في شاشة المنشأة (PAT-05).
class Facility {
  const Facility({
    required this.id,
    required this.name,
    required this.branch,
    required this.city,
    required this.region,
    required this.location,
    required this.address,
    required this.phone,
    required this.hours,
  });

  final String id;
  final String name;
  final String branch;
  final String city;
  final String region;
  final String location;
  final String address;
  final String phone;
  final String hours;
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
  id: 'svc-family-consult',
  title: 'استشارة طب الأسرة',
  price: '15,000 ر.ي',
  paymentPolicy: 'الدفع الكامل إلكترونيًا',
  serviceText: 'خدمة',
  estimatedDuration: '30 دقيقة تقريبًا',
);
const ServiceItem serviceItem2 = ServiceItem(
  id: 'svc-follow-up',
  title: 'متابعة طبية',
  price: '12,000 ر.ي',
  paymentPolicy: 'الدفع في المنشأة',
  serviceText: 'خدمة',
  estimatedDuration: '20 دقيقة تقريبًا',
);
const UpcomingAppointment upcomingAppointment1 = UpcomingAppointment(
  doctorName: 'د. سارة عبدالله',
  serviceName: 'استشارة طب الأسرة',
  date: 'الجمعة 18 سبتمبر 2026',
  arrivalWindow: '10:00 – 10:30',
);

const SearchResult searchResult1 = SearchResult(
  id: 'doc-001',
  kind: SearchKind.doctor,
  title: 'د. سارة عبدالله',
  subtitle: 'طب الأسرة · مركز عافيتك التخصصي',
);
const SearchResult searchResult2 = SearchResult(
  id: 'svc-family-consult',
  kind: SearchKind.service,
  title: 'استشارة طب الأسرة',
  subtitle: '15,000 ر.ي · الدفع الكامل إلكترونيًا',
);
const SearchResult searchResult3 = SearchResult(
  id: 'fac-aafiatak-tahrir',
  kind: SearchKind.facility,
  title: 'مركز عافيتك التخصصي · فرع التحرير',
  subtitle: 'صنعاء · شارع التحرير',
);

/// الاستعلام الوهمي الثابت المعروض في حقل البحث بوصفة results.
const String kSearchQuery = 'طب الأسرة';

const DoctorDetails doctorDetails1 = DoctorDetails(
  doctorId: 'doc-001',
  department: 'الرعاية الأولية',
  qualification: 'زمالة في طب الأسرة',
  bio:
      'تهتم بتقديم رعاية واضحة ومتكاملة للبالغين، مع التركيز على الوقاية '
      'والمتابعة وتفسير الخطة للمريض بلغة بسيطة.',
  workingDays: 'الأحد – الخميس',
  workingHours: '9:00 ص – 4:00 م',
);
const Facility facility1 = Facility(
  id: 'fac-aafiatak-tahrir',
  name: 'مركز عافيتك التخصصي',
  branch: 'فرع التحرير',
  city: 'صنعاء',
  region: 'أمانة العاصمة',
  location: 'صنعاء · شارع التحرير',
  address: 'شارع التحرير، بجوار الساحة العامة',
  phone: '+967 ••• ••• •••',
  hours: 'الأحد – الخميس · 8:00 ص – 5:00 م',
);

const List<Doctor> kDoctors = [doctor1, doctor2];
const List<ServiceItem> kServices = [serviceItem1, serviceItem2];
const List<SearchResult> kSearchResults = [
  searchResult1,
  searchResult2,
  searchResult3,
];
