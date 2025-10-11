import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/settings_controller.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsController(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final c = context.watch<SettingsController>();
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('settings_title'))),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 3,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border_rounded),
            label: 'Saved',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _SectionHeader(loc.t('settings_general')),
          _Tile(
            title: loc.t('settings_language'),
            subtitle: loc.t('settings_language_value'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {},
          ),
          const Divider(height: 1),
          SwitchListTile(
            value: c.offline,
            onChanged: c.toggleOffline,
            title: Text(loc.t('settings_offline_title')),
            subtitle: Text(loc.t('settings_offline_sub')),
          ),
          const Divider(height: 24),
          _Tile(
            title: loc.t('settings_notifications'),
            subtitle: loc.t('settings_notifications_sub'),
            trailing: Switch(
              value: c.notifications,
              onChanged: c.toggleNotifications,
            ),
          ),
          const SizedBox(height: 16),
          _SectionHeader(loc.t('settings_account')),
          _Tile(
            title: loc.t('settings_account_details'),
            subtitle: loc.t('settings_account_details_sub'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const SizedBox(height: 16),
          _SectionHeader(loc.t('settings_about')),
          _Tile(
            title: loc.t('settings_about_us'),
            subtitle: loc.t('settings_about_us_sub'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const Divider(height: 1),
          _Tile(
            title: loc.t('settings_credits'),
            subtitle: loc.t('settings_credits_sub'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
    ),
  );
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
