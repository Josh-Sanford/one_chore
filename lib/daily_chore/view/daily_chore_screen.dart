import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';
import 'package:one_chore/l10n/l10n.dart';

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
        title: Text(context.l10n.todayScreenTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.task_alt,
            title: context.l10n.noChoreSelectedTitle,
            message: context.l10n.noChoreSelectedMessage,
            actionLabel: context.l10n.selectChoreAction,
            onAction: () {
              // TODO(Phase2): Navigate to chore list or show selection.
            },
          ),
        ),
      ),
    );
  }
}
