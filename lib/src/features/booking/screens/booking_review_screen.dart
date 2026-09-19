import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../mock_data.dart';

/// حالتا العرض المعتمدتان للشاشة: قبل إنشاء الحجز المؤقت وبعد تنشيطه.
enum _BookingReviewView { preHoldReview, activeHold }

/// شاشة PAT-07 «مراجعة الحجز» بحالتَي pre-hold-review وactive-hold.
///
/// الانتقال بين الحالتين محلي عبر `setState` فقط ولا يشغّل مؤقتًا؛ الحجز
/// المؤقت عرض توضيحي منفصل عن الموعد المؤكد وعملية الدفع. زر «الانتقال
/// إلى الدفع» يسلّم الاستمرار إلى [onPaymentTap] دون أن يعرف وجهته.
class BookingReviewScreen extends StatefulWidget {
  const BookingReviewScreen({super.key, required this.onPaymentTap});

  final VoidCallback onPaymentTap;

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  _BookingReviewView _view = _BookingReviewView.preHoldReview;

  @override
  Widget build(BuildContext context) {
    final activeHold = _view == _BookingReviewView.activeHold;

    return PatientShell.detail(
      title: 'مراجعة الحجز',
      screenId: 'PAT-07',
      scrollable: true,
      bottomAction: activeHold
          ? AafiatakButton.primary(
              label: 'الانتقال إلى الدفع',
              fullWidth: true,
              onPressed: widget.onPaymentTap,
            )
          : AafiatakButton.primary(
              label: 'إنشاء الحجز المؤقت',
              fullWidth: true,
              onPressed: () =>
                  setState(() => _view = _BookingReviewView.activeHold),
            ),
      body: Padding(
        padding: const EdgeInsets.all(AafiatakSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AppointmentSummary(
              service: BookingMockData.service,
              doctor: BookingMockData.doctor,
              facility: BookingMockData.facility,
              branch: BookingMockData.branch,
              date: BookingMockData.date,
              arrivalWindow: BookingMockData.arrivalWindow,
            ),
            const SizedBox(height: AafiatakSpacing.space16),
            const _BookingAmountBlock(),
            const SizedBox(height: AafiatakSpacing.space16),
            const PolicyCard(
              title: 'قبل التأكيد',
              items: <String>[
                'الحجز المؤقت يحمي السعة لفترة قصيرة فقط.',
                'سياسة الإلغاء والاسترداد محفوظة مع الموعد عند التأكيد.',
                'نافذة الوصول ليست وقت دخول مضمونًا للطبيب.',
              ],
            ),
            if (activeHold) ...<Widget>[
              const SizedBox(height: AafiatakSpacing.space16),
              const ReservationHoldBanner(
                countdown: BookingMockData.holdCountdown,
              ),
              const SizedBox(height: AafiatakSpacing.space12),
              const AafiatakNotice(
                message: 'الحجز المؤقت ليس موعدًا مؤكدًا بعد. أكمل الدفع قبل انتهاء الحماية.',
                tone: AafiatakFeedbackTone.hold,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// قسم «الدفع والسياسة» مع المبلغ الكامل كما في الحالة المرجعية.
class _BookingAmountBlock extends StatelessWidget {
  const _BookingAmountBlock();

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Expanded(child: AafiatakSectionHeading(label: 'الدفع والسياسة')),
              SizedBox(width: AafiatakSpacing.space8),
              AafiatakBadge(
                label: BookingMockData.paymentPolicyLabel,
                tone: AafiatakFeedbackTone.warning,
              ),
            ],
          ),
          const SizedBox(height: AafiatakSpacing.space8),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              BookingMockData.amount,
              style: AafiatakTypography.display.copyWith(
                color: AafiatakColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AafiatakSpacing.space8),
          const Text(
            'سياسة الدفع محددة للخدمة ولا يمكن تغييرها من المريض.',
            style: AafiatakTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}
