import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/primary_button.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () {},
              label: 'Test Button',
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () => pressed = true,
              label: 'Test Button',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when onPressed is null',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: null,
              label: 'Disabled Button',
            ),
          ),
        ),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('shows loading indicator when isLoading is true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () {},
              label: 'Loading Button',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
    });

    testWidgets('does not call onPressed when loading', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () => pressed = true,
              label: 'Loading Button',
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();

      expect(pressed, isFalse);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () {},
              label: 'Icon Button',
              icon: Icons.check,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
    });

    testWidgets('does not render icon when not provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () {},
              label: 'No Icon Button',
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
      expect(find.text('No Icon Button'), findsOneWidget);
    });

    testWidgets('has minimum height of 56', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              onPressed: () {},
              label: 'Sized Button',
            ),
          ),
        ),
      );

      final button = tester.getSize(find.byType(FilledButton));
      expect(button.height, greaterThanOrEqualTo(56));
    });

    testWidgets('expands to full width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                onPressed: () {},
                label: 'Full Width Button',
              ),
            ),
          ),
        ),
      );

      final scaffoldWidth = tester.getSize(find.byType(Scaffold)).width;
      final buttonWidth = tester.getSize(find.byType(FilledButton)).width;

      // Button should expand to available width (minus padding)
      expect(buttonWidth, equals(scaffoldWidth - 32));
    });
  });
}
