import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('Arabic locale establishes RTL direction', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const Scaffold(
          appBar: AafiatakDetailAppBar(
            title: 'تفاصيل الموعد',
            screenId: 'PAT-12',
          ),
          body: Text('المحتوى'),
        ),
      ),
    );
    final titleContext = tester.element(find.text('تفاصيل الموعد'));
    expect(Directionality.of(titleContext), TextDirection.rtl);
    expect(find.text('PAT-12'), findsOneWidget);
  });

  testWidgets('LTR input / data row stays LTR inside RTL app', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const Padding(
          padding: EdgeInsets.all(16),
          child: AafiatakTextField(
            label: 'رقم الهاتف',
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.textDirection, TextDirection.ltr);
  });
}
