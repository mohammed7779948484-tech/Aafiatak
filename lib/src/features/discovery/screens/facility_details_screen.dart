import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/discovery/mock_data.dart';
import 'package:flutter/material.dart';

/// شاشة «تفاصيل المنشأة والفرع»: هوية وعنوان ومعاينة موقع محايدة
/// وتواصل وساعات وأطباء وخدمات وملاحظة سعة. بلا شريط سفلي.
class FacilityDetailsScreen extends StatelessWidget {
  const FacilityDetailsScreen({
    super.key,
    required this.facilityId,
    required this.onDoctorRequested,
    required this.onServiceRequested,
    required this.onShowLocationRequested,
    required this.onCallRequested,
    required this.onBackPressed,
  });

  final String facilityId;
  final ValueChanged<String> onDoctorRequested;
  final ValueChanged<String> onServiceRequested;
  final VoidCallback onShowLocationRequested;
  final VoidCallback onCallRequested;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'تفاصيل المنشأة والفرع',
      screenId: 'PAT-05',
      onBackPressed: onBackPressed,
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
          spacing: AafiatakSpacing.space16,
          children: [
            const _FacilityIdentity(facility: facility1),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AafiatakSpacing.space12,
                children: [
                  const AafiatakSectionHeading(label: 'العنوان'),
                  Text(facility1.address, style: AafiatakTypography.body),
                ],
              ),
            ),
            const _LocationPreview(),
            AafiatakButton.secondary(
              label: 'عرض الموقع',
              icon: Icons.location_on_outlined,
              onPressed: onShowLocationRequested,
              fullWidth: true,
            ),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AafiatakSpacing.space12,
                children: [
                  const AafiatakSectionHeading(label: 'التواصل وساعات العمل'),
                  AafiatakInfoRows(
                    rows: [
                      InfoRowItem(
                        label: 'رقم التواصل',
                        value: facility1.phone,
                        isLtr: true,
                      ),
                      InfoRowItem(label: 'ساعات العمل', value: facility1.hours),
                    ],
                  ),
                  AafiatakButton.text(
                    label: 'اتصال',
                    icon: Icons.phone_outlined,
                    onPressed: onCallRequested,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AafiatakSpacing.space12,
              children: [
                const AafiatakSectionHeading(label: 'أطباء في هذا الفرع'),
                DoctorCard(
                  name: doctor1.name,
                  specialty: doctor1.specialty,
                  avatarText: doctor1.avatarText,
                  price: doctor1.price,
                  onTap: () => onDoctorRequested('doc-001'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AafiatakSpacing.space12,
              children: [
                const AafiatakSectionHeading(label: 'خدمات متاحة'),
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
            const AafiatakNotice(
              message:
                  'المواعيد المعروضة هي السعة المنشورة في عافيتك '
                  'وليست كامل جدول المنشأة.',
              tone: AafiatakFeedbackTone.info,
            ),
          ],
        ),
      ),
    );
  }
}

/// هوية المنشأة: شارة الفرع ثم الاسم الكبير وسطر المدينة والمنطقة.
class _FacilityIdentity extends StatelessWidget {
  const _FacilityIdentity({required this.facility});

  final Facility facility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AafiatakSpacing.space8,
      children: [
        AafiatakBadge(label: facility.branch, tone: AafiatakFeedbackTone.info),
        Text(
          facility.name,
          style: AafiatakTypography.h2.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          '${facility.city} · ${facility.region}',
          style: AafiatakTypography.bodySmall,
        ),
      ],
    );
  }
}

/// معاينة موقع محايدة: تدرج رمادي-بورجوندي خافق ودبوس بورجوندي
/// وشرح سفلي — بلا أي SDK خرائط، كما تفرض قواعد المشروع.
class _LocationPreview extends StatelessWidget {
  const _LocationPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x091A1A1A), Color(0x0D800020)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AafiatakColors.borderSubtle),
        borderRadius: AafiatakRadii.large,
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: Icon(
                Icons.location_on_outlined,
                size: 42,
                color: AafiatakColors.primary,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: AafiatakSpacing.space12,
            start: AafiatakSpacing.space12,
            end: AafiatakSpacing.space12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AafiatakSpacing.space8,
                horizontal: AafiatakSpacing.space12,
              ),
              decoration: const BoxDecoration(
                color: Color(0xEBFFFFFF),
                borderRadius: AafiatakRadii.medium,
              ),
              child: Text(
                'معاينة موقع المنشأة',
                style: AafiatakTypography.caption.copyWith(
                  color: AafiatakColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
