import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';

/// A consistent loading indicator widget.
///
/// Can be used as a full-screen loader or inline.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.message,
    this.size = LoadingIndicatorSize.medium,
  });

  /// Optional message to display below the spinner.
  final String? message;

  /// Size of the loading indicator.
  final LoadingIndicatorSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorSize = switch (size) {
      LoadingIndicatorSize.small => 20.0,
      LoadingIndicatorSize.medium => 36.0,
      LoadingIndicatorSize.large => 48.0,
    };

    final strokeWidth = switch (size) {
      LoadingIndicatorSize.small => 2.0,
      LoadingIndicatorSize.medium => 3.0,
      LoadingIndicatorSize.large => 4.0,
    };

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
            ),
          ),
          if (message != null) ...[
            AppSpacing.md.verticalSpace,
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Size options for the loading indicator.
enum LoadingIndicatorSize {
  /// Small size (20x20), for inline use.
  small,

  /// Medium size (36x36), default.
  medium,

  /// Large size (48x48), for full-screen loaders.
  large,
}
