/// بيانات العرض المحلية لميزة الحجز في عافيتك.
///
/// القيم Canonical متوافقة مع عقد Mock Data في الخطة الرئيسية: د. سارة
/// عبدالله، مركز عافيتك التخصصي فرع التحرير، استشارة طب الأسرة بـ15,000 ر.ي،
/// والموعد الجمعة 18 سبتمبر 2026 بنافذة وصول 10:00 – 10:30. قيمة
/// [holdCountdown] عرض ثابت للعد التنازلي وليست سياسة منتج.
abstract final class BookingMockData {
  const BookingMockData._();

  static const String service = 'استشارة طب الأسرة';
  static const String doctor = 'د. سارة عبدالله';
  static const String facility = 'مركز عافيتك التخصصي';
  static const String branch = 'فرع التحرير';
  static const String date = 'الجمعة 18 سبتمبر 2026';
  static const String arrivalWindow = '10:00 – 10:30';
  static const String amount = '15,000 ر.ي';
  static const String holdCountdown = '09:42';
  static const String paymentPolicyLabel = 'دفع كامل';
}
