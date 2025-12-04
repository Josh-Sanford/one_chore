import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';

/// Chore list screen showing all pending chores.
///
/// Users can add, edit, and delete chores from this screen.
/// They can also select a chore to be today's daily chore.
class ChoreListScreen extends StatelessWidget {
  const ChoreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chores'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.checklist,
            title: 'No chores yet',
            message:
                'Add your first chore to get started. '
                'Remember, just one at a time!',
            actionLabel: 'Add a Chore',
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
