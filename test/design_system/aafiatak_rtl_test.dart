import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('Arabic locale establishes RTL direction', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const Scaffold(
          appBar: AafiatakAppBar(title: 'تفاصيل الموعد', showBackButton: true),
          body: Text('المحتوى'),
        ),
      ),
    );
    final titleContext = tester.element(find.text('تفاصيل الموعد'));
    expect(Directionality.of(titleContext), TextDirection.rtl);
    expect(find.byType(BackButton), findsOneWidget);
  });

  testWidgets('phone input stays LTR inside RTL app', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const Padding(
          padding: EdgeInsets.all(16),
          child: AafiatakPhoneField(label: 'رقم الهاتف'),
        ),
      ),
    );
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.textDirection, TextDirection.ltr);
  });
}
