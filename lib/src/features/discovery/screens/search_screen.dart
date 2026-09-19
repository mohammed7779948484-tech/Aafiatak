import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/discovery/mock_data.dart';
import 'package:flutter/material.dart';

/// شاشة «البحث والنتائج»: حقل بحث وشرائح تصفية وملخص وثلاث نتائج.
/// لا تملك حالة ولا مسارات؛ كل نقر يمرر معرّف النتيجة عبر callbacks.

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.onDoctorSelected, // ← يحمّل معرف الطبيب مثل: 'doc-001'
    required this.onServiceSelected, // ← يحمّل معرف الخدمة
    required this.onFacilitySelected, // ← يحمّل معرف المنشأة
    required this.onBackPressed,
  });
  final ValueChanged<String> onDoctorSelected;
  final ValueChanged<String> onServiceSelected;
  final ValueChanged<String> onFacilitySelected;
  final VoidCallback onBackPressed;

  /// يوجه ضغطة النتيجة إلى الـ callback المطابق لنوعها حاملًا معرّفها.
  void _openResult(SearchResult result) {
    switch (result.kind) {
      case SearchKind.doctor:
        onDoctorSelected(result.id);
      case SearchKind.service:
        onServiceSelected(result.id);
      case SearchKind.facility:
        onFacilitySelected(result.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'البحث والنتائج',
      screenId: 'PAT-02',
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
            AafiatakSearchField(hintText: kSearchQuery, onSubmitted: (_) {}),
            const _SearchFilters(),
            const _SearchSummary(),
            for (final result in kSearchResults)
              _SearchResultTile(
                result: result,
                onTap: () => _openResult(result),
              ),
          ],
        ),
      ),
    );
  }
}

/// شرائح التصفية الأربع كما في المرجع: «الكل» نشطة والبقية عرض ثابت —
/// الشاشة Stateless بلا منطق تصفية.

class _SearchFilters extends StatelessWidget {
  const _SearchFilters();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AafiatakSpacing.space8,
      children: [
        ChoiceChip(
          label: const Text('الكل'),
          selected: true,
          onSelected: (_) {},
        ),
        ChoiceChip(
          label: const Text('أطباء'),
          selected: false,
          onSelected: (_) {},
        ),
        ChoiceChip(
          label: const Text('خدمات'),
          selected: false,
          onSelected: (_) {},
        ),
        ChoiceChip(
          label: const Text('منشآت'),
          selected: false,
          onSelected: (_) {},
        ),
      ],
    );
  }
}

/// سطر الملخص: عنوان «النتائج» وعددها محسوبًا من طول قائمة البيانات.

class _SearchSummary extends StatelessWidget {
  const _SearchSummary();

  @override
  Widget build(BuildContext context) {
    return AafiatakSectionHeading(
      label: 'النتائج',
      meta: '${kSearchResults.length} نتائج',
    );
  }
}

/// بلاطة نتيجة بحث واحدة: شارة نوعها مشتقة من النتيجة نفسها،
/// عنواناها، وسهم بورجوندي يشير يسارًا (اتجاه الأمام في RTL).
class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({required this.result, required this.onTap});

  final SearchResult result;
  final VoidCallback onTap;

  String get _badgeLabel => switch (result.kind) {
    SearchKind.doctor => 'طبيب',
    SearchKind.service => 'خدمة',
    SearchKind.facility => 'منشأة',
  };

  AafiatakFeedbackTone get _badgeTone => switch (result.kind) {
    SearchKind.doctor => AafiatakFeedbackTone.secondary,
    SearchKind.service => AafiatakFeedbackTone.primary,
    SearchKind.facility => AafiatakFeedbackTone.info,
  };

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AafiatakBadge(label: _badgeLabel, tone: _badgeTone),
                const SizedBox(height: AafiatakSpacing.space8),
                Text(
                  result.title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(result.subtitle, style: AafiatakTypography.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: AafiatakSpacing.space12),
          const Icon(
            Icons.chevron_left_rounded,
            size: 22,
            color: AafiatakColors.primary,
          ),
        ],
      ),
    );
  }
}
