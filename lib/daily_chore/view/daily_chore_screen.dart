import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';

/// Daily chore screen - the main home screen.
///
/// This screen displays the user's one chore for today
/// and allows them to mark it as complete.
class DailyChoreScreen extends StatelessWidget {
  const DailyChoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Chore"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.task_alt,
            title: 'No chore selected',
            message: 'Select a chore from your list to focus on today.',
            actionLabel: 'Select a Chore',
            onAction: () {
              // TODO(Phase2): Navigate to chore list or show selection.
            },
          ),
        ),
      ),
    );
  }
}
