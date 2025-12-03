import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/empty_state_widget.dart';

import 'golden_test_helper.dart';

void main() {
  group('EmptyStateWidget Golden Tests', () {
    testWidgets('with title only', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const EmptyStateWidget(
            icon: Icons.inbox,
            title: 'No items',
          ),
          size: const Size(400, 300),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/empty_state_title_only.png'),
      );
    });

    testWidgets('with message', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const EmptyStateWidget(
            icon: Icons.checklist,
            title: 'No chores yet',
            message: 'Add your first chore to get started!',
          ),
          size: const Size(400, 350),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/empty_state_with_message.png'),
      );
    });

    testWidgets('with action button', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          EmptyStateWidget(
            icon: Icons.checklist,
            title: 'No chores yet',
            message:
                'Add your first chore to get started on your one thing today!',
            actionLabel: 'Add Chore',
            onAction: () {},
          ),
          size: const Size(400, 400),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/empty_state_with_action.png'),
      );
    });
  });
}
