import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  group('Aafiatak Core Components', () {
    testWidgets('AafiatakButton responds to taps and disables correctly', (
      tester,
    ) async {
      var taps = 0;

      await tester.pumpWidget(
        buildDesignSystemTestApp(
          Center(
            child: AafiatakButton(label: 'متابعة', onPressed: () => taps += 1),
          ),
        ),
      );

      expect(find.text('متابعة'), findsOneWidget);
      await tester.tap(find.text('متابعة'));
      await tester.pump();
      expect(taps, 1);

      // Disabled button
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const Center(child: AafiatakButton(label: 'معطل', onPressed: null)),
        ),
      );

      await tester.tap(find.text('معطل'));
      await tester.pump();
      expect(taps, 1); // Tap should not increase
    });

    testWidgets('AafiatakTextField renders label, hint, and errorText', (
      tester,
    ) async {
      String entered = '';

      await tester.pumpWidget(
        buildDesignSystemTestApp(
          Padding(
            padding: const EdgeInsets.all(16),
            child: AafiatakTextField(
              label: 'رقم الهاتف',
              hintText: '777 000 000',
              errorText: 'الرقم غير صحيح',
              onChanged: (v) => entered = v,
            ),
          ),
        ),
      );

      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('777 000 000'), findsOneWidget);
      expect(find.text('الرقم غير صحيح'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '771234567');
      await tester.pump();
      expect(entered, '771234567');
    });

    testWidgets('AafiatakBadge renders label and bullet point', (tester) async {
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const Center(
            child: AafiatakBadge(
              label: 'مؤكد',
              tone: AafiatakFeedbackTone.success,
            ),
          ),
        ),
      );

      expect(find.text('مؤكد'), findsOneWidget);
      expect(find.byType(AafiatakBadge), findsOneWidget);
    });

    testWidgets('AafiatakNotice renders contextual notice text', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const Padding(
            padding: EdgeInsets.all(16),
            child: AafiatakNotice(
              message: 'تم حجز السعة المؤقتة بنجاح',
              tone: AafiatakFeedbackTone.hold,
            ),
          ),
        ),
      );

      expect(find.text('تم حجز السعة المؤقتة بنجاح'), findsOneWidget);
    });

    testWidgets('AafiatakStatusBlock renders tag, title, and copy', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const Padding(
            padding: EdgeInsets.all(16),
            child: AafiatakStatusBlock(
              title: 'تم تأكيد الموعد',
              copy: 'تم إرسال رسالة التأكيد عبر واتساب.',
              tag: 'مكتمل',
              tone: AafiatakFeedbackTone.success,
            ),
          ),
        ),
      );

      expect(find.text('تم تأكيد الموعد'), findsOneWidget);
      expect(find.text('تم إرسال رسالة التأكيد عبر واتساب.'), findsOneWidget);
      expect(find.text('مكتمل'), findsOneWidget);
    });

    testWidgets('AafiatakInfoRows renders rows with proper LTR isolation', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const Padding(
            padding: EdgeInsets.all(16),
            child: AafiatakInfoRows(
              rows: <InfoRowItem>[
                InfoRowItem(label: 'اليوم', value: 'الأربعاء'),
                InfoRowItem(
                  label: 'النافذة',
                  value: '10:00 ص – 10:30 ص',
                  isLtr: true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('اليوم'), findsOneWidget);
      expect(find.text('الأربعاء'), findsOneWidget);
      expect(find.text('النافذة'), findsOneWidget);
      expect(find.text('10:00 ص – 10:30 ص'), findsOneWidget);
    });

    testWidgets('AafiatakSectionHeading renders label and meta action', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const Padding(
            padding: EdgeInsets.all(16),
            child: AafiatakSectionHeading(
              label: 'الأطباء المتاحون',
              meta: 'عرض الكل',
            ),
          ),
        ),
      );

      expect(find.text('الأطباء المتاحون'), findsOneWidget);
      expect(find.text('عرض الكل'), findsOneWidget);
    });

    testWidgets(
      'AafiatakEmptyState renders icon, title, copy, and action button',
      (tester) async {
        var actionTapped = false;

        await tester.pumpWidget(
          buildDesignSystemTestApp(
            Padding(
              padding: const EdgeInsets.all(16),
              child: AafiatakEmptyState(
                title: 'لا توجد نتائج',
                copy: 'جرب البحث بكلمات أخرى.',
                actionLabel: 'إعادة المحاولة',
                onAction: () => actionTapped = true,
              ),
            ),
          ),
        );

        expect(find.text('لا توجد نتائج'), findsOneWidget);
        expect(find.text('جرب البحث بكلمات أخرى.'), findsOneWidget);
        expect(find.text('إعادة المحاولة'), findsOneWidget);

        await tester.tap(find.text('إعادة المحاولة'));
        await tester.pump();
        expect(actionTapped, isTrue);
      },
    );
  });

  group('Aafiatak Domain Patterns', () {
    testWidgets('DoctorCard renders doctor name, specialty, and price', (
      tester,
    ) async {
      var doctorTapped = false;

      await tester.pumpWidget(
        buildDesignSystemTestApp(
          DoctorCard(
            name: 'د. سارة المنصوري',
            specialty: 'استشارية الأطفال',
            price: '15,000 ر.ي',
            onTap: () => doctorTapped = true,
          ),
        ),
      );

      expect(find.text('د. سارة المنصوري'), findsOneWidget);
      expect(find.text('استشارية الأطفال'), findsOneWidget);
      expect(find.text('15,000 ر.ي'), findsOneWidget);
      expect(find.text('سعر الخدمة'), findsOneWidget);

      await tester.tap(find.text('د. سارة المنصوري'));
      await tester.pump();
      expect(doctorTapped, isTrue);
    });

    testWidgets('ReservationHoldBanner renders title and countdown', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildDesignSystemTestApp(
          const ReservationHoldBanner(
            title: 'تم حجز السعة مؤقتًا',
            countdown: '09:59',
          ),
        ),
      );

      expect(find.text('تم حجز السعة مؤقتًا'), findsOneWidget);
      expect(find.text('09:59'), findsOneWidget);
    });
  });
}
