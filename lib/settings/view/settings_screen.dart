import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/l10n/l10n.dart';
import 'package:one_chore/settings/providers/app_version_provider.dart';

/// Settings screen for app configuration.
///
/// Allows users to configure notifications, theme,
/// and other app preferences.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final versionAsync = ref.watch(appVersionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsScreenTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _SettingsSection(
            title: context.l10n.settingsNotificationsSection,
            children: [
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: context.l10n.settingsDailyReminder,
                subtitle: context.l10n.comingSoon,
                trailing: const Switch(
                  value: false,
                  onChanged: null, // Disabled until Phase 4
                ),
                isDisabled: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SettingsSection(
            title: context.l10n.settingsAppearanceSection,
            children: [
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: context.l10n.settingsTheme,
                subtitle: context.l10n.comingSoon,
                trailing: Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                isDisabled: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SettingsSection(
            title: context.l10n.settingsAboutSection,
            children: [
              _SettingsTile(
                icon: Icons.info_outline,
                title: context.l10n.settingsVersion,
                subtitle: versionAsync.when(
                  data: (version) => version,
                  loading: () => '...',
                  error: (error, stack) => '1.0.0',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.isDisabled = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing,
        enabled: !isDisabled,
      ),
    );
  }
}
