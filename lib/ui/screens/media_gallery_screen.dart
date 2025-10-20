import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controllers/media_controller.dart';
import '../../l10n/app_localizations.dart';
import '../../models/media_item.dart';

class MediaGalleryScreen extends StatelessWidget {
  const MediaGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MediaController()..load(),
      child: const _MediaGalleryView(),
    );
  }
}

class _MediaGalleryView extends StatelessWidget {
  const _MediaGalleryView();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final controller = context.watch<MediaController>();
    // final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(loc.t('media_gallery_title')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          _Tabs(index: controller.tabIndex, onChanged: controller.setTab),
          const Divider(height: 1),
          Expanded(
            child: switch (controller.tabIndex) {
              0 => _TabContent(
                title: loc.t('media_audio_title'),
                categories: controller.audioCategories,
              ),
              1 => _TabContent(
                title: loc.t('media_video_title'),
                categories: controller.videoCategories,
              ),
              _ => _TabContent(
                title: loc.t('media_photos_title'),
                categories: controller.photoCategories,
              ),
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) {
          if (i == 0) Navigator.of(context).popUntil((r) => r.isFirst);
          if (i == 3) Navigator.of(context).pushNamed('/settings');
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border_rounded),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.index, required this.onChanged});
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    // final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        _TabButton(
          label: AppLocalizations.of(context).t('media_tab_audio'),
          selected: index == 0,
          onTap: () => onChanged(0),
        ),
        _TabButton(
          label: AppLocalizations.of(context).t('media_tab_video'),
          selected: index == 1,
          onTap: () => onChanged(1),
        ),
        _TabButton(
          label: AppLocalizations.of(context).t('media_tab_photos'),
          selected: index == 2,
          onTap: () => onChanged(2),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.label, required this.selected, this.onTap});
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: selected ? cs.primary : cs.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: selected ? 32 : 0,
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.title, required this.categories});
  final String title;
  final List<MediaCategory> categories;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final c in categories)
              _CategoryCard(
                category: c,
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed('/media/category', arguments: c);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, this.onTap});
  final MediaCategory category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 16 * 3) / 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: cs.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Image
                    if (category.imageUrl != null)
                      category.imageUrl!.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: category.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: cs.surfaceVariant,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: cs.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: cs.surfaceVariant,
                                child: Icon(
                                  switch (category.type) {
                                    MediaType.audio => Icons.headphones,
                                    MediaType.video => Icons.play_circle,
                                    MediaType.photo =>
                                      Icons.photo_library_rounded,
                                  },
                                  size: 40,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            )
                          : Image.asset(
                              category.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: cs.surfaceVariant,
                                  child: Icon(
                                    switch (category.type) {
                                      MediaType.audio => Icons.headphones,
                                      MediaType.video => Icons.play_circle,
                                      MediaType.photo =>
                                        Icons.photo_library_rounded,
                                    },
                                    size: 40,
                                    color: cs.onSurfaceVariant,
                                  ),
                                );
                              },
                            ),

                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),

                    // Icon
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          switch (category.type) {
                            MediaType.audio => Icons.headphones,
                            MediaType.video => Icons.play_circle,
                            MediaType.photo => Icons.photo_library_rounded,
                          },
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                loc.t(category.titleKey),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
