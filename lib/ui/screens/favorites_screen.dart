import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/favorites_controller.dart';
import '../../controllers/festival_controller.dart';
import '../../models/festival_event.dart';
import '../widgets/festival_card.dart';
import '../widgets/common_widgets.dart';
import 'festival_detail_screen.dart';

/// Screen showing user's favorite festivals
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesController _favoritesController;
  late FestivalController _festivalController;

  @override
  void initState() {
    super.initState();
    _favoritesController = FavoritesController()..loadFavorites();
    _festivalController = FestivalController()..load();
  }

  @override
  void dispose() {
    _favoritesController.dispose();
    _festivalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _favoritesController),
        ChangeNotifierProvider.value(value: _festivalController),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          actions: [
            Consumer<FavoritesController>(
              builder: (context, favController, _) {
                if (favController.favoriteIds.isEmpty) {
                  return const SizedBox.shrink();
                }

                return IconButton(
                  onPressed: () => _showClearDialog(context),
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Clear all',
                );
              },
            ),
          ],
        ),
        body: Consumer2<FavoritesController, FestivalController>(
          builder: (context, favController, festivalController, _) {
            if (festivalController.isLoading) {
              return const LoadingIndicator(message: 'Loading favorites...');
            }

            final favoriteFestivals = festivalController.allEvents
                .where((festival) => favController.isFavorite(festival.id))
                .toList();

            if (favoriteFestivals.isEmpty) {
              return EmptyState(
                icon: Icons.favorite_border,
                title: 'No Favorites Yet',
                message: 'Start exploring and add festivals to your favorites!',
                action: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate back or to explore
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.explore),
                  label: const Text('Explore Festivals'),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteFestivals.length,
              itemBuilder: (context, index) {
                final festival = favoriteFestivals[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FestivalCard(
                    festival: festival,
                    onTap: () => _navigateToDetail(context, festival),
                    trailing: IconButton(
                      onPressed: () =>
                          favController.removeFavorite(festival.id),
                      icon: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, FestivalEvent festival) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FestivalDetailScreen(festival: festival),
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites?'),
        content: const Text(
          'This will remove all festivals from your favorites. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _favoritesController.clearFavorites();
              Navigator.pop(context);
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
