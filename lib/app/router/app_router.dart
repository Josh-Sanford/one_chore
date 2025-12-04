import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route paths for the app.
abstract class AppRoutes {
  static const String home = '/';
  static const String chores = '/chores';
  static const String history = '/history';
  static const String visualization = '/visualization';
  static const String settings = '/settings';
}

/// App router configuration using GoRouter.
///
/// Uses ShellRoute pattern to maintain persistent bottom navigation
/// across all main screens.
///
/// Creates fresh navigator keys for each router instance to ensure
/// proper isolation between test runs.
GoRouter createAppRouter({
  required Widget Function(BuildContext, GoRouterState, Widget) shellBuilder,
  required List<RouteBase> routes,
  GlobalKey<NavigatorState>? rootNavigatorKey,
  GlobalKey<NavigatorState>? shellNavigatorKey,
}) {
  final rootKey = rootNavigatorKey ?? GlobalKey<NavigatorState>();
  final shellKey = shellNavigatorKey ?? GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootKey,
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        navigatorKey: shellKey,
        builder: shellBuilder,
        routes: routes,
      ),
    ],
  );
}
