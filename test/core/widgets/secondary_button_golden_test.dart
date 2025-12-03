import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/secondary_button.dart';

import 'golden_test_helper.dart';

void main() {
  group('SecondaryButton Golden Tests', () {
    testWidgets('default state', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          Padding(
            padding: const EdgeInsets.all(16),
            child: SecondaryButton(
              onPressed: () {},
              label: 'Cancel',
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/secondary_button_default.png'),
      );
    });

    testWidgets('with icon', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          Padding(
            padding: const EdgeInsets.all(16),
            child: SecondaryButton(
              onPressed: () {},
              label: "I'll Choose",
              icon: Icons.list,
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/secondary_button_with_icon.png'),
      );
    });

    testWidgets('disabled state', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const Padding(
            padding: EdgeInsets.all(16),
            child: SecondaryButton(
              onPressed: null,
              label: 'Disabled',
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/secondary_button_disabled.png'),
      );
    });
  });
}
