import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/discovery/mock_data.dart';
import 'package:flutter/material.dart';

/// شاشة «تفاصيل الخدمة»: ترويسة ولوحة سعر وثلاث بطاقات سياسات
/// ومدة تقديرية وملخص المنشأة. تُمرر نوايا التنقل عبر callbacks.
class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({
    super.key,
    required this.serviceId,
    required this.onFacilityRequested,
    required this.onAvailabilityRequested,
    required this.onBackPressed,
  });

  final String serviceId;
  final ValueChanged<String> onFacilityRequested;
  final VoidCallback onAvailabilityRequested;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'تفاصيل الخدمة',
      screenId: 'PAT-04',
      onBackPressed: onBackPressed,
      scrollable: true,
      bottomAction: AafiatakButton.primary(
        label: 'عرض التوفر',
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
            const _ServiceHero(service: serviceItem1),
            const _ServicePricePanel(service: serviceItem1),
            const PolicyCard(
              title: 'الإلغاء والاسترداد',
              items: [
                'يمكن الإلغاء ضمن الشروط المحفوظة للموعد. إذا كان الإلغاء '
                    'مؤهلًا للاسترداد فستظهر حالته بشكل مستقل عن حالة الموعد.',
              ],
            ),
            const PolicyCard(
              title: 'عدم الحضور',
              items: [
                'تُطبق سياسة عدم الحضور الخاصة بهذه الخدمة إذا انتهت نافذة '
                    'الوصول دون تسجيل وصول صالح.',
              ],
            ),
            const PolicyCard(
              title: 'تعليمات الحضور',
              items: [
                'احضر ضمن نافذة الوصول التي سيعرضها النظام عند اختيار اليوم.',
                'نافذة الوصول ليست وقت دخول مضمونًا للطبيب.',
              ],
            ),
            const _EstimatedDuration(service: serviceItem1),
            FacilitySummary(
              facilityName: facility1.name,
              location: facility1.location,
              branch: facility1.branch,
              onTap: () => onFacilityRequested(facility1.id),
            ),
          ],
        ),
      ),
    );
  }
}

/// ترويسة الخدمة: شارة التخصص ثم العنوان الكبير وسطر الطبيب والمنشأة.
class _ServiceHero extends StatelessWidget {
  const _ServiceHero({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AafiatakSpacing.space12,
      children: [
        AafiatakBadge(
          label: doctor1.specialty,
          tone: AafiatakFeedbackTone.secondary,
        ),
        Text(
          service.title,
          style: AafiatakTypography.h1.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          '${doctor1.name} · ${facility1.name}',
          style: AafiatakTypography.bodySmall,
        ),
      ],
    );
  }
}

/// لوحة السعر: حاوية بورجوندي فاتح بحدود شفافة، وسعر كبير معزول
/// LTR، وشارة الدفع الإلزامي، وملاحظة توضيحية.
class _ServicePricePanel extends StatelessWidget {
  const _ServicePricePanel({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AafiatakSpacing.space16),
      decoration: BoxDecoration(
        color: AafiatakColors.primaryContainer,
        border: Border.all(color: const Color(0x14800020)),
        borderRadius: AafiatakRadii.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AafiatakSpacing.space8,
        children: [
          const Text('السعر لهذه الخدمة', style: AafiatakTypography.caption),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              service.price,
              style: AafiatakTypography.h2.copyWith(
                color: AafiatakColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 30,
                height: 38 / 30,
              ),
            ),
          ),
          const AafiatakBadge(
            label: 'الدفع الكامل إلكترونيًا مطلوب',
            tone: AafiatakFeedbackTone.warning,
          ),
          const Text(
            'سياسة الدفع معروضة للمعلومة فقط ولا يمكن للمريض تغييرها.',
            style: AafiatakTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

/// بطاقة «مدة الخدمة»: قيمة تقديرية كبيرة وملاحظة إلزامية تحتها.
class _EstimatedDuration extends StatelessWidget {
  const _EstimatedDuration({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AafiatakSpacing.space12,
        children: [
          const AafiatakSectionHeading(
            label: 'مدة الخدمة',
            meta: 'معلومة تقديرية',
          ),
          Text(service.estimatedDuration, style: AafiatakTypography.bodyLarge),
          const Text(
            'مدة تقديرية للخدمة وليست وقت دخول مضمونًا.',
            style: AafiatakTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}
