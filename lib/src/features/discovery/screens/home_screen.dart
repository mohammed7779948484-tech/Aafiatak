import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/features/discovery/widgets/availability_feature_panel.dart';
import 'package:aafiatak/src/features/discovery/widgets/home_hero.dart';
import 'package:aafiatak/src/features/discovery/widgets/quick_actions.dart';
import 'package:aafiatak/src/features/discovery/widgets/upcoming_appointment_section.dart';
import 'package:flutter/material.dart';

import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/discovery/mock_data.dart';

/// جمهور الشاشة: مريض مسجّل يرى قسم موعده القادم، أو زائر لا يراه.

enum HomeAudience { patient, guest }

/// شاشة «الرئيسية / اكتشف»: تجمع البحث والاختصارات والموعد القادم
/// واللوحة التعريفية وقائمتي الأطباء والخدمات. لا تعرف شيئًا عن
/// المسارات؛ تُمرر كل نوايا التنقل إلى وليّها عبر callbacks.

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.audience, // ← سر حالتَي PAT-01
    required this.onSearchRequested, // ← حقل البحث وبلاطة «الأطباء»
    required this.onBookRequested, // ← الزر «احجز موعدًا»
    required this.onAvailabilityRequested, // ← زر اللوحة «استكشف التوفر»
    required this.onServiceRequested, // ← بلاطة «الخدمات» — قائمة بلا حمل
    required this.onFacilityRequested, // ← بلاطة «المنشآت»
    required this.onDoctorSelected, // ← بطاقة طبيب — تحمل Doctor
    required this.onServiceSelected, // ← بطاقة خدمة — تحمل ServiceItem
    required this.onViewAppointmentDetails, // ← زر «عرض تفاصيل الموعد»
    required this.onNotificationPressed, // ← جرس الشريط
    required this.onTabSelected, // ← شريط التنقل السفلي
  });

  final HomeAudience audience;
  final VoidCallback onSearchRequested;
  final VoidCallback onBookRequested;
  final VoidCallback onAvailabilityRequested;
  final VoidCallback onServiceRequested;
  final VoidCallback onFacilityRequested;
  final VoidCallback onViewAppointmentDetails;
  final VoidCallback onNotificationPressed;
  final ValueChanged<Doctor> onDoctorSelected;
  final ValueChanged<ServiceItem> onServiceSelected;
  final ValueChanged<PatientTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PatientShell.root(
      activeTab: PatientTab.home,
      onTabSelected: onTabSelected,
      onNotificationPressed: onNotificationPressed,
      scrollable: true,
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          start: 16,
          end: 16,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AafiatakSpacing.space24,
          children: [
            const HomeHero(),
            AafiatakSearchField(
              hintText: 'ابحث عن طبيب أو تخصص أو قسم أو خدمة',
              onSubmitted: (_) => onSearchRequested(),
            ),
            AafiatakButton.primary(
              label: 'احجز موعدًا',
              fullWidth: true,
              onPressed: onBookRequested,
            ),
            QuickActions(
              onSearchRequested: onSearchRequested,
              onServiceRequested: onServiceRequested,
              onFacilityRequested: onFacilityRequested,
            ),

            if (audience == HomeAudience.patient)
              UpcomingAppointmentSection(
                appointment: upcomingAppointment1,
                onViewDetailsRequested: onViewAppointmentDetails,
              ),
            AvailabilityFeaturePanel(
              onAvailabilityRequested: onAvailabilityRequested,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AafiatakSpacing.space12,
              children: [
                const AafiatakSectionHeading(label: 'اكتشف الأطباء'),
                for (final doctor in kDoctors)
                  DoctorCard(
                    name: doctor.name,
                    specialty: doctor.specialty,
                    avatarText: doctor.avatarText,
                    price: doctor.price,
                    onTap: () => onDoctorSelected(doctor),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AafiatakSpacing.space12,
              children: [
                const AafiatakSectionHeading(
                  label: 'خدمات شائعة',
                  meta: 'اختيار سريع',
                ),
                for (final item in kServices)
                  ServiceCard(
                    title: item.title,
                    price: item.price,
                    policy: item.paymentPolicy,
                    badgeLabel: item.serviceText,
                    onTap: () => onServiceSelected(item),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
