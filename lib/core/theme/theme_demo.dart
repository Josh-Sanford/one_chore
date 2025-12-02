import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';

/// Demo screen to visualize the theme.
/// This is temporary and will be removed once we have real UI.
class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OneChore Theme Demo'),
      ),
      body: SingleChildScrollView(
        padding: context.responsiveAllPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Color Palette
            Text(
              'Color Palette',
              style: theme.textTheme.headlineMedium,
            ),
            AppSpacing.md.verticalSpace,
            _ColorSwatch(
              label: 'Primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
            ),
            AppSpacing.sm.verticalSpace,
            _ColorSwatch(
              label: 'Secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
            ),
            AppSpacing.sm.verticalSpace,
            _ColorSwatch(
              label: 'Tertiary',
              color: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
            ),
            AppSpacing.sm.verticalSpace,
            _ColorSwatch(
              label: 'Error',
              color: colorScheme.error,
              onColor: colorScheme.onError,
            ),
            AppSpacing.xlg.verticalSpace,

            // Typography
            Text('Typography', style: theme.textTheme.headlineMedium),
            AppSpacing.md.verticalSpace,
            Text('Display Large', style: theme.textTheme.displayLarge),
            Text('Headline Large', style: theme.textTheme.headlineLarge),
            Text('Headline Medium', style: theme.textTheme.headlineMedium),
            Text('Title Large', style: theme.textTheme.titleLarge),
            Text('Body Large', style: theme.textTheme.bodyLarge),
            Text('Body Medium', style: theme.textTheme.bodyMedium),
            Text('Label Small', style: theme.textTheme.labelSmall),
            AppSpacing.xlg.verticalSpace,

            // Buttons
            Text('Buttons', style: theme.textTheme.headlineMedium),
            AppSpacing.md.verticalSpace,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            AppSpacing.sm.verticalSpace,
            FilledButton(
              onPressed: () {},
              child: const Text('Filled Button'),
            ),
            AppSpacing.sm.verticalSpace,
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            AppSpacing.sm.verticalSpace,
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            AppSpacing.xlg.verticalSpace,

            // Cards
            Text('Cards', style: theme.textTheme.headlineMedium),
            AppSpacing.md.verticalSpace,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sample Card',
                      style: theme.textTheme.titleLarge,
                    ),
                    AppSpacing.sm.verticalSpace,
                    Text(
                      'This demonstrates the card styling with Material 3 '
                      'elevation and rounded corners.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.xlg.verticalSpace,

            // Spacing
            Text('Spacing Scale', style: theme.textTheme.headlineMedium),
            AppSpacing.md.verticalSpace,
            _SpacingDemo(label: 'xs (4pt)', spacing: AppSpacing.xs),
            _SpacingDemo(label: 'sm (8pt)', spacing: AppSpacing.sm),
            _SpacingDemo(label: 'md (16pt)', spacing: AppSpacing.md),
            _SpacingDemo(label: 'lg (24pt)', spacing: AppSpacing.lg),
            _SpacingDemo(label: 'xlg (32pt)', spacing: AppSpacing.xlg),
            _SpacingDemo(label: 'xxlg (48pt)', spacing: AppSpacing.xxlg),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.label,
    required this.color,
    required this.onColor,
  });

  final String label;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: onColor,
            ),
      ),
    );
  }
}

class _SpacingDemo extends StatelessWidget {
  const _SpacingDemo({
    required this.label,
    required this.spacing,
  });

  final String label;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label),
          ),
          Container(
            width: spacing,
            height: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
