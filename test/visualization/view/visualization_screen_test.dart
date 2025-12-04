// ignore_for_file: prefer_const_constructors, for testing flexibility

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/visualization/view/visualization_screen.dart';

import '../../helpers/helpers.dart';

void main() {
  group('VisualizationScreen', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(VisualizationScreen());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays correct app bar title', (tester) async {
      await tester.pumpApp(VisualizationScreen());
      await tester.pumpAndSettle();

      expect(find.text('Progress'), findsOneWidget);
    });

    testWidgets('shows empty state when no progress', (tester) async {
      await tester.pumpApp(VisualizationScreen());
      await tester.pumpAndSettle();

      expect(find.text('No progress yet'), findsOneWidget);
      expect(
        find.text('Complete some chores to see your progress over time.'),
        findsOneWidget,
      );
    });

    testWidgets('has bar_chart icon in empty state', (tester) async {
      await tester.pumpApp(VisualizationScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.bar_chart), findsOneWidget);
    });
  });
}
