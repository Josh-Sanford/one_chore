import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/app_theme.dart';
import 'package:one_chore/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: Center(
          child: Text('OneChore - Coming Soon'),
        ),
      ),
    );
  }
}
