class AvailabilityDayMock {
  const AvailabilityDayMock({
    required this.dayName,
    required this.dayNumber,
    required this.fullDate,
  });

  final String dayName;
  final int dayNumber;
  final String fullDate;
}


abstract final class BookingMockData {
  const BookingMockData._();

  static const String service = 'استشارة طب الأسرة';

  static const String doctor = 'د. سارة عبدالله';

  static const String facility = 'مركز عافيتك التخصصي';

  static const String branch = 'فرع التحرير';

  static const String arrivalWindow = '10:00 – 10:30';

  static const String amount = '15,000 ر.ي';

  static const String holdCountdown = '09:42';

  static const String paymentPolicyLabel = 'دفع كامل';


  static const List<AvailabilityDayMock> availableDays = [
    AvailabilityDayMock(
      dayName: 'الاثنين',
      dayNumber: 14,
      fullDate: 'الاثنين 14 سبتمبر 2026',
    ),

    AvailabilityDayMock(
      dayName: 'الثلاثاء',
      dayNumber: 15,
      fullDate: 'الثلاثاء 15 سبتمبر 2026',
    ),

    AvailabilityDayMock(
      dayName: 'الأربعاء',
      dayNumber: 16,
      fullDate: 'الأربعاء 16 سبتمبر 2026',
    ),

    AvailabilityDayMock(
      dayName: 'الخميس',
      dayNumber: 17,
      fullDate: 'الخميس 17 سبتمبر 2026',
    ),

    AvailabilityDayMock(
      dayName: 'الجمعة',
      dayNumber: 18,
      fullDate: 'الجمعة 18 سبتمبر 2026',
    ),

    AvailabilityDayMock(
      dayName: 'السبت',
      dayNumber: 19,
      fullDate: 'السبت 19 سبتمبر 2026',
    ),

    AvailabilityDayMock(
      dayName: 'الأحد',
      dayNumber: 20,
      fullDate: 'الأحد 20 سبتمبر 2026',
    ),
  ];
}