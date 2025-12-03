import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/app_theme.dart';

/// Wraps a widget for golden testing with consistent theming and sizing.
Widget goldenTestWrapper(Widget child, {Size size = const Size(400, 200)}) {
  return MaterialApp(
    theme: AppTheme.dark,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: child,
        ),
      ),
    ),
  );
}
