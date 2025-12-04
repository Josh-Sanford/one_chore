// ignore_for_file: prefer_const_constructors, for testing flexibility

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/chore_list/view/chore_list_screen.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ChoreListScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays correct app bar title', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      expect(find.text('My Chores'), findsOneWidget);
    });

    testWidgets('shows empty state when no chores', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      expect(find.text('No chores yet'), findsOneWidget);
      expect(
        find.text(
          'Add your first chore to get started. Remember, just one at a time!',
        ),
        findsOneWidget,
      );
    });

    testWidgets('shows Add a Chore action button in empty state', (
      tester,
    ) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      expect(find.text('Add a Chore'), findsOneWidget);
    });

    testWidgets('has floating action button', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('has checklist icon in empty state', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.checklist), findsOneWidget);
    });

    testWidgets('empty state action button can be tapped', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      // Tap the "Add a Chore" button in empty state
      await tester.tap(find.text('Add a Chore'));
      await tester.pumpAndSettle();

      // Button should be tappable without error (action is TODO for Phase 2)
      expect(find.byType(ChoreListScreen), findsOneWidget);
    });

    testWidgets('floating action button can be tapped', (tester) async {
      await tester.pumpApp(ChoreListScreen());
      await tester.pumpAndSettle();

      // Tap the FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // FAB should be tappable without error (action is TODO for Phase 2)
      expect(find.byType(ChoreListScreen), findsOneWidget);
    });
  });
}
