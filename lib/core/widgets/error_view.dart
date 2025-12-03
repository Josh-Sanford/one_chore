import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';

/// An error display widget with message and retry button.
///
/// Used when an operation fails and the user can retry.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    super.key,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  /// The error message to display.
  final String message;

  /// Callback when retry button is pressed. If null, no retry button is shown.
  final VoidCallback? onRetry;

  /// The label for the retry button. Defaults to "Try Again".
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              'Something went wrong',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.sm.verticalSpace,
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              AppSpacing.lg.verticalSpace,
              FilledButton.tonal(
                onPressed: onRetry,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh, size: 18),
                    AppSpacing.sm.horizontalSpace,
                    Text(retryLabel),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
