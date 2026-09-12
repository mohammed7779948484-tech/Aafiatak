import 'package:aafiatak/src/app/aafiatak_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Aafiatak application shell mounts the audited starter route', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: AafiatakApp()));
    await tester.pumpAndSettle();

    expect(find.text('بيئة تأسيس الواجهات جاهزة'), findsOneWidget);
    expect(find.text('عافيتك'), findsOneWidget);
  });
}
