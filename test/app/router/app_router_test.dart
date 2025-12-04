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

  group('appRouter', () {
    test('is properly configured', () {
      // Verify router is not null and has routes configured
      expect(appRouter, isNotNull);
      expect(appRouter.configuration, isNotNull);
    });
  });
}
