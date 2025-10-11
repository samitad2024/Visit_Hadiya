import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/media_controller.dart';
import '../../models/media_item.dart';
import '../../l10n/app_localizations.dart';

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
    // final cs = Theme.of(context).colorScheme;
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
          return _ItemCard(item: item);
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});
  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        // Stub: show bottom sheet preview
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(switch (item.type) {
                        MediaType.audio => Icons.headphones,
                        MediaType.video => Icons.play_circle,
                        MediaType.photo => Icons.photo,
                      }, color: cs.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.subtitle ?? 'Preview not implemented yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check),
                      label: const Text('Close'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: cs.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                switch (item.type) {
                  MediaType.audio => Icons.graphic_eq,
                  MediaType.video => Icons.ondemand_video,
                  MediaType.photo => Icons.photo,
                },
                color: cs.onSurfaceVariant,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
