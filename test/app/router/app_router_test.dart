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

    test('creates fresh navigator keys by default', () {
      final router1 = createAppRouter(
        shellBuilder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      );

      final router2 = createAppRouter(
        shellBuilder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Placeholder(),
          ),
        ],
      );

      // Each router should have different navigator keys
      expect(
        router1.configuration.navigatorKey,
        isNot(router2.configuration.navigatorKey),
      );
    });

    test('uses provided navigator keys when specified', () {
      final rootKey = GlobalKey<NavigatorState>();
      final shellKey = GlobalKey<NavigatorState>();

      final router = createAppRouter(
        shellBuilder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Placeholder(),
          ),
        ],
        rootNavigatorKey: rootKey,
        shellNavigatorKey: shellKey,
      );

      expect(router.configuration.navigatorKey, rootKey);
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
