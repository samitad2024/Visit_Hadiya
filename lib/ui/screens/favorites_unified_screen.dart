import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/favorites_service.dart';
import '../../models/favorite.dart';

class FavoritesUnifiedScreen extends StatelessWidget {
  const FavoritesUnifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesService>().favorites.values.toList()
      ..sort((a, b) => b.addedDate.compareTo(a.addedDate));
    final media = favs.where((f) => f.type == FavoriteType.media).toList();
    final festivals = favs
        .where((f) => f.type == FavoriteType.festival)
        .toList();
    final sites = favs.where((f) => f.type == FavoriteType.site).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          if (favs.isNotEmpty)
            IconButton(
              tooltip: 'Clear all',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear all favorites?'),
                    content: const Text('This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
                if (confirm == true && context.mounted) {
                  await context.read<FavoritesService>().clearFavorites();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Favorites cleared')),
                  );
                }
              },
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: favs.isEmpty
          ? const _EmptyFavorites()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                if (media.isNotEmpty)
                  _FavoritesSection(title: 'Media', items: media),
                if (festivals.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _FavoritesSection(title: 'Festivals', items: festivals),
                ],
                if (sites.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _FavoritesSection(title: 'Sites', items: sites),
                ],
              ],
            ),
    );
  }
}

class _FavoritesSection extends StatelessWidget {
  const _FavoritesSection({required this.title, required this.items});
  final String title;
  final List<Favorite> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final f in items)
              SizedBox(
                width: 160,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: cs.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {}, // TODO: navigate to detail if needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: _FavoriteThumbnail(url: f.thumbnailUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                f.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              if (f.subtitle != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  f.subtitle!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: cs.onSurfaceVariant),
                                ),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    switch (f.type) {
                                      FavoriteType.media => Icons.play_arrow,
                                      FavoriteType.festival =>
                                        Icons.celebration,
                                      FavoriteType.site => Icons.place_outlined,
                                    },
                                    size: 16,
                                    color: cs.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    switch (f.type) {
                                      FavoriteType.media => 'Media',
                                      FavoriteType.festival => 'Festival',
                                      FavoriteType.site => 'Site',
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: cs.primary),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    tooltip: 'Remove',
                                    onPressed: () => context
                                        .read<FavoritesService>()
                                        .toggleFavorite(f),
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.redAccent,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _FavoriteThumbnail extends StatelessWidget {
  const _FavoriteThumbnail({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('http')) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(context),
      );
    }
    return Image.asset(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _fallback(context),
    );
  }

  Widget _fallback(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    child: const Icon(Icons.image, size: 32),
  );
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: cs.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              'No favorites yet',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Save media, festivals and sites to see them here.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
