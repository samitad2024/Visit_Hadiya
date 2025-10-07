import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../controllers/icons_controller.dart';
import '../../l10n/app_localizations.dart';
import '../../models/person_icon.dart';
import 'icon_detail_screen.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IconsController()..load(),
      child: const _IconsView(),
    );
  }
}

class _IconsView extends StatelessWidget {
  const _IconsView();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final controller = context.watch<IconsController>();
    return Scaffold(
      appBar: AppBar(title: Text(loc.t('icons_title'))),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          TextField(
            onChanged: controller.setQuery,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: loc.t('icons_search_hint'),
            ),
          ),
          const SizedBox(height: 20),
          _Section(title: loc.t('icons_leaders'), items: controller.leaders),
          const SizedBox(height: 20),
          _Section(title: loc.t('icons_warriors'), items: controller.warriors),
          const SizedBox(height: 20),
          _Section(title: loc.t('icons_cultural'), items: controller.cultural),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});
  final String title;
  final List<PersonIcon> items;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 520;
            final crossAxisCount = isWide ? 3 : 2;
            final width =
                (constraints.maxWidth - (crossAxisCount - 1) * 12) /
                crossAxisCount;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final p in items)
                  SizedBox(
                    width: width,
                    child: _IconTile(
                      name: loc.t(p.nameKey),
                      subtitle: loc.t(p.subtitleKey),
                      asset: p.imageAsset,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => IconDetailScreen(
                            title: loc.t(p.nameKey),
                            subtitle: loc.t(p.subtitleKey),
                            asset: p.imageAsset,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({
    required this.name,
    required this.subtitle,
    required this.asset,
    required this.onTap,
  });
  final String name;
  final String subtitle;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.asset(asset, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
