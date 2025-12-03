import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';

/// A subtle action button for secondary actions.
///
/// Used for actions like "Cancel", "Skip", "I'll choose", etc.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.icon,
  });

  /// Callback when button is pressed.
  final VoidCallback? onPressed;

  /// The button label text.
  final String label;

  /// Optional icon to display before the label.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(
          color: theme.colorScheme.outline,
        ),
        textStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18),
                AppSpacing.sm.horizontalSpace,
                Text(label),
              ],
            )
          : Text(label),
    );
  }
}
