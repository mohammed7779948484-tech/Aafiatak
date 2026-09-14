import 'package:aafiatak/src/app/aafiatak_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Aafiatak application shell mounts the starter route', (
    tester,
  ) async {
    await tester.pumpWidget(const AafiatakApp());
    await tester.pumpAndSettle();

    expect(find.text('عافيتك'), findsWidgets);
    expect(find.text('الرعاية أقرب مما تتوقع'), findsOneWidget);
    expect(find.text('احجز موعدًا الآن'), findsOneWidget);
  });
}
