import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/error_view.dart';

import 'golden_test_helper.dart';

void main() {
  group('ErrorView Golden Tests', () {
    testWidgets('without retry button', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const ErrorView(
            message: 'Something went wrong while loading.',
          ),
          size: const Size(400, 350),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/error_view_no_retry.png'),
      );
    });

    testWidgets('with retry button', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          ErrorView(
            message: 'Failed to load your chores. Please try again.',
            onRetry: () {},
          ),
          size: const Size(400, 400),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/error_view_with_retry.png'),
      );
    });

    testWidgets('with custom retry label', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          ErrorView(
            message: 'Connection failed.',
            onRetry: () {},
            retryLabel: 'Reload',
          ),
          size: const Size(400, 400),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/error_view_custom_label.png'),
      );
    });
  });
}
