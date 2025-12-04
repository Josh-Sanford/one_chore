// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders with bottom navigation', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      // Verify bottom navigation bar is present
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('starts on Today screen', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      // Verify Today's Chore screen is shown
      expect(find.text("Today's Chore"), findsOneWidget);
    });

    testWidgets('has all five navigation items', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      // Verify all navigation items are present
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Chores'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Progress'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });
  });
}
