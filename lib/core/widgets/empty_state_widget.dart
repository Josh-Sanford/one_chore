import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';

/// A generic empty state widget with icon, message, and optional action.
///
/// Used when a list is empty or no data is available.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.icon,
    required this.title,
    super.key,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  /// The icon to display at the top.
  final IconData icon;

  /// The main title text.
  final String title;

  /// Optional description message below the title.
  final String? message;

  /// Optional action button label.
  final String? actionLabel;

  /// Callback for the action button. Required if [actionLabel] is provided.
  final VoidCallback? onAction;

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
              icon,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            AppSpacing.lg.verticalSpace,
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.sm.verticalSpace,
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.lg.verticalSpace,
              FilledButton.tonal(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
