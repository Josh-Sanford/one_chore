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

/// Global navigation key for nested navigation.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Shell navigation key for bottom nav shell.
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

/// App router configuration using GoRouter.
///
/// Uses ShellRoute pattern to maintain persistent bottom navigation
/// across all main screens.
GoRouter createAppRouter({
  required Widget Function(BuildContext, GoRouterState, Widget) shellBuilder,
  required List<RouteBase> routes,
}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: shellBuilder,
        routes: routes,
      ),
    ],
  );
}
