import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/empty_state_widget.dart';

void main() {
  group('EmptyStateWidget', () {
    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
            ),
          ),
        ),
      );

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('renders message when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
              message: 'Add your first item to get started',
            ),
          ),
        ),
      );

      expect(find.text('Add your first item to get started'), findsOneWidget);
    });

    testWidgets('does not render message when not provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
            ),
          ),
        ),
      );

      // Only title text should be present, no message
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('renders action button when actionLabel and onAction provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
              actionLabel: 'Add Item',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('Add Item'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('calls onAction when action button is tapped', (tester) async {
      var actionCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
              actionLabel: 'Add Item',
              onAction: () => actionCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Add Item'));
      await tester.pump();

      expect(actionCalled, isTrue);
    });

    testWidgets('does not render action button when actionLabel is null',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('does not render action button when onAction is null',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
              actionLabel: 'Add Item',
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('uses Column with MainAxisSize.min for layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.inbox,
              title: 'No items',
            ),
          ),
        ),
      );

      // Verify the layout uses a Column
      expect(
        find.descendant(
          of: find.byType(EmptyStateWidget),
          matching: find.byType(Column),
        ),
        findsOneWidget,
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(EmptyStateWidget),
          matching: find.byType(Column),
        ),
      );
      expect(column.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('renders all elements together', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.list,
              title: 'No chores yet',
              message: 'Add a chore to get started on your one thing today',
              actionLabel: 'Add Chore',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.list), findsOneWidget);
      expect(find.text('No chores yet'), findsOneWidget);
      expect(
        find.text('Add a chore to get started on your one thing today'),
        findsOneWidget,
      );
      expect(find.text('Add Chore'), findsOneWidget);
    });
  });
}
