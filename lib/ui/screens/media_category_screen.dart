import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controllers/media_controller.dart';
import '../../models/media_item.dart';
import '../../l10n/app_localizations.dart';
import 'audio_player_screen.dart';
import 'video_player_screen.dart';
import 'photo_viewer_screen.dart';

class MediaCategoryScreen extends StatelessWidget {
  const MediaCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaCategory category =
        ModalRoute.of(context)!.settings.arguments as MediaCategory;
    return ChangeNotifierProvider(
      create: (_) => MediaController()..load(),
      child: _MediaCategoryView(category: category),
    );
  }
}

class _MediaCategoryView extends StatelessWidget {
  const _MediaCategoryView({required this.category});
  final MediaCategory category;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MediaController>();
    final items = controller.itemsForCategory(category.id);
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.t(category.titleKey))),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.78,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _ItemCard(item: item, allItems: items);
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.allItems});
  final MediaItem item;
  final List<MediaItem> allItems;

  void _openMedia(BuildContext context) {
    switch (item.type) {
      case MediaType.audio:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AudioPlayerScreen(mediaItem: item, playlist: allItems),
          ),
        );
        break;
      case MediaType.video:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VideoPlayerScreen(mediaItem: item, playlist: allItems),
          ),
        );
        break;
      case MediaType.photo:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PhotoViewerScreen(mediaItem: item, gallery: allItems),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _openMedia(context),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cs.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image
                    item.thumbnailUrl.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: item.thumbnailUrl,
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
                                _getIconForType(item.type),
                                size: 40,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          )
                        : Image.asset(
                            item.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: cs.surfaceVariant,
                                child: Icon(
                                  _getIconForType(item.type),
                                  size: 40,
                                  color: cs.onSurfaceVariant,
                                ),
                              );
                            },
                          ),

                    // Overlay icon
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getPlayIconForType(item.type),
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(MediaType type) {
    switch (type) {
      case MediaType.audio:
        return Icons.music_note;
      case MediaType.video:
        return Icons.videocam;
      case MediaType.photo:
        return Icons.photo;
    }
  }

  IconData _getPlayIconForType(MediaType type) {
    switch (type) {
      case MediaType.audio:
        return Icons.play_circle_filled;
      case MediaType.video:
        return Icons.play_circle_filled;
      case MediaType.photo:
        return Icons.photo_library;
    }
  }
}
