import 'package:aafiatak/src/app/routing/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('starter route is the only application-shell route in this phase', () {
    expect(AppRoutes.root, '/');
  });
}
