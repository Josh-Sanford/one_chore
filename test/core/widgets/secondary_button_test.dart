import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/widgets/secondary_button.dart';

void main() {
  group('SecondaryButton', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
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
            body: SecondaryButton(
              onPressed: () => pressed = true,
              label: 'Test Button',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SecondaryButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when onPressed is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              onPressed: null,
              label: 'Disabled Button',
            ),
          ),
        ),
      );

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              onPressed: () {},
              label: 'Icon Button',
              icon: Icons.close,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
    });

    testWidgets('does not render icon when not provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              onPressed: () {},
              label: 'No Icon Button',
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
      expect(find.text('No Icon Button'), findsOneWidget);
    });

    testWidgets('has minimum height of 48', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              onPressed: () {},
              label: 'Sized Button',
            ),
          ),
        ),
      );

      final button = tester.getSize(find.byType(OutlinedButton));
      expect(button.height, greaterThanOrEqualTo(48));
    });

    testWidgets('expands to full width', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SecondaryButton(
                onPressed: () {},
                label: 'Full Width Button',
              ),
            ),
          ),
        ),
      );

      final scaffoldWidth = tester.getSize(find.byType(Scaffold)).width;
      final buttonWidth = tester.getSize(find.byType(OutlinedButton)).width;

      // Button should expand to available width (minus padding)
      expect(buttonWidth, equals(scaffoldWidth - 32));
    });

    testWidgets('uses OutlinedButton style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SecondaryButton(
              onPressed: () {},
              label: 'Outlined Button',
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });
}
