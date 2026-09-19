/// بيانات الملف الشخصي الوهمية لميزة البروفايل (قيم canonical).
library;

/// ملف المريض الأساسي: هوية الخطة القانونية وأحرف أفاتاره وهاتفه المقنّع.
class PatientProfile {
  const PatientProfile({
    required this.id,
    required this.name,
    required this.avatarText,
    required this.maskedPhone,
    required this.profileNote,
  });

  final String id;
  final String name;
  final String avatarText;
  final String maskedPhone;
  final String profileNote;
}

const PatientProfile patientProfile1 = PatientProfile(
  id: 'pat-001',
  name: 'أحمد بلال',
  avatarText: 'أب',
  maskedPhone: '+[رمز الدولة] ••• ••15',
  profileNote: 'ملف مريض أساسي',
);
