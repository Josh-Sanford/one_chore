import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chore/app/view/app_scaffold.dart';
import 'package:one_chore/chore_list/view/chore_list_screen.dart';
import 'package:one_chore/daily_chore/view/daily_chore_screen.dart';
import 'package:one_chore/history/view/history_screen.dart';
import 'package:one_chore/settings/view/settings_screen.dart';
import 'package:one_chore/visualization/view/visualization_screen.dart';

/// Route paths for the app.
abstract class AppRoutes {
  static const String home = '/';
  static const String chores = '/chores';
  static const String history = '/history';
  static const String visualization = '/visualization';
  static const String settings = '/settings';
}

/// Global navigation key for nested navigation.
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Shell navigation key for bottom nav shell.
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

/// App router configuration using GoRouter.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DailyChoreScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.chores,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChoreListScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.history,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HistoryScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.visualization,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: VisualizationScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);
