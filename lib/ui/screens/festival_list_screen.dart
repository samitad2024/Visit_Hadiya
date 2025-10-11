import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../controllers/search_filter_controller.dart';
import '../../controllers/favorites_controller.dart';
import '../../models/festival_event.dart';
import '../widgets/festival_card.dart';
import '../widgets/common_widgets.dart' as widgets;
import 'festival_detail_screen.dart';

/// Screen displaying list of festivals with search and filter
class FestivalListScreen extends StatefulWidget {
  final FestivalCategory? initialCategory;

  const FestivalListScreen({super.key, this.initialCategory});

  @override
  State<FestivalListScreen> createState() => _FestivalListScreenState();
}

class _FestivalListScreenState extends State<FestivalListScreen> {
  late SearchFilterController _searchController;
  late FavoritesController _favoritesController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController = SearchFilterController()..loadEvents();
    _favoritesController = FavoritesController()..loadFavorites();

    // Apply initial category filter if provided
    if (widget.initialCategory != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchController.toggleCategory(widget.initialCategory!);
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _searchController.dispose();
    _favoritesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _searchController),
        ChangeNotifierProvider.value(value: _favoritesController),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Festivals'),
          actions: [
            IconButton(
              onPressed: () => _showSortOptions(context),
              icon: const Icon(Icons.sort),
              tooltip: 'Sort',
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: widgets.CustomSearchBar(
                controller: _textController,
                onChanged: (query) => _searchController.setSearchQuery(query),
                onFilterTap: () => _showFilters(context),
              ),
            ),

            // Category chips
            _buildCategoryFilters(),

            // Festival list
            Expanded(
              child: Consumer<SearchFilterController>(
                builder: (context, controller, _) {
                  final festivals = controller.filteredEvents;

                  if (festivals.isEmpty) {
                    return widgets.EmptyState(
                      icon: Icons.celebration_outlined,
                      title: 'No Festivals Found',
                      message: controller.hasActiveFilters
                          ? 'Try adjusting your filters'
                          : 'No festivals available at this time',
                      action: controller.hasActiveFilters
                          ? ElevatedButton(
                              onPressed: () {
                                controller.clearFilters();
                                _textController.clear();
                              },
                              child: const Text('Clear Filters'),
                            )
                          : null,
                    );
                  }

                  return AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: festivals.length,
                      itemBuilder: (context, index) {
                        final festival = festivals[index];

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: FestivalCard(
                                  festival: festival,
                                  onTap: () =>
                                      _navigateToDetail(context, festival),
                                  trailing: _buildFavoriteButton(festival),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 50,
      child: Consumer<SearchFilterController>(
        builder: (context, controller, _) {
          return ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (final category in FestivalCategory.values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: widgets.FilterChip(
                    label: _getCategoryLabel(category),
                    isSelected: controller.selectedCategories.contains(
                      category,
                    ),
                    onTap: () => controller.toggleCategory(category),
                    icon: _getCategoryIcon(category),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFavoriteButton(FestivalEvent festival) {
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

  void _navigateToDetail(BuildContext context, FestivalEvent festival) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FestivalDetailScreen(festival: festival),
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date Filters',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final filter in DateFilter.values)
                  Consumer<SearchFilterController>(
                    builder: (context, controller, _) {
                      return widgets.FilterChip(
                        label: _getDateFilterLabel(filter),
                        isSelected: controller.dateFilter == filter,
                        onTap: () {
                          controller.setDateFilter(filter);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort By'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in SortOption.values)
              ListTile(
                title: Text(_getSortOptionLabel(option)),
                onTap: () {
                  _searchController.setSortOption(option);
                  Navigator.pop(context);
                },
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

  String _getDateFilterLabel(DateFilter filter) {
    switch (filter) {
      case DateFilter.all:
        return 'All';
      case DateFilter.upcoming:
        return 'Upcoming';
      case DateFilter.thisWeek:
        return 'This Week';
      case DateFilter.thisMonth:
        return 'This Month';
      case DateFilter.happening:
        return 'Happening Now';
    }
  }

  String _getSortOptionLabel(SortOption option) {
    switch (option) {
      case SortOption.dateAscending:
        return 'Date (Earliest First)';
      case SortOption.dateDescending:
        return 'Date (Latest First)';
      case SortOption.nameAscending:
        return 'Name (A-Z)';
      case SortOption.nameDescending:
        return 'Name (Z-A)';
      case SortOption.featured:
        return 'Featured First';
    }
  }
}
