import 'package:flutter/widgets.dart';

/// App spacing constants following an 8pt grid system.
abstract class AppSpacing {
  /// Extra small spacing: 4pt
  static const double xs = 4;

  /// Small spacing: 8pt
  static const double sm = 8;

  /// Medium spacing: 16pt
  static const double md = 16;

  /// Large spacing: 24pt
  static const double lg = 24;

  /// Extra large spacing: 32pt
  static const double xlg = 32;

  /// Extra extra large spacing: 48pt
  static const double xxlg = 48;
}

/// Extension on [num] to create [SizedBox] with consistent spacing.
extension SpacingExtension on num {
  /// Creates a vertical [SizedBox] with height equal to this value.
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// Creates a horizontal [SizedBox] with width equal to this value.
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}

/// Extension on [BuildContext] for responsive spacing.
extension SpacingContext on BuildContext {
  /// Returns responsive padding based on screen width.
  EdgeInsets get responsiveHorizontalPadding {
    final width = MediaQuery.of(this).size.width;
    if (width > 600) {
      return const EdgeInsets.symmetric(horizontal: AppSpacing.xlg);
    }
    return const EdgeInsets.symmetric(horizontal: AppSpacing.md);
  }

  /// Returns responsive padding based on screen width.
  EdgeInsets get responsiveAllPadding {
    final width = MediaQuery.of(this).size.width;
    if (width > 600) {
      return const EdgeInsets.all(AppSpacing.xlg);
    }
    return const EdgeInsets.all(AppSpacing.md);
  }
}
