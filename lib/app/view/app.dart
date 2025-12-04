import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_chore/app/router/app_router.dart';
import 'package:one_chore/app/view/app_scaffold.dart';
import 'package:one_chore/chore_list/view/chore_list_screen.dart';
import 'package:one_chore/core/theme/app_theme.dart';
import 'package:one_chore/daily_chore/view/daily_chore_screen.dart';
import 'package:one_chore/history/view/history_screen.dart';
import 'package:one_chore/l10n/l10n.dart';
import 'package:one_chore/settings/view/settings_screen.dart';
import 'package:one_chore/visualization/view/visualization_screen.dart';

/// The app router instance.
final GoRouter _router = createAppRouter(
  shellBuilder: (context, state, child) => AppScaffold(child: child),
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
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
