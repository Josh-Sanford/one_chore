// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/settings/providers/app_version_provider.dart';
import 'package:one_chore/settings/view/settings_screen.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SettingsScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('displays correct app bar title', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('shows Notifications section with "Coming soon"',
        (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Daily Reminder'), findsOneWidget);
      expect(find.text('Coming soon'), findsNWidgets(2)); // Both disabled tiles
    });

    testWidgets('shows Appearance section with "Coming soon"', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('Coming soon'), findsNWidgets(2)); // Both disabled tiles
    });

    testWidgets('shows About section with loading indicator initially',
        (tester) async {
      await tester.pumpApp(SettingsScreen());

      expect(find.text('About'), findsOneWidget);
      expect(find.text('Version'), findsOneWidget);
      expect(find.text('...'), findsOneWidget);
    });

    testWidgets('displays app version from provider when loaded',
        (tester) async {
      await tester.pumpApp(
        SettingsScreen(),
        overrides: [
          appVersionProvider.overrideWith((_) async => '1.2.3'),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('About'), findsOneWidget);
      expect(find.text('Version'), findsOneWidget);
      expect(find.text('1.2.3'), findsOneWidget);
    });

    testWidgets('handles provider error gracefully', (tester) async {
      await tester.pumpApp(
        SettingsScreen(),
        overrides: [
          appVersionProvider.overrideWith(
            (_) async => throw Exception('Failed to load version'),
          ),
        ],
      );
      // Let all frames complete
      await tester.pumpAndSettle();

      // Should show the "Version" label
      expect(find.text('Version'), findsOneWidget);

      // Should not crash - screen should still render properly
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('has disabled notification switch', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, false);
      expect(switchWidget.onChanged, isNull); // Disabled
    });

    testWidgets('has icons for settings tiles', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('has cards for each section', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      // Each settings section has a Card
      expect(find.byType(Card), findsNWidgets(3));
    });

    testWidgets('disabled tiles have reduced opacity', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      // Find all Opacity widgets
      final opacityWidgets = tester.widgetList<Opacity>(find.byType(Opacity));

      // Check that at least two tiles have reduced opacity (disabled tiles)
      final disabledTiles =
          opacityWidgets.where((widget) => widget.opacity == 0.6).toList();
      expect(disabledTiles.length, 2); // Notifications and Theme tiles
    });

    testWidgets('disabled tiles are not enabled', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      // Find all ListTiles
      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));

      // Count disabled ListTiles
      final disabledListTiles =
          listTiles.where((tile) => !tile.enabled).toList();
      expect(disabledListTiles.length, 2); // Notifications and Theme tiles
    });
  });
}
