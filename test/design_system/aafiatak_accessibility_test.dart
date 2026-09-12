import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets(
    'representative controls satisfy Flutter accessibility guidelines',
    (tester) async {
      final handle = tester.ensureSemantics();
      try {
        await tester.pumpWidget(
          buildDesignSystemTestApp(
            ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                AafiatakButton(
                  label: 'متابعة',
                  isExpanded: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                Center(
                  child: AafiatakIconButton(
                    icon: const Icon(Icons.notifications_none_rounded),
                    tooltip: 'الإشعارات',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 16),
                const AafiatakTextField(
                  label: 'الاسم الكامل',
                  hint: 'اكتب الاسم',
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
      } finally {
        handle.dispose();
      }
    },
  );
}
