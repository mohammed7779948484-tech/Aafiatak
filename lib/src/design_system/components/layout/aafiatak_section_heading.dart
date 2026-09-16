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
    final visibleMeta = meta;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Text(
            label,
            style: AafiatakTypography.h3.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (visibleMeta != null && visibleMeta.isNotEmpty) ...<Widget>[
          const SizedBox(width: AafiatakSpacing.space8),
          Flexible(
            child: Text(
              visibleMeta,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AafiatakTypography.caption.copyWith(
                color: AafiatakColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
