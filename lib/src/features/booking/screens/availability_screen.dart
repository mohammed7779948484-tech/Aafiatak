import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({
    super.key,
    required this.onReviewTap,
  });

  final ValueChanged<AvailabilityDayMock> onReviewTap;

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  int _selectedDayIndex = 4;

  void _selectDay(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDay = BookingMockData.availableDays[_selectedDayIndex];

    return PatientShell.detail(
      title: 'اختر اليوم',
      screenId: 'PAT-06',
      scrollable: true,
      bottomAction: AafiatakButton.primary(
        label: 'مراجعة الحجز',
        fullWidth: true,
        onPressed: () => widget.onReviewTap(selectedDay),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AafiatakSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppointmentSummary(
              service: BookingMockData.service,
              doctor: BookingMockData.doctor,
              facility: BookingMockData.facility,
              branch: BookingMockData.branch,
              date: selectedDay.fullDate,
              arrivalWindow: BookingMockData.arrivalWindow,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AafiatakSectionHeading(
                    label: 'اختر اليوم',
                    meta: 'سبتمبر 2026',
                  ),
                  const SizedBox(height: AafiatakSpacing.space12),
                  Wrap(
                    spacing: AafiatakSpacing.space8,
                    runSpacing: AafiatakSpacing.space8,
                    children: [
                      for (int index = 0;
                          index < BookingMockData.availableDays.length;
                          index++)
                        ChoiceChip(
                          selected: index == _selectedDayIndex,
                          onSelected: (_) => _selectDay(index),
                          label: Text(
                            '${BookingMockData.availableDays[index].dayName}\n'
                            '${BookingMockData.availableDays[index].dayNumber}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            const ArrivalWindowCard(
              title: 'نافذة الوصول',
              arrivalWindow: BookingMockData.arrivalWindow,
              note: 'نافذة الوصول ليست وقت دخول مضمونًا للطبيب.',
            ),
          ],
        ),
      ),
    );
  }
}
