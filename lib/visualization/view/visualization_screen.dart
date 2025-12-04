import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';

/// Visualization screen showing progress charts.
///
/// Displays a timeline chart showing completed vs projected chores,
/// streaks, and other progress statistics.
class VisualizationScreen extends StatelessWidget {
  const VisualizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.bar_chart,
            title: 'No progress yet',
            message: 'Complete some chores to see your progress over time.',
          ),
        ),
      ),
    );
  }
}
