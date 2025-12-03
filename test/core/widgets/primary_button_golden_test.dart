import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/primary_button.dart';

import 'golden_test_helper.dart';

void main() {
  group('PrimaryButton Golden Tests', () {
    testWidgets('default state', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              onPressed: () {},
              label: 'Mark Complete',
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/primary_button_default.png'),
      );
    });

    testWidgets('with icon', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              onPressed: () {},
              label: 'Add Chore',
              icon: Icons.add,
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/primary_button_with_icon.png'),
      );
    });

    testWidgets('loading state', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              onPressed: () {},
              label: 'Loading...',
              isLoading: true,
            ),
          ),
        ),
      );

      // Let the progress indicator render
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/primary_button_loading.png'),
      );
    });

    testWidgets('disabled state', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const Padding(
            padding: EdgeInsets.all(16),
            child: PrimaryButton(
              onPressed: null,
              label: 'Disabled',
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/primary_button_disabled.png'),
      );
    });
  });
}
