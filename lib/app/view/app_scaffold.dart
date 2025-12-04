import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chore/app/router/app_router.dart';

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            activeIcon: Icon(Icons.today),
            label: 'Today',
            tooltip: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Chores',
            tooltip: 'Chores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
            tooltip: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Progress',
            tooltip: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
            tooltip: 'Settings',
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
