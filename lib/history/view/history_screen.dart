import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';

/// History screen showing completed chores.
///
/// Displays a list of previously completed chores
/// along with completion dates and streaks.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.history,
            title: 'No history yet',
            message: 'Complete your first chore to start building your streak!',
          ),
        ),
      ),
    );
  }
}
