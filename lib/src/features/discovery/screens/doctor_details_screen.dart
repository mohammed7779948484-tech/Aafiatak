import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/discovery/mock_data.dart';
import 'package:flutter/material.dart';

/// شاشة «تفاصيل الطبيب»: رأس مهني ونبذة ومنشأة وخدمات وساعات عمل.
/// تصلها هوية الطبيب وتُمرر نوايا التنقل عبر callbacks بلا مسارات.
class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({
    super.key,
    required this.doctorId,
    required this.onFacilityRequested,
    required this.onServiceRequested,
    required this.onAvailabilityRequested,
    required this.onBackPressed,
  });

  final String doctorId;
  final ValueChanged<String> onFacilityRequested;
  final ValueChanged<String> onServiceRequested;
  final VoidCallback onAvailabilityRequested;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'تفاصيل الطبيب',
      screenId: 'PAT-03',
      onBackPressed: onBackPressed,
      scrollable: true,
      bottomAction: AafiatakButton.primary(
        label: 'عرض المواعيد المتاحة',
        icon: Icons.calendar_month_rounded,
        onPressed: onAvailabilityRequested,
        fullWidth: true,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          start: 16,
          end: 16,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AafiatakSpacing.space16,
          children: [
            _DoctorProfileHeader(
              doctor: doctor1,
              department: doctorDetails1.department,
            ),
            const _ProfessionalBio(details: doctorDetails1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AafiatakSpacing.space12,
              children: [
                const AafiatakSectionHeading(label: 'المنشأة والفرع'),
                FacilitySummary(
                  facilityName: facility1.name,
                  location: facility1.location,
                  branch: facility1.branch,
                  onTap: () => onFacilityRequested(facility1.id),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AafiatakSpacing.space12,
              children: [
                const AafiatakSectionHeading(
                  label: 'الخدمات',
                  meta: 'في هذا الفرع',
                ),
                for (final item in kServices)
                  ServiceCard(
                    title: item.title,
                    price: item.price,
                    policy: item.paymentPolicy,
                    badgeLabel: item.serviceText,
                    onTap: () => onServiceRequested(item.id),
                  ),
              ],
            ),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AafiatakSpacing.space12,
                children: [
                  const AafiatakSectionHeading(
                    label: 'أيام وساعات العمل',
                    meta: 'معلومات عامة',
                  ),
                  AafiatakInfoRows(
                    rows: [
                      InfoRowItem(
                        label: 'الأيام',
                        value: doctorDetails1.workingDays,
                      ),
                      InfoRowItem(
                        label: 'الساعات',
                        value: doctorDetails1.workingHours,
                        isLtr: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// رأس شاشة الطبيب: أفاتار كبير بأحرفه والتخصص فوق الاسم والقسم.
class _DoctorProfileHeader extends StatelessWidget {
  const _DoctorProfileHeader({required this.doctor, required this.department});

  final Doctor doctor;
  final String department;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AafiatakColors.primaryContainer,
            borderRadius: AafiatakRadii.extraLarge,
            border: Border.all(color: AafiatakColors.primaryBorderFaint),
          ),
          alignment: Alignment.center,
          child: Text(
            doctor.avatarText,
            style: AafiatakTypography.labelLarge.copyWith(
              color: AafiatakColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(width: AafiatakSpacing.space16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                doctor.specialty,
                style: AafiatakTypography.label.copyWith(
                  color: AafiatakColors.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                doctor.name,
                style: AafiatakTypography.h2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(department, style: AafiatakTypography.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

/// بطاقة «نبذة مهنية»: المؤهل سطر رمادي تمهيدي ثم نص السيرة الكامل.
class _ProfessionalBio extends StatelessWidget {
  const _ProfessionalBio({required this.details});

  final DoctorDetails details;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AafiatakSpacing.space12,
        children: [
          const AafiatakSectionHeading(label: 'نبذة مهنية'),
          Text(details.qualification, style: AafiatakTypography.bodySmall),
          Text(
            details.bio,
            style: AafiatakTypography.body.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
