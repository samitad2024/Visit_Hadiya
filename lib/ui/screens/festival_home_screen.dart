import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../controllers/festival_controller.dart';
import '../../controllers/favorites_controller.dart';
import '../../models/festival_event.dart';
import '../widgets/festival_card.dart';
import '../widgets/common_widgets.dart';
import 'festival_list_screen.dart';
import 'festival_detail_screen.dart';
import 'calendar_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/app_bottom_navigation.dart';

/// Main home/dashboard screen
class FestivalHomeScreen extends StatefulWidget {
  const FestivalHomeScreen({super.key});

  @override
  State<FestivalHomeScreen> createState() => _FestivalHomeScreenState();
}

class _FestivalHomeScreenState extends State<FestivalHomeScreen> {
  late FestivalController _festivalController;
  late FavoritesController _favoritesController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _festivalController = FestivalController()..load();
    _favoritesController = FavoritesController()..loadFavorites();
  }

  @override
  void dispose() {
    _festivalController.dispose();
    _favoritesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _festivalController),
        ChangeNotifierProvider.value(value: _favoritesController),
      ],
      child: Scaffold(
        body: _getSelectedScreen(),
        bottomNavigationBar: AppBottomNavigation(
          selectedIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const _HomeContent();
      case 1:
        return const CalendarScreen(showAppBar: false);
      case 2:
        return const FestivalListScreen();
      case 3:
        return const FavoritesScreen();
      default:
        return const _HomeContent();
    }
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // App bar
        SliverAppBar.large(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hadiya Heritage',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Discover festivals and celebrations',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Consumer<FestivalController>(
            builder: (context, controller, _) {
              if (controller.isLoading) {
                return const SizedBox(
                  height: 400,
                  child: LoadingIndicator(message: 'Loading festivals...'),
                );
              }

              return AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Happening Now section
                    if (controller.happening.isNotEmpty) ...[
                      SectionHeader(
                        title: 'Happening Now 🎉',
                        onSeeAllTap: () =>
                            _navigateToList(context, DateFilter.happening),
                      ),
                      _HorizontalFestivalList(festivals: controller.happening),
                    ],

                    // Featured section
                    if (controller.featured.isNotEmpty) ...[
                      SectionHeader(
                        title: 'Featured Events',
                        onSeeAllTap: () => _navigateToList(context, null),
                      ),
                      _HorizontalFestivalList(festivals: controller.featured),
                    ],

                    // Upcoming section
                    SectionHeader(
                      title: 'Upcoming Festivals',
                      onSeeAllTap: () =>
                          _navigateToList(context, DateFilter.upcoming),
                    ),
                    _buildUpcomingList(context, controller.upcoming),

                    // Category grid
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Browse by Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const _CategoryGrid(),

                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingList(
    BuildContext context,
    List<FestivalEvent> festivals,
  ) {
    if (festivals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: Text('No upcoming festivals')),
      );
    }

    // Show first 5 upcoming
    final displayFestivals = festivals.take(5).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: displayFestivals.map((festival) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FestivalCard(
              festival: festival,
              compact: true,
              onTap: () => _navigateToDetail(context, festival),
              trailing: _buildFavoriteButton(context, festival),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, FestivalEvent festival) {
    return Consumer<FavoritesController>(
      builder: (context, favController, _) {
        final isFavorite = favController.isFavorite(festival.id);

        return IconButton(
          onPressed: () => favController.toggleFavorite(festival.id),
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
        );
      },
    );
  }

  void _navigateToList(BuildContext context, DateFilter? filter) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FestivalListScreen()),
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
}

class _HorizontalFestivalList extends StatelessWidget {
  final List<FestivalEvent> festivals;

  const _HorizontalFestivalList({required this.festivals});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: festivals.length,
        itemBuilder: (context, index) {
          final festival = festivals[index];

          return SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FestivalCard(
                festival: festival,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FestivalDetailScreen(festival: festival),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    final categories = FestivalCategory.values;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryCard(category: category);
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final FestivalCategory category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FestivalListScreen(initialCategory: category),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(category),
              size: 32,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              _getCategoryLabel(category),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryLabel(FestivalCategory category) {
    return category.name[0].toUpperCase() + category.name.substring(1);
  }

  IconData _getCategoryIcon(FestivalCategory category) {
    switch (category) {
      case FestivalCategory.religious:
        return Icons.church;
      case FestivalCategory.cultural:
        return Icons.festival;
      case FestivalCategory.harvest:
        return Icons.agriculture;
      case FestivalCategory.music:
        return Icons.music_note;
      case FestivalCategory.food:
        return Icons.restaurant;
      case FestivalCategory.sport:
        return Icons.sports_soccer;
      case FestivalCategory.historical:
        return Icons.history_edu;
      case FestivalCategory.art:
        return Icons.palette;
      case FestivalCategory.traditional:
        return Icons.people;
      case FestivalCategory.community:
        return Icons.groups;
    }
  }
}

// DateFilter enum needed for navigation
enum DateFilter { all, upcoming, thisWeek, thisMonth, happening }
