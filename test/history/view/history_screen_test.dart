// ignore_for_file: prefer_const_constructors, for testing flexibility

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/history/view/history_screen.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HistoryScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(HistoryScreen());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays correct app bar title', (tester) async {
      await tester.pumpApp(HistoryScreen());
      await tester.pumpAndSettle();

      expect(find.text('History'), findsOneWidget);
    });

    testWidgets('shows empty state when no history', (tester) async {
      await tester.pumpApp(HistoryScreen());
      await tester.pumpAndSettle();

      expect(find.text('No history yet'), findsOneWidget);
      expect(
        find.text('Complete your first chore to start building your streak!'),
        findsOneWidget,
      );
    });

    testWidgets('has history icon in empty state', (tester) async {
      await tester.pumpApp(HistoryScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.history), findsOneWidget);
    });
  });
}
