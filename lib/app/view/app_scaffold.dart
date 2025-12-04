import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chore/app/router/app_router.dart';
import 'package:one_chore/l10n/l10n.dart';

/// App scaffold with bottom navigation bar.
///
/// This widget wraps the main content and provides navigation
/// between the primary screens of the app.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    super.key,
  });

  /// The child widget to display in the body.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.today),
            activeIcon: const Icon(Icons.today),
            label: context.l10n.navToday,
            tooltip: context.l10n.navToday,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            activeIcon: const Icon(Icons.list_alt),
            label: context.l10n.navChores,
            tooltip: context.l10n.navChores,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            activeIcon: const Icon(Icons.history),
            label: context.l10n.navHistory,
            tooltip: context.l10n.navHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            activeIcon: const Icon(Icons.bar_chart),
            label: context.l10n.navProgress,
            tooltip: context.l10n.navProgress,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: context.l10n.navSettings,
            tooltip: context.l10n.navSettings,
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.chores:
        return 1;
      case AppRoutes.history:
        return 2;
      case AppRoutes.visualization:
        return 3;
      case AppRoutes.settings:
        return 4;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.chores);
      case 2:
        context.go(AppRoutes.history);
      case 3:
        context.go(AppRoutes.visualization);
      case 4:
        context.go(AppRoutes.settings);
    }
  }
}
