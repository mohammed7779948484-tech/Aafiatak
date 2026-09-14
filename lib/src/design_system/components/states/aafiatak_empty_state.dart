import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../buttons/aafiatak_button.dart';
import '../surfaces/aafiatak_card.dart';

/// حالة فارغة موحّدة لغياب النتائج أو المواعيد أو البيانات.
///
/// يمكن تغيير [icon] حسب سياق الشاشة، كما يمكن حذف الإجراء بالكامل. عند عرض
/// إجراء يجب تمرير [actionLabel] و[onAction] معًا. هذا مكون عرض عام بلا منطق
/// أعمال؛ أما الحالة الخاصة بميزة واحدة فمكانها داخل `feature/widgets`.
class AafiatakEmptyState extends StatelessWidget {
  const AafiatakEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  }) : assert(
         (actionLabel == null) == (onAction == null),
         'يجب تمرير actionLabel وonAction معًا.',
       );

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AafiatakSpacing.space16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AafiatakColors.surfaceContainer,
                borderRadius: AafiatakRadii.large,
              ),
              child: Icon(icon, size: 24, color: AafiatakColors.textPrimary),
            ),
            const SizedBox(height: AafiatakSpacing.space12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AafiatakTypography.titleLarge,
            ),
            const SizedBox(height: AafiatakSpacing.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AafiatakTypography.bodySmall,
            ),
            if (onAction != null) ...<Widget>[
              const SizedBox(height: AafiatakSpacing.space16),
              AafiatakButton.tonal(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
