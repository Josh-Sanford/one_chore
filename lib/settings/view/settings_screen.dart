import 'package:flutter/material.dart';
import 'package:one_chore/core/theme/spacing.dart';
import 'package:one_chore/l10n/l10n.dart';

/// Settings screen for app configuration.
///
/// Allows users to configure notifications, theme,
/// and other app preferences.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsScreenTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _SettingsSection(
            title: l10n.settingsNotificationsSection,
            children: [
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: l10n.settingsDailyReminder,
                subtitle: l10n.comingSoon,
                trailing: const Switch(
                  value: false,
                  onChanged: null,
                ),
                isDisabled: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SettingsSection(
            title: l10n.settingsAppearanceSection,
            children: [
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: l10n.settingsTheme,
                subtitle: l10n.comingSoon,
                trailing: const Icon(Icons.chevron_right),
                isDisabled: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SettingsSection(
            title: l10n.settingsAboutSection,
            children: [
              _SettingsTile(
                icon: Icons.info_outline,
                title: l10n.settingsVersion,
                subtitle: '1.0.0',
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
