import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/core/widgets/widgets.dart';
import 'package:one_chore/l10n/l10n.dart';

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
        title: Text(context.l10n.historyScreenTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: EmptyStateWidget(
            icon: Icons.history,
            title: context.l10n.noHistoryTitle,
            message: context.l10n.noHistoryMessage,
          ),
        ),
      ),
    );
  }
}
