import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/historical_sites_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/asset_image.dart';
import '../../services/favorites_service.dart';
import '../../models/favorite.dart';

class HistoricalSitesScreen extends StatelessWidget {
  const HistoricalSitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoricalSitesController()..load(),
      child: const _HistoricalSitesView(),
    );
  }
}

class _HistoricalSitesView extends StatelessWidget {
  const _HistoricalSitesView();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final controller = context.watch<HistoricalSitesController>();
    final sites = controller.sites;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.t('home_sites_title')),
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.setQuery,
              decoration: InputDecoration(
                hintText: 'Search historical sites...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Explore the rich history and natural beauty of Hadiya, Ethiopia. From ancient stelae to stunning landscapes, there's something for everyone.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: sites.length,
              itemBuilder: (context, index) {
                final s = sites[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AssetImageOrSvg(s.imageAsset, fit: BoxFit.cover),
                            // Map quick action
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: _MapQuickButton(
                                tooltip: 'Open in Google Maps',
                                onTap: () {
                                  final lat = s.latitude, lng = s.longitude;
                                  if (lat != null && lng != null) {
                                    _openMap(lat, lng);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.t(s.nameKey),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  loc.t(s.subtitleKey),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[600]),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () => _showMapActions(
                                      context,
                                      s.latitude,
                                      s.longitude,
                                      loc.t(s.nameKey),
                                    ),
                                    icon: const Icon(Icons.map, size: 18),
                                    label: const Text('Map'),
                                  ),
                                  const Spacer(),
                                  Consumer<FavoritesService>(
                                    builder: (context, favs, _) {
                                      final favId = 'site:${s.id}';
                                      final isFav = favs.isFavorite(favId);
                                      return IconButton(
                                        tooltip: isFav
                                            ? 'Unfavorite'
                                            : 'Favorite',
                                        onPressed: () async {
                                          await favs.toggleFavorite(
                                            Favorite(
                                              id: favId,
                                              type: FavoriteType.site,
                                              title: loc.t(s.nameKey),
                                              subtitle: loc.t(s.subtitleKey),
                                              thumbnailUrl: s.imageAsset,
                                              addedDate: DateTime.now(),
                                            ),
                                          );
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  isFav
                                                      ? 'Removed from favorites'
                                                      : 'Added to favorites',
                                                ),
                                                duration: const Duration(
                                                  seconds: 1,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFav
                                              ? Colors.redAccent
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAllOnMap(context, sites),
                icon: const Icon(Icons.map),
                label: const Text('View All on Map'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMapActions(
    BuildContext context,
    double? lat,
    double? lng,
    String name,
  ) {
    if (lat == null || lng == null) return;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.place_outlined),
                title: const Text('View on Google Maps'),
                subtitle: Text(name),
                onTap: () async {
                  Navigator.pop(context);
                  await _openMap(lat, lng);
                },
              ),
              ListTile(
                leading: const Icon(Icons.directions),
                title: const Text('Start Directions'),
                onTap: () async {
                  Navigator.pop(context);
                  await _openDirections(lat, lng);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openMap(double lat, double lng) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openDirections(double lat, double lng) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _showAllOnMap(BuildContext context, List sites) async {
    if (sites.isEmpty) return;
    // For now open directions to the first site; could be expanded to a custom map with multiple pins.
    final first = sites.first;
    await _openMap(first.latitude, first.longitude);
  }
}

class _MapQuickButton extends StatelessWidget {
  const _MapQuickButton({required this.onTap, this.tooltip});
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip ?? 'Map',
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.9),
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.map, color: theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
