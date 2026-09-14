import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// عنوان موحّد لبداية قسم من محتوى الشاشة.
///
/// يعرض [label] مع وصف مختصر اختياري في [meta]. استخدم أزرار Material مباشرة
/// إذا احتاج القسم إلى إجراء، ولا توسع هذا المكون ليحمل منطق الـ Feature.
class AafiatakSectionHeading extends StatelessWidget {
  const AafiatakSectionHeading({super.key, required this.label, this.meta});

  final String label;
  final String? meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: AafiatakTypography.titleLarge.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (meta != null && meta!.isNotEmpty)
          Text(
            meta!,
            style: AafiatakTypography.labelSmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
