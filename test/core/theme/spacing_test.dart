import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/theme/spacing.dart';

void main() {
  group('AppSpacing', () {
    test('has correct spacing values', () {
      expect(AppSpacing.xs, 4);
      expect(AppSpacing.sm, 8);
      expect(AppSpacing.md, 16);
      expect(AppSpacing.lg, 24);
      expect(AppSpacing.xlg, 32);
      expect(AppSpacing.xxlg, 48);
    });
  });

  group('SpacingExtension', () {
    test('verticalSpace creates SizedBox with correct height', () {
      final space = 16.verticalSpace;
      expect(space, isA<SizedBox>());
      expect(space.height, 16);
      expect(space.width, isNull);
    });

    test('horizontalSpace creates SizedBox with correct width', () {
      final space = 24.horizontalSpace;
      expect(space, isA<SizedBox>());
      expect(space.width, 24);
      expect(space.height, isNull);
    });

    test('works with double values', () {
      final space = 12.5.verticalSpace;
      expect(space.height, 12.5);
    });
  });

  group('SpacingContext', () {
    testWidgets('responsiveHorizontalPadding for small screen', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: Builder(
            builder: (context) {
              final padding = context.responsiveHorizontalPadding;
              expect(
                padding,
                const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('responsiveHorizontalPadding for large screen', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(800, 1200)),
          child: Builder(
            builder: (context) {
              final padding = context.responsiveHorizontalPadding;
              expect(
                padding,
                const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('responsiveAllPadding for small screen', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: Builder(
            builder: (context) {
              final padding = context.responsiveAllPadding;
              expect(padding, const EdgeInsets.all(AppSpacing.md));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('responsiveAllPadding for large screen', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(800, 1200)),
          child: Builder(
            builder: (context) {
              final padding = context.responsiveAllPadding;
              expect(padding, const EdgeInsets.all(AppSpacing.xlg));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
