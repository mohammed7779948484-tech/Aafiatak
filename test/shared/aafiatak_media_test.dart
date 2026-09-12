import 'package:aafiatak/src/shared/media/media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../design_system/test_app.dart';

void main() {
  testWidgets('AafiatakImage fails safely for an empty source', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const AafiatakImage(
          source: '   ',
          errorWidget: Text('تعذر عرض الصورة'),
        ),
      ),
    );

    expect(find.text('تعذر عرض الصورة'), findsOneWidget);
  });

  testWidgets('AafiatakNetworkImage fails safely for an empty URL', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const AafiatakNetworkImage(
          imageUrl: '',
          errorWidget: Text('تعذر تحميل الصورة'),
        ),
      ),
    );

    expect(find.text('تعذر تحميل الصورة'), findsOneWidget);
  });
}
