import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';

/// A large, prominent action button with optional loading state.
///
/// Used for primary actions like "Mark Complete", "Add Chore", etc.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.isLoading = false,
    this.icon,
  });

  /// Callback when button is pressed. Disabled when [isLoading] is true.
  final VoidCallback? onPressed;

  /// The button label text.
  final String label;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Optional icon to display before the label.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: theme.colorScheme.onPrimary,
              ),
            )
          : icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20),
                    AppSpacing.sm.horizontalSpace,
                    Text(label),
                  ],
                )
              : Text(label),
    );
  }
}
