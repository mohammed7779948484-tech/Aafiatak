import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

/// Small development showcase for the shared theme and UI building blocks.
class StarterScreen extends StatefulWidget {
  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  PatientTab _currentTab = PatientTab.home;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell(
      root: true,
      onNotificationPressed: () {},
      activeTab: _currentTab,
      onTabSelected: (tab) => setState(() => _currentTab = tab),
      scrollable: true,
      body: Padding(
        padding: const EdgeInsets.all(AafiatakSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'الرعاية أقرب مما تتوقع',
              style: AafiatakTypography.bodySmall,
            ),
            const SizedBox(height: AafiatakSpacing.space4),
            const Text.rich(
              TextSpan(
                style: AafiatakTypography.displayLarge,
                children: <InlineSpan>[
                  TextSpan(text: 'ابدأ رحلتك الصحية '),
                  TextSpan(
                    text: 'بوضوح وطمأنينة.',
                    style: TextStyle(color: AafiatakColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            const Text(
              'واجهة عربية خفيفة ببيانات تجريبية واتجاه بصري برغندي أحادي اللون.',
              style: AafiatakTypography.bodyMedium,
            ),
            const SizedBox(height: AafiatakSpacing.space24),
            AafiatakTextField(
              controller: _searchController,
              hintText: 'ابحث عن طبيب أو تخصص أو خدمة',
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            AafiatakButton(
              label: 'احجز موعدًا الآن',
              icon: Icons.calendar_month_rounded,
              fullWidth: true,
              onPressed: () {},
            ),
            const _SectionGap(),
            const AafiatakSectionHeading(
              label: 'الحجز والوصول',
              meta: 'أنماط الحجز',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            const ReservationHoldBanner(countdown: '09:42'),
            const SizedBox(height: AafiatakSpacing.space12),
            const ArrivalWindowCard(
              title: 'نافذة الوصول المقترحة',
              arrivalWindow: '10:00 ص – 10:30 ص',
              note: 'يرجى الحضور في بداية النافذة لتأكيد الحضور وتجهيز الملف.',
            ),
            const _SectionGap(),
            const AafiatakSectionHeading(label: 'الطبيب والخدمة'),
            const SizedBox(height: AafiatakSpacing.space12),
            DoctorCard(
              name: 'د. سارة المنصوري',
              specialty: 'استشارية طب الأطفال وحديثي الولادة',
              avatarText: 'س.م',
              price: '15,000 ر.ي',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            ServiceCard(
              title: 'استشارة طب الأسرة',
              price: '15,000 ر.ي',
              policy: 'الدفع الكامل إلكترونيًا',
              badgeLabel: 'خدمة شائعة',
              onTap: () {},
            ),
            const _SectionGap(),
            const AafiatakSectionHeading(label: 'المنشأة والموعد'),
            const SizedBox(height: AafiatakSpacing.space12),
            FacilitySummary(
              facilityName: 'مستشفى الأمل التخصصي',
              branch: 'فرع حدة الرئيسي',
              location: 'صنعاء · شارع حدة، جوار بريد حدة',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            const AppointmentSummary(
              doctor: 'د. سارة المنصوري',
              service: 'استشارة طب الأطفال',
              facility: 'مستشفى الأمل التخصصي',
              branch: 'فرع حدة الرئيسي',
              date: 'الأربعاء، 18 سبتمبر 2026',
              arrivalWindow: '10:00 ص – 10:30 ص',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            const PolicyCard(
              title: 'سياسة الحضور وإلغاء المواعيد',
              items: <String>[
                'الحضور داخل نافذة الوصول ضروري لضمان عدم إلغاء الحجز.',
                'نافذة الوصول ليست وقت دخول مضمونًا للطبيب.',
              ],
            ),
            const _SectionGap(),
            const AafiatakSectionHeading(label: 'الحالات المهمة'),
            const SizedBox(height: AafiatakSpacing.space12),
            const AafiatakNotice(
              message: 'أنت غير متصل الآن. سنحدّث التوفر عند عودة الاتصال.',
              tone: AafiatakFeedbackTone.info,
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            const AafiatakStatusBlock(
              tone: AafiatakFeedbackTone.success,
              icon: Icons.check_circle_outline_rounded,
              title: 'تم تأكيد الحجز والدفع',
              message: 'تم إصدار رقم الحجز وحفظ الموعد في جدول مواعيدك.',
              tag: 'مكتمل',
            ),
            const _SectionGap(),
            const AafiatakSectionHeading(label: 'أزرار Material 3'),
            const SizedBox(height: AafiatakSpacing.space12),
            Wrap(
              spacing: AafiatakSpacing.space8,
              runSpacing: AafiatakSpacing.space8,
              children: <Widget>[
                AafiatakButton(label: 'أساسي', onPressed: () {}),
                AafiatakButton(
                  label: 'لوني',
                  variant: AafiatakButtonVariant.tonal,
                  onPressed: () {},
                ),
                AafiatakButton(
                  label: 'ثانوي',
                  variant: AafiatakButtonVariant.secondary,
                  onPressed: () {},
                ),
                AafiatakButton(
                  label: 'حذف',
                  variant: AafiatakButtonVariant.destructive,
                  onPressed: () {},
                ),
                AafiatakButton(
                  label: 'نصي',
                  variant: AafiatakButtonVariant.text,
                  onPressed: () {},
                ),
                const AafiatakButton(label: 'غير مفعّل', onPressed: null),
              ],
            ),
            const _SectionGap(),
            AafiatakEmptyState(
              title: 'لا توجد مواعيد سابقة',
              message: 'ستظهر المواعيد المكتملة في هذا السجل.',
              actionLabel: 'استكشف الخدمات',
              onAction: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space32),
          ],
        ),
      ),
    );
  }
}

class _SectionGap extends StatelessWidget {
  const _SectionGap();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: AafiatakSpacing.space24);
  }
}
