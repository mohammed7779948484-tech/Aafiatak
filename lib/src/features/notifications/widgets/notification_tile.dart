import 'package:aafiatak/src/design_system/components/feedback/aafiatak_feedback_tone.dart'
    show AafiatakFeedbackToneX;
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/notifications/mock_data.dart';
import 'package:flutter/material.dart';

/// بلاطة إشعار واحدة: نصوصها وأيقونة حالتها وتدرج «غير مقروء».
/// عرض فقط — لا تنقل داخليًا؛ الشاشة هي من يوجه الضغط.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  IconData get _kindIcon => switch (notification.kind) {
    NotificationKind.appointment => Icons.calendar_month_outlined,
    NotificationKind.payment => Icons.credit_card_outlined,
    NotificationKind.visit => Icons.confirmation_number_outlined,
  };

  AafiatakFeedbackTone get _kindTone => switch (notification.kind) {
    NotificationKind.appointment => AafiatakFeedbackTone.info,
    NotificationKind.payment => AafiatakFeedbackTone.success,
    NotificationKind.visit => AafiatakFeedbackTone.primary,
  };

  @override
  Widget build(BuildContext context) {
    final unread = notification.unread;
    final colors = _kindTone.colors;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AafiatakSpacing.space16),
          decoration: BoxDecoration(
            color: AafiatakColors.surface,
            border: Border.all(
              color: unread ? const Color(0x38800020) : const Color(0x121A1A1A),
            ),
            borderRadius: AafiatakRadii.large,
            gradient: unread
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0x8CF7E9EC), AafiatakColors.surface],
                    stops: [0, 0.42],
                  )
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      notification.title,
                      style: AafiatakTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      notification.message,
                      style: AafiatakTypography.bodySmall,
                    ),
                    const SizedBox(height: AafiatakSpacing.space8),
                    Text(
                      unread
                          ? '${notification.time} · غير مقروء'
                          : notification.time,
                      style: AafiatakTypography.caption.copyWith(
                        color: AafiatakColors.outlineStrong,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AafiatakSpacing.space12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: AafiatakRadii.medium,
                ),
                alignment: Alignment.center,
                child: Icon(_kindIcon, size: 24, color: colors.foreground),
              ),
            ],
          ),
        ),
        if (unread)
          const PositionedDirectional(top: 18, start: 12, child: _UnreadDot()),
      ],
    );
  }
}

/// نقطة «غير مقروء»: بورجوندي صغيرة ترافق النص ولا تعتمد على اللون وحده.
class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: AafiatakColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
