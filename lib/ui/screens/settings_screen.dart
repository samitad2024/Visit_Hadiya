import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/providers/app_settings_provider.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final settings = context.watch<AppSettingsProvider>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(loc.t('settings_title')), elevation: 0),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 3,
        onDestinationSelected: (i) {
          if (i == 0) Navigator.of(context).pushReplacementNamed('/');
          if (i == 1) Navigator.of(context).pushReplacementNamed('/culture');
          if (i == 2) Navigator.of(context).pushReplacementNamed('/favorites');
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border_rounded),
            selectedIcon: Icon(Icons.bookmark_rounded),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Appearance Section
          _SectionHeader(
            loc.t('settings_general'),
            icon: Icons.palette_outlined,
          ),
          _SettingsCard(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.brightness_6_outlined,
                  iconColor: cs.primary,
                  title: 'Theme',
                  subtitle: _getThemeName(settings.themeMode),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _showThemeDialog(context, settings),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.language_outlined,
                  iconColor: cs.secondary,
                  title: loc.t('settings_language'),
                  subtitle: _getLanguageName(settings.languageCode),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _showLanguageDialog(context, settings),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.text_fields_outlined,
                  iconColor: cs.tertiary,
                  title: 'Text Size',
                  subtitle: _getTextSizeName(settings.textSize),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _showTextSizeDialog(context, settings),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Content & Data Section
          _SectionHeader('Content & Data', icon: Icons.data_usage_outlined),
          _SettingsCard(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.cloud_download_outlined,
                  iconColor: Colors.blue,
                  title: loc.t('settings_offline_title'),
                  subtitle: loc.t('settings_offline_sub'),
                  trailing: Switch(
                    value: settings.offlineMode,
                    onChanged: settings.setOfflineMode,
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  iconColor: Colors.orange,
                  title: loc.t('settings_notifications'),
                  subtitle: loc.t('settings_notifications_sub'),
                  trailing: Switch(
                    value: settings.notificationsEnabled,
                    onChanged: settings.setNotifications,
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.delete_outline,
                  iconColor: Colors.red,
                  title: 'Clear Cache',
                  subtitle: 'Free up storage space',
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _showClearCacheDialog(context, settings),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Support & Feedback Section
          _SectionHeader('Support & Feedback', icon: Icons.help_outline),
          _SettingsCard(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.star_outline,
                  iconColor: Colors.amber,
                  title: 'Rate App',
                  subtitle: 'Share your feedback',
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _rateApp(),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.share_outlined,
                  iconColor: Colors.green,
                  title: 'Share App',
                  subtitle: 'Tell others about Visit Hadiya',
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _shareApp(),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.bug_report_outlined,
                  iconColor: Colors.purple,
                  title: 'Report Issue',
                  subtitle: 'Help us improve',
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _reportIssue(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // About Section
          _SectionHeader(loc.t('settings_about'), icon: Icons.info_outline),
          _SettingsCard(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.article_outlined,
                  iconColor: cs.primary,
                  title: loc.t('settings_about_us'),
                  subtitle: loc.t('settings_about_us_sub'),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _showAboutDialog(context),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.people_outline,
                  iconColor: cs.secondary,
                  title: loc.t('settings_credits'),
                  subtitle: loc.t('settings_credits_sub'),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _showCreditsDialog(context),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  iconColor: cs.tertiary,
                  title: 'Privacy Policy',
                  subtitle: 'How we protect your data',
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _openPrivacyPolicy(),
                ),
                const Divider(height: 1, indent: 56),
                _SettingsTile(
                  icon: Icons.gavel_outlined,
                  iconColor: Colors.blueGrey,
                  title: 'Terms of Service',
                  subtitle: 'App usage terms',
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: cs.primary,
                  ),
                  onTap: () => _openTermsOfService(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // App Version
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.travel_explore,
                  size: 48,
                  color: cs.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  'Visit Hadiya',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '© 2025 Hadiya Heritage',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System Default';
    }
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'am':
        return 'አማርኛ (Amharic)';
      case 'hdy':
        return 'Hadiyigna';
      default:
        return 'English';
    }
  }

  String _getTextSizeName(TextSizeMode size) {
    switch (size) {
      case TextSizeMode.small:
        return 'Small';
      case TextSizeMode.medium:
        return 'Medium';
      case TextSizeMode.large:
        return 'Large';
    }
  }

  void _showThemeDialog(BuildContext context, AppSettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<AppThemeMode>(
              title: const Text('Light'),
              value: AppThemeMode.light,
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) settings.setThemeMode(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('Dark'),
              value: AppThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) settings.setThemeMode(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('System Default'),
              value: AppThemeMode.system,
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) settings.setThemeMode(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, AppSettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: settings.languageCode,
              onChanged: (value) {
                if (value != null) settings.setLanguage(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('አማርኛ (Amharic)'),
              value: 'am',
              groupValue: settings.languageCode,
              onChanged: (value) {
                if (value != null) settings.setLanguage(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Hadiyigna'),
              value: 'hdy',
              groupValue: settings.languageCode,
              onChanged: (value) {
                if (value != null) settings.setLanguage(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTextSizeDialog(BuildContext context, AppSettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Text Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<TextSizeMode>(
              title: const Text('Small', style: TextStyle(fontSize: 14)),
              value: TextSizeMode.small,
              groupValue: settings.textSize,
              onChanged: (value) {
                if (value != null) settings.setTextSize(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<TextSizeMode>(
              title: const Text('Medium', style: TextStyle(fontSize: 16)),
              value: TextSizeMode.medium,
              groupValue: settings.textSize,
              onChanged: (value) {
                if (value != null) settings.setTextSize(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile<TextSizeMode>(
              title: const Text('Large', style: TextStyle(fontSize: 18)),
              value: TextSizeMode.large,
              groupValue: settings.textSize,
              onChanged: (value) {
                if (value != null) settings.setTextSize(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCacheDialog(
    BuildContext context,
    AppSettingsProvider settings,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'Are you sure you want to clear cached data? This will free up storage space.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await settings.clearCache();
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cache cleared successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error clearing cache: $e')),
                  );
                }
              }
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Visit Hadiya'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Visit Hadiya is your comprehensive guide to exploring the rich history, vibrant culture, and stunning landscapes of the Hadiya people.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• Preserve and promote Hadiya heritage'),
              Text('• Connect communities through culture'),
              Text('• Educate future generations'),
              Text('• Support local tourism and economy'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCreditsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Credits'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Development Team',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• Hadiya Heritage Development Team'),
              SizedBox(height: 16),
              Text(
                'Content Contributors',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• Hadiya Cultural Center'),
              Text('• Local Historians and Elders'),
              Text('• Community Members'),
              SizedBox(height: 16),
              Text(
                'Special Thanks',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• All photographers and artists'),
              Text('• Community supporters'),
              Text('• Open source contributors'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _rateApp() {
    // Implement rate app functionality
    // In production, open app store link
  }

  void _shareApp() {
    Share.share(
      'Discover the rich heritage of Hadiya! Download Visit Hadiya app to explore history, culture, and more.',
      subject: 'Visit Hadiya App',
    );
  }

  void _reportIssue() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@visithadiya.com',
      queryParameters: {
        'subject': 'Visit Hadiya - Issue Report',
        'body': 'Please describe the issue:\n\n',
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _openPrivacyPolicy() async {
    final Uri url = Uri.parse('https://visithadiya.com/privacy');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _openTermsOfService() async {
    final Uri url = Uri.parse('https://visithadiya.com/terms');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (iconColor ?? cs.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: iconColor ?? cs.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );
  }
}
