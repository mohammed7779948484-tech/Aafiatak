import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';
import '../buttons/aafiatak_button.dart';
import '../surfaces/aafiatak_card.dart';

/// حالة فارغة موحّدة لغياب النتائج أو المواعيد أو البيانات.
///
/// يمكن تغيير [icon] حسب سياق الشاشة، كما يمكن حذف الإجراء بالكامل. استخدم
/// [AafiatakEmptyState.withAction] عند الحاجة إلى إجراء. هذا مكون عرض عام بلا
/// منطق أعمال؛ أما الحالة الخاصة بميزة واحدة فمكانها داخل `feature/widgets`.
class AafiatakEmptyState extends StatelessWidget {
  const AafiatakEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  }) : actionLabel = null,
       onAction = null;

  const AafiatakEmptyState.withAction({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final visibleActionLabel = actionLabel;
    final actionCallback = onAction;

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
            if (visibleActionLabel != null &&
                actionCallback != null) ...<Widget>[
              const SizedBox(height: AafiatakSpacing.space16),
              AafiatakButton.tonal(
                label: visibleActionLabel,
                onPressed: actionCallback,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
