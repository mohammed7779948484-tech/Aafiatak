import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets(
    'AafiatakButton uses Material behavior and blocks taps while loading',
    (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        buildDesignSystemTestApp(
          Center(
            child: AafiatakButton(label: 'متابعة', onPressed: () => taps += 1),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      await tester.tap(find.text('متابعة'));
      await tester.pump();
      expect(taps, 1);

      await tester.pumpWidget(
        buildDesignSystemTestApp(
          Center(
            child: AafiatakButton(
              label: 'متابعة',
              isLoading: true,
              onPressed: () => taps += 1,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      expect(taps, 1);
    },
  );

  testWidgets('OTP input obeys caller-supplied length', (tester) async {
    String? completed;

    await tester.pumpWidget(
      buildDesignSystemTestApp(
        Padding(
          padding: const EdgeInsets.all(16),
          child: AafiatakOtpInput(
            label: 'رمز التحقق',
            length: 5,
            onCompleted: (value) => completed = value,
          ),
        ),
      ),
    );

    final cells = find.descendant(
      of: find.byType(AafiatakOtpInput),
      matching: find.byType(AnimatedContainer),
    );
    expect(cells, findsNWidgets(5));

    await tester.enterText(find.byType(TextField), '12345');
    await tester.pump();
    expect(completed, '12345');
    expect(find.text('1'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('status block supports optional supporting copy and action', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        Padding(
          padding: const EdgeInsets.all(16),
          child: AafiatakStatusBlock(
            title: 'قيد المعالجة',
            tone: AafiatakFeedbackTone.info,
            action: TextButton(
              onPressed: () {},
              child: const Text('عرض التفاصيل'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('قيد المعالجة'), findsOneWidget);
    expect(find.text('عرض التفاصيل'), findsOneWidget);
  });

  testWidgets('list row exposes a reusable tappable row', (tester) async {
    var taps = 0;

    await tester.pumpWidget(
      buildDesignSystemTestApp(
        AafiatakListRow(
          title: const Text('عنصر'),
          trailing: const Icon(Icons.chevron_left_rounded),
          onTap: () => taps += 1,
        ),
      ),
    );

    await tester.tap(find.text('عنصر'));
    expect(taps, 1);
  });

  testWidgets('primary action bar owns only reusable action layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        AafiatakPrimaryActionBar(
          secondaryAction: AafiatakButton(
            label: 'رجوع',
            variant: AafiatakButtonVariant.text,
            onPressed: () {},
          ),
          primaryAction: AafiatakButton(
            label: 'متابعة',
            isExpanded: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('رجوع'), findsOneWidget);
    expect(find.text('متابعة'), findsOneWidget);
  });

  testWidgets('feedback surfaces include text, not color alone', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const Padding(
          padding: EdgeInsets.all(16),
          child: AafiatakStatusBlock(
            title: 'قيد المعالجة',
            message: 'سنحدّث الحالة عند وصول النتيجة الموثوقة.',
            tone: AafiatakFeedbackTone.info,
          ),
        ),
      ),
    );

    expect(find.text('قيد المعالجة'), findsOneWidget);
    expect(
      find.text('سنحدّث الحالة عند وصول النتيجة الموثوقة.'),
      findsOneWidget,
    );
  });

  testWidgets('selection controls expose a non-color selected indicator', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        Column(
          children: <Widget>[
            AafiatakChip(
              label: 'متاح اليوم',
              selected: true,
              onSelected: (_) {},
            ),
            AafiatakSegmentedControl<String>(
              segments: const <AafiatakSegment<String>>[
                AafiatakSegment(value: 'a', label: 'الأول'),
                AafiatakSegment(value: 'b', label: 'الثاني'),
              ],
              selected: 'a',
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );

    final chip = tester.widget<FilterChip>(find.byType(FilterChip));
    expect(chip.showCheckmark, isTrue);

    final segmented = tester.widget<SegmentedButton<String>>(
      find.byType(SegmentedButton<String>),
    );
    expect(segmented.showSelectedIcon, isTrue);
  });
}
