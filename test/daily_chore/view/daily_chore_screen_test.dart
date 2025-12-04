// ignore_for_file: prefer_const_constructors, for testing flexibility

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/daily_chore/view/daily_chore_screen.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DailyChoreScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(DailyChoreScreen());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays correct app bar title', (tester) async {
      await tester.pumpApp(DailyChoreScreen());
      await tester.pumpAndSettle();

      expect(find.text("Today's Chore"), findsOneWidget);
    });

    testWidgets('shows empty state when no chore selected', (tester) async {
      await tester.pumpApp(DailyChoreScreen());
      await tester.pumpAndSettle();

      expect(find.text('No chore selected'), findsOneWidget);
      expect(
        find.text('Select a chore from your list to focus on today.'),
        findsOneWidget,
      );
    });

    testWidgets('shows Select a Chore action button', (tester) async {
      await tester.pumpApp(DailyChoreScreen());
      await tester.pumpAndSettle();

      expect(find.text('Select a Chore'), findsOneWidget);
    });

    testWidgets('has task_alt icon in empty state', (tester) async {
      await tester.pumpApp(DailyChoreScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.task_alt), findsOneWidget);
    });
  });
}
