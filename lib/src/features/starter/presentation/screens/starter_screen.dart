import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

/// Interactive showcase and development landing screen demonstrating
/// the refactored Burgundy Monochrome design system and domain patterns.
class StarterScreen extends StatefulWidget {
  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  PatientTab _currentTab = PatientTab.home;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell(
      root: true,
      activeTab: _currentTab,
      onTabSelected: (tab) => setState(() => _currentTab = tab),
      scrollable: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AafiatakSpacing.space16,
          vertical: AafiatakSpacing.space16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Discovery Hero Header
            const Text(
              'الرعاية أقرب مما تتوقع',
              style: TextStyle(
                color: AafiatakColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space4),
            RichText(
              text: TextSpan(
                style: AafiatakTypography.display.copyWith(
                  color: AafiatakColors.textPrimary,
                ),
                children: const <InlineSpan>[
                  TextSpan(text: 'ابدأ رحلتك الصحية '),
                  TextSpan(
                    text: 'بوضوح وطمأنينة.',
                    style: TextStyle(color: AafiatakColors.brand),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            Text(
              'نظام التصميم عافيتك — أحادي اللون مع البرغندي، مخصص لتجربة مريض عربية متكاملة.',
              style: AafiatakTypography.bodyMedium.copyWith(
                color: AafiatakColors.textSecondary,
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Search input field
            AafiatakTextField(
              controller: _textController,
              hintText: 'ابحث عن طبيب أو تخصص أو قسم أو خدمة',
              prefixIcon: const Icon(
                Icons.search,
                color: AafiatakColors.textSecondary,
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space16),

            // Primary action button
            AafiatakButton(
              label: 'احجز موعدًا الآن',
              variant: AafiatakButtonVariant.primary,
              block: true,
              icon: Icons.calendar_month_rounded,
              onPressed: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Domain Patterns: Reservation Hold Banner
            const AafiatakSectionHeading(
              label: 'الحجز المؤقت ونافذة الوصول',
              meta: 'نماذج الحجز',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            const ReservationHoldBanner(
              title: 'تم حجز السعة لك مؤقتًا',
              countdown: '09:42',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            const ArrivalWindowCard(
              title: 'نافذة الوصول المقترحة',
              window: '10:00 ص – 10:30 ص',
              note: 'يرجى الحضور في بداية النافذة لتأكيد الحضور وتجهيز الملف.',
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Domain Patterns: Doctor Cards
            const AafiatakSectionHeading(
              label: 'الأطباء المتاحون',
              meta: 'عرض الكل',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            DoctorCard(
              name: 'د. سارة المنصوري',
              specialty: 'استشارية طب الأطفال وحديثي الولادة',
              price: '15,000 ر.ي',
              avatarText: 'س.م',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            DoctorCard(
              name: 'د. محمد حسن',
              specialty: 'الطب العام وجراحة الأسرة',
              price: '12,000 ر.ي',
              avatarText: 'م.ح',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Domain Patterns: Service Cards
            const AafiatakSectionHeading(
              label: 'خدمات شائعة',
              meta: 'اختيار سريع',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            ServiceCard(
              title: 'استشارة طب الأسرة',
              price: '15,000 ر.ي',
              policy: 'الدفع الكامل إلكترونيًا',
              badgeLabel: 'خدمة شائعة',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            ServiceCard(
              title: 'متابعة طبية دورية',
              price: '12,000 ر.ي',
              policy: 'الدفع في المنشأة عند الحضور',
              badgeLabel: 'متابعة',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Domain Patterns: Facility Summary
            const AafiatakSectionHeading(
              label: 'المنشأة الصحية',
              meta: 'تفاصيل الفرع',
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            FacilitySummary(
              name: 'مستشفى الأمل التخصصي',
              branch: 'فرع حدة الرئيسي',
              location: 'صنعاء · شارع حدة، جوار بريد حدة',
              onTap: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Domain Patterns: Appointment Summary
            const AafiatakSectionHeading(
              label: 'ملخص الموعد القادم',
              meta: 'حجز نشط',
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
            const SizedBox(height: AafiatakSpacing.space24),

            // Domain Patterns: Policy Card
            const PolicyCard(
              title: 'سياسة الحضور وإلغاء المواعيد',
              guidelines: <String>[
                'الحضور داخل نافذة الوصول ضروري لضمان عدم إلغاء الحجز.',
                'يمكنك إلغاء الموعد قبل ساعتين من موعد بدء النافذة دون أي رسوم.',
                'النافذة تمثل وقت الحضور للمنشأة وليست وقت الدخول الفعلي للطبيب.',
              ],
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Design System: Notices & Status
            const AafiatakSectionHeading(label: 'حالات الإشعار والملاحظات'),
            const SizedBox(height: AafiatakSpacing.space12),
            const AafiatakNotice(
              message: 'أنت غير متصل الآن. يمكنك تصفح آخر بيانات محفوظة وسنحدّث التوفر عند الاتصال.',
              tone: AafiatakFeedbackTone.info,
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            const AafiatakNotice(
              message: 'تم تأكيد موعدك بنجاح. أرسلنا تفاصيل الوصول إلى هاتفك.',
              tone: AafiatakFeedbackTone.success,
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            const AafiatakNotice(
              message: 'تعذر الاتصال بالخادم. يرجى التحقق من الشبكة وإعادة المحاولة.',
              tone: AafiatakFeedbackTone.error,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            const AafiatakStatusBlock(
              tone: AafiatakFeedbackTone.success,
              icon: Icons.check_circle_outline_rounded,
              title: 'تم تأكيد الحجز والدفع',
              copy: 'تم إصدار رقم الحجز وحفظ الموعد في جدول مواعيدك بنجاح.',
              tag: 'مكتمل',
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Design System: Badges
            const AafiatakSectionHeading(label: 'الشارات الدلالية'),
            const SizedBox(height: AafiatakSpacing.space12),
            const Wrap(
              spacing: AafiatakSpacing.space8,
              runSpacing: AafiatakSpacing.space8,
              children: <Widget>[
                AafiatakBadge(label: 'محايد', tone: AafiatakBadgeTone.neutral),
                AafiatakBadge(label: 'أساسي', tone: AafiatakBadgeTone.primary),
                AafiatakBadge(
                  label: 'ثانوي',
                  tone: AafiatakBadgeTone.secondary,
                ),
                AafiatakBadge(label: 'حجز مؤقت', tone: AafiatakBadgeTone.hold),
                AafiatakBadge(label: 'معلومات', tone: AafiatakBadgeTone.info),
                AafiatakBadge(label: 'تنبيه', tone: AafiatakBadgeTone.warning),
                AafiatakBadge(label: 'ملغي', tone: AafiatakBadgeTone.error),
                AafiatakBadge(label: 'مؤكد', tone: AafiatakBadgeTone.success),
              ],
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Design System: Buttons
            const AafiatakSectionHeading(label: 'أنماط الأزرار'),
            const SizedBox(height: AafiatakSpacing.space12),
            AafiatakButton(
              label: 'زر أساسي (Primary)',
              variant: AafiatakButtonVariant.primary,
              block: true,
              onPressed: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            AafiatakButton(
              label: 'زر لوني (Tonal)',
              variant: AafiatakButtonVariant.tonal,
              block: true,
              onPressed: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            AafiatakButton(
              label: 'زر ثانوي (Secondary)',
              variant: AafiatakButtonVariant.secondary,
              block: true,
              onPressed: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            AafiatakButton(
              label: 'زر نصي (Text)',
              variant: AafiatakButtonVariant.text,
              block: true,
              onPressed: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            const AafiatakButton(
              label: 'زر غير مفعّل (Disabled)',
              variant: AafiatakButtonVariant.primary,
              block: true,
              onPressed: null,
            ),
            const SizedBox(height: AafiatakSpacing.space24),

            // Empty State demo
            AafiatakEmptyState(
              title: 'لا توجد مواعيد سابقة',
              copy: 'عند حجز وإتمام مواعيدك الطبية ستظهر في هذا السجل.',
              actionLabel: 'استكشف الخدمات المتاحة',
              onAction: () {},
            ),
            const SizedBox(height: AafiatakSpacing.space32),
          ],
        ),
      ),
    );
  }
}
