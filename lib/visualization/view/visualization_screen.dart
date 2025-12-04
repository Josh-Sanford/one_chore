import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';
import 'package:one_chore/l10n/l10n.dart';

/// Visualization screen showing progress charts.
///
/// Displays a timeline chart showing completed vs projected chores,
/// streaks, and other progress statistics.
class VisualizationScreen extends StatelessWidget {
  const VisualizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.progressScreenTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.bar_chart,
            title: l10n.noProgressTitle,
            message: l10n.noProgressMessage,
          ),
        ),
      ),
    );
  }
}
