import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';
import 'package:one_chore/l10n/l10n.dart';

/// Chore list screen showing all pending chores.
///
/// Users can add, edit, and delete chores from this screen.
/// They can also select a chore to be today's daily chore.
class ChoreListScreen extends StatelessWidget {
  const ChoreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.choresScreenTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.checklist,
            title: l10n.noChoresTitle,
            message: l10n.noChoresMessage,
            actionLabel: l10n.addChoreAction,
            onAction: () {
              // TODO(Phase2): Open add chore dialog.
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO(Phase2): Open add chore dialog.
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
