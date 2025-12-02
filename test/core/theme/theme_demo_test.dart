import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/theme/app_theme.dart';
import 'package:one_chore/core/theme/theme_demo.dart';

void main() {
  group('ThemeDemo', () {
    testWidgets('renders all theme elements', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const ThemeDemo(),
        ),
      );

      // Verify sections are present
      expect(find.text('Color Palette'), findsOneWidget);
      expect(find.text('Typography'), findsOneWidget);
      expect(find.text('Buttons'), findsOneWidget);
      expect(find.text('Cards'), findsOneWidget);
      expect(find.text('Spacing Scale'), findsOneWidget);

      // Verify colors
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Tertiary'), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);

      // Verify buttons
      expect(find.text('Elevated Button'), findsOneWidget);
      expect(find.text('Filled Button'), findsOneWidget);
      expect(find.text('Outlined Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);

      // Verify FAB
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('buttons are interactive', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: const ThemeDemo(),
        ),
      );

      // Find and tap elevated button
      final elevatedButton = find.text('Elevated Button');
      expect(elevatedButton, findsOneWidget);
      await tester.tap(elevatedButton);
      await tester.pump();

      // Verify no errors
      expect(tester.takeException(), isNull);
    });
  });
}
