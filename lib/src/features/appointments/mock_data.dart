class AppointmentMock {
  const AppointmentMock({
    required this.id,
    required this.referenceNumber,
    required this.doctorName,
    required this.facilityName,
    required this.branchName,
    required this.serviceName,
    required this.date,
    required this.time,
    required this.statusLabel,

    required this.amount,
    required this.paymentReference,
    required this.paymentStatusLabel,
    required this.visitStatusLabel,
  });

  final String id;
  final String referenceNumber;

  final String doctorName;
  final String facilityName;
  final String branchName;
  final String serviceName;

  final String date;
  final String time;

  final String statusLabel;

  final String amount;
  final String paymentReference;
  final String paymentStatusLabel;
  final String visitStatusLabel;
}

abstract final class AppointmentsMockData {
  static const List<AppointmentMock> upcomingAppointments = [
    AppointmentMock(
      id: 'apt-af-28931',

      referenceNumber: 'AF-28931',

      doctorName: 'د. سارة عبدالله',

      facilityName: 'مركز عافيتك التخصصي',

      branchName: 'فرع التحرير',

      serviceName: 'استشارة طب الأسرة',

      date: 'الجمعة 18 سبتمبر 2026',

      time: '10:00 – 10:30',

      statusLabel: 'مؤكد',

      amount: '15,000 ر.ي',

      paymentReference: 'PAY-2026-1847',

      paymentStatusLabel: 'مدفوع',

      visitStatusLabel: 'قبل الوصول',
    ),
  ];
}
