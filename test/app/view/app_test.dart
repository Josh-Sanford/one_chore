// ignore_for_file: prefer_const_constructors, for testing flexibility

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/app/app.dart';
import 'package:one_chore/daily_chore/view/daily_chore_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders with bottom navigation', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('starts on Today screen', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      expect(find.byType(DailyChoreScreen), findsOneWidget);
    });

    testWidgets('has all five navigation items', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Chores'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Progress'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('navigates to Chores screen', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chores'));
      await tester.pumpAndSettle();

      expect(find.text('My Chores'), findsOneWidget);
    });

    testWidgets('navigates to History screen', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      expect(find.text('No history yet'), findsOneWidget);
    });

    testWidgets('navigates to Progress screen', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Progress'));
      await tester.pumpAndSettle();

      expect(find.text('No progress yet'), findsOneWidget);
    });

    testWidgets('navigates to Settings screen', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.text('Notifications'), findsOneWidget);
    });
  });
}
