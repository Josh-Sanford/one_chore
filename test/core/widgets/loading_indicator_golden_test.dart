import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/loading_indicator.dart';

import 'golden_test_helper.dart';

void main() {
  group('LoadingIndicator Golden Tests', () {
    testWidgets('small size', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const LoadingIndicator(size: LoadingIndicatorSize.small),
          size: const Size(200, 100),
        ),
      );

      // Pump to render the progress indicator at a consistent state
      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/loading_indicator_small.png'),
      );
    });

    testWidgets('medium size (default)', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const LoadingIndicator(),
          size: const Size(200, 100),
        ),
      );

      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/loading_indicator_medium.png'),
      );
    });

    testWidgets('large size', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const LoadingIndicator(size: LoadingIndicatorSize.large),
          size: const Size(200, 120),
        ),
      );

      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/loading_indicator_large.png'),
      );
    });

    testWidgets('with message', (tester) async {
      await tester.pumpWidget(
        goldenTestWrapper(
          const LoadingIndicator(
            size: LoadingIndicatorSize.large,
            message: 'Loading your chores...',
          ),
          size: const Size(300, 180),
        ),
      );

      await tester.pump();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/loading_indicator_with_message.png'),
      );
    });
  });
}
