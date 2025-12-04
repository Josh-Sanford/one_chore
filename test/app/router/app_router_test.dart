import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/app/router/app_router.dart';

void main() {
  group('AppRoutes', () {
    test('has correct home route', () {
      expect(AppRoutes.home, '/');
    });

    test('has correct chores route', () {
      expect(AppRoutes.chores, '/chores');
    });

    test('has correct history route', () {
      expect(AppRoutes.history, '/history');
    });

    test('has correct visualization route', () {
      expect(AppRoutes.visualization, '/visualization');
    });

    test('has correct settings route', () {
      expect(AppRoutes.settings, '/settings');
    });
  });

  group('Navigator Keys', () {
    test('rootNavigatorKey is not null', () {
      expect(rootNavigatorKey, isNotNull);
    });

    test('shellNavigatorKey is not null', () {
      expect(shellNavigatorKey, isNotNull);
    });
  });
}
