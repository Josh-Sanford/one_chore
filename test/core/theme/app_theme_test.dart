import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    group('light theme', () {
      late ThemeData theme;

      setUp(() {
        theme = AppTheme.light;
      });

      test('uses Material 3', () {
        expect(theme.useMaterial3, isTrue);
      });

      test('has light brightness', () {
        expect(theme.brightness, Brightness.light);
      });

      test('has correct color scheme brightness', () {
        expect(theme.colorScheme.brightness, Brightness.light);
      });

      test('has rounded button shapes', () {
        final elevatedStyle = theme.elevatedButtonTheme.style;
        final shape = elevatedStyle?.shape?.resolve({});
        expect(shape, isA<RoundedRectangleBorder>());
        expect(
          (shape! as RoundedRectangleBorder).borderRadius,
          BorderRadius.circular(12),
        );
      });

      test('has rounded card shape', () {
        expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
        expect(
          (theme.cardTheme.shape! as RoundedRectangleBorder).borderRadius,
          BorderRadius.circular(12),
        );
      });

      test('has centered app bar', () {
        expect(theme.appBarTheme.centerTitle, isTrue);
      });

      test('has fixed bottom navigation type', () {
        expect(
          theme.bottomNavigationBarTheme.type,
          BottomNavigationBarType.fixed,
        );
      });
    });

    group('dark theme', () {
      late ThemeData theme;

      setUp(() {
        theme = AppTheme.dark;
      });

      test('uses Material 3', () {
        expect(theme.useMaterial3, isTrue);
      });

      test('has dark brightness', () {
        expect(theme.brightness, Brightness.dark);
      });

      test('has correct color scheme brightness', () {
        expect(theme.colorScheme.brightness, Brightness.dark);
      });

      test('has rounded button shapes', () {
        final elevatedStyle = theme.elevatedButtonTheme.style;
        final shape = elevatedStyle?.shape?.resolve({});
        expect(shape, isA<RoundedRectangleBorder>());
        expect(
          (shape! as RoundedRectangleBorder).borderRadius,
          BorderRadius.circular(12),
        );
      });

      test('has rounded card shape', () {
        expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
        expect(
          (theme.cardTheme.shape! as RoundedRectangleBorder).borderRadius,
          BorderRadius.circular(12),
        );
      });

      test('has centered app bar', () {
        expect(theme.appBarTheme.centerTitle, isTrue);
      });

      test('has fixed bottom navigation type', () {
        expect(
          theme.bottomNavigationBarTheme.type,
          BottomNavigationBarType.fixed,
        );
      });
    });

    test('light and dark themes have different color schemes', () {
      final lightTheme = AppTheme.light;
      final darkTheme = AppTheme.dark;

      expect(
        lightTheme.colorScheme.brightness,
        isNot(equals(darkTheme.colorScheme.brightness)),
      );
    });
  });
}
