import 'package:flutter/foundation.dart';
import '../models/festival_event.dart';
import '../data/mock/mock_festival_repository.dart';

/// Controller for searching and filtering festivals
class SearchFilterController extends ChangeNotifier {
  final MockFestivalRepository _repo;

  SearchFilterController({MockFestivalRepository? repo})
    : _repo = repo ?? MockFestivalRepository();

  List<FestivalEvent> _allEvents = [];
  List<FestivalEvent> _filteredEvents = [];
  String _searchQuery = '';
  final Set<FestivalCategory> _selectedCategories = {};
  DateFilter _dateFilter = DateFilter.all;
  SortOption _sortOption = SortOption.dateAscending;

  // Getters
  List<FestivalEvent> get filteredEvents => _filteredEvents;
  String get searchQuery => _searchQuery;
  Set<FestivalCategory> get selectedCategories => _selectedCategories;
  DateFilter get dateFilter => _dateFilter;
  SortOption get sortOption => _sortOption;
  bool get hasActiveFilters =>
      _searchQuery.isNotEmpty ||
      _selectedCategories.isNotEmpty ||
      _dateFilter != DateFilter.all;

  /// Load all events
  void loadEvents() {
    _allEvents = _repo.fetchEvents();
    _applyFilters();
  }

  /// Set search query
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    _applyFilters();
  }

  /// Toggle category filter
  void toggleCategory(FestivalCategory category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFilters();
  }

  /// Set date filter
  void setDateFilter(DateFilter filter) {
    _dateFilter = filter;
    _applyFilters();
  }

  /// Set sort option
  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFilters();
  }

  /// Clear all filters
  void clearFilters() {
    _searchQuery = '';
    _selectedCategories.clear();
    _dateFilter = DateFilter.all;
    _applyFilters();
  }

  /// Apply all filters and sorting
  void _applyFilters() {
    List<FestivalEvent> results = List.from(_allEvents);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      results = results.where((event) {
        // In a real app, you'd search translated titles
        // For now, search by title key and category
        return event.titleKey.toLowerCase().contains(_searchQuery) ||
            event.category.name.toLowerCase().contains(_searchQuery) ||
            (event.location?.toLowerCase().contains(_searchQuery) ?? false);
      }).toList();
    }

    // Apply category filter
    if (_selectedCategories.isNotEmpty) {
      results = results
          .where((event) => _selectedCategories.contains(event.category))
          .toList();
    }

    // Apply date filter
    final now = DateTime.now();
    switch (_dateFilter) {
      case DateFilter.upcoming:
        results = results.where((event) => event.isUpcoming).toList();
        break;
      case DateFilter.thisMonth:
        results = results.where((event) {
          return event.date.year == now.year && event.date.month == now.month;
        }).toList();
        break;
      case DateFilter.thisWeek:
        final weekEnd = now.add(const Duration(days: 7));
        results = results.where((event) {
          return event.date.isAfter(now) && event.date.isBefore(weekEnd);
        }).toList();
        break;
      case DateFilter.happening:
        results = results.where((event) => event.isHappening).toList();
        break;
      case DateFilter.all:
        // No date filtering
        break;
    }

    // Apply sorting
    switch (_sortOption) {
      case SortOption.dateAscending:
        results.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortOption.dateDescending:
        results.sort((a, b) => b.date.compareTo(a.date));
        break;
      case SortOption.nameAscending:
        results.sort((a, b) => a.titleKey.compareTo(b.titleKey));
        break;
      case SortOption.nameDescending:
        results.sort((a, b) => b.titleKey.compareTo(a.titleKey));
        break;
      case SortOption.featured:
        results.sort((a, b) {
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          return a.date.compareTo(b.date);
        });
        break;
    }

    _filteredEvents = results;
    notifyListeners();
  }
}

/// Date filter options
enum DateFilter { all, upcoming, thisWeek, thisMonth, happening }

/// Sort options for festival list
enum SortOption {
  dateAscending,
  dateDescending,
  nameAscending,
  nameDescending,
  featured,
}
