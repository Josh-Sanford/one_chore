// ignore_for_file: prefer_const_constructors, for testing flexibility

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

    testWidgets('shows Notifications section', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Daily Reminder'), findsOneWidget);
    });

    testWidgets('shows Appearance section', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Theme'), findsOneWidget);
    });

    testWidgets('shows About section with version', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('About'), findsOneWidget);
      expect(find.text('Version'), findsOneWidget);
      expect(find.text('1.0.0'), findsOneWidget);
    });

    testWidgets('has notification switch (disabled)', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, false);
      expect(switchWidget.onChanged, isNull);
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

      expect(find.byType(Card), findsNWidgets(3));
    });

    testWidgets('disabled tiles have Coming soon subtitle', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Coming soon'), findsNWidgets(2));
    });

    testWidgets('disabled tiles have reduced opacity', (tester) async {
      await tester.pumpApp(SettingsScreen());
      await tester.pumpAndSettle();

      final opacityWidgets = tester.widgetList<Opacity>(find.byType(Opacity));
      final disabledTiles =
          opacityWidgets.where((widget) => widget.opacity == 0.6).toList();
      expect(disabledTiles.length, 2);
    });
  });
}
