import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chore/app/router/app_router.dart';
import 'package:one_chore/app/view/app_scaffold.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppScaffold', () {
    late GoRouter testRouter;

    setUp(() {
      testRouter = GoRouter(
        initialLocation: AppRoutes.home,
        routes: [
          ShellRoute(
            builder: (context, state, child) => AppScaffold(child: child),
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const Text('Today Screen'),
              ),
              GoRoute(
                path: AppRoutes.chores,
                builder: (context, state) => const Text('Chores Screen'),
              ),
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const Text('History Screen'),
              ),
              GoRoute(
                path: AppRoutes.visualization,
                builder: (context, state) =>
                    const Text('Visualization Screen'),
              ),
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const Text('Settings Screen'),
              ),
            ],
          ),
        ],
      );
    });

    testWidgets('renders bottom navigation bar with 5 items', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      expect(find.byType(BottomNavigationBar), findsOneWidget);

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.items.length, 5);
    });

    testWidgets('displays correct nav item labels', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Chores'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Progress'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('starts with Today tab selected', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.currentIndex, 0);
      expect(find.text('Today Screen'), findsOneWidget);
    });

    testWidgets('navigates to Chores screen on tap', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chores'));
      await tester.pumpAndSettle();

      expect(find.text('Chores Screen'), findsOneWidget);

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.currentIndex, 1);
    });

    testWidgets('navigates to History screen on tap', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      expect(find.text('History Screen'), findsOneWidget);

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.currentIndex, 2);
    });

    testWidgets('navigates to Progress screen on tap', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Progress'));
      await tester.pumpAndSettle();

      expect(find.text('Visualization Screen'), findsOneWidget);

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.currentIndex, 3);
    });

    testWidgets('navigates to Settings screen on tap', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.text('Settings Screen'), findsOneWidget);

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.currentIndex, 4);
    });

    testWidgets('navigates back to Today from another screen', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      // Navigate to Settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Settings Screen'), findsOneWidget);

      // Navigate back to Today
      await tester.tap(find.text('Today'));
      await tester.pumpAndSettle();
      expect(find.text('Today Screen'), findsOneWidget);

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.currentIndex, 0);
    });

    testWidgets('all nav items have tooltips', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));

      // Check that all items have tooltips matching their labels
      expect(bottomNav.items[0].tooltip, 'Today');
      expect(bottomNav.items[1].tooltip, 'Chores');
      expect(bottomNav.items[2].tooltip, 'History');
      expect(bottomNav.items[3].tooltip, 'Progress');
      expect(bottomNav.items[4].tooltip, 'Settings');
    });

    testWidgets('tooltips match labels for accessibility', (tester) async {
      await tester.pumpRouterApp(testRouter);
      await tester.pumpAndSettle();

      final bottomNav =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));

      // Verify tooltips match labels for each item
      for (var i = 0; i < bottomNav.items.length; i++) {
        expect(
          bottomNav.items[i].tooltip,
          bottomNav.items[i].label,
          reason: 'Tooltip should match label for accessibility',
        );
      }
    });
  });
}
