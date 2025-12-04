import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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

  group('createAppRouter', () {
    test('creates GoRouter instance', () {
      final router = createAppRouter(
        shellBuilder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      );

      expect(router, isA<GoRouter>());
    });

    test('uses rootNavigatorKey', () {
      final router = createAppRouter(
        shellBuilder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      );

      // Verify the router uses the root navigator key
      expect(router.configuration.navigatorKey, rootNavigatorKey);
    });

    test('creates router with shell route containing provided routes', () {
      final router = createAppRouter(
        shellBuilder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Placeholder(),
          ),
          GoRoute(
            path: AppRoutes.chores,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      );

      // Router should have one top-level route (ShellRoute)
      expect(router.configuration.routes.length, 1);
      expect(router.configuration.routes.first, isA<ShellRoute>());
    });
  });
}
