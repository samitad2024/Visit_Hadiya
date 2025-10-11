import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/mock/mock_festival_repository.dart';
import '../models/festival_event.dart';

/// Controller for managing festival calendar and event display
class FestivalController extends ChangeNotifier {
  final MockFestivalRepository _repo;

  FestivalController({MockFestivalRepository? repo})
    : _repo = repo ?? MockFestivalRepository();

  DateTime _visibleMonth = DateTime.now();
  DateTime? _selected;
  List<FestivalEvent> _all = const [];
  bool _isLoading = false;

  // Getters
  DateTime get visibleMonth =>
      DateTime(_visibleMonth.year, _visibleMonth.month);
  DateTime? get selectedDate => _selected;
  bool get isLoading => _isLoading;

  /// Get all events
  List<FestivalEvent> get allEvents => _all;

  /// Get upcoming events (sorted by date)
  List<FestivalEvent> get upcoming =>
      _all.where((e) => e.isUpcoming).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

  /// Get happening events (currently ongoing)
  List<FestivalEvent> get happening =>
      _all.where((e) => e.isHappening).toList();

  /// Get featured events
  List<FestivalEvent> get featured => _all.where((e) => e.isFeatured).toList();

  /// Get events for the visible month
  List<FestivalEvent> get eventsThisMonth => _all.where((e) {
    return e.date.year == _visibleMonth.year &&
        e.date.month == _visibleMonth.month;
  }).toList();

  /// Get events for selected date
  List<FestivalEvent> get eventsForSelectedDate {
    if (_selected == null) return [];
    return getEventsForDate(_selected!);
  }

  /// Load all events from repository
  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    _all = _repo.fetchEvents();
    _isLoading = false;
    notifyListeners();
  }

  /// Navigate to next month
  void nextMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    notifyListeners();
  }

  /// Navigate to previous month
  void prevMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    notifyListeners();
  }

  /// Go to today's month
  void goToToday() {
    _visibleMonth = DateTime.now();
    _selected = DateTime.now();
    notifyListeners();
  }

  /// Select a specific date
  void select(DateTime day) {
    _selected = day;
    notifyListeners();
  }

  /// Clear date selection
  void clearSelection() {
    _selected = null;
    notifyListeners();
  }

  /// Check if a given day has any festivals
  bool isFestivalDay(DateTime day) => _all.any(
    (e) =>
        e.date.year == day.year &&
        e.date.month == day.month &&
        e.date.day == day.day,
  );

  /// Get all events for a specific date
  List<FestivalEvent> getEventsForDate(DateTime date) {
    return _all.where((e) {
      return e.date.year == date.year &&
          e.date.month == date.month &&
          e.date.day == date.day;
    }).toList();
  }

  /// Get event by ID
  FestivalEvent? getEventById(String id) {
    try {
      return _all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get events by category
  List<FestivalEvent> getEventsByCategory(FestivalCategory category) {
    return _all.where((e) => e.category == category).toList();
  }
}
