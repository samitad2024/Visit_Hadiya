import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/mock/mock_festival_repository.dart';
import '../models/festival_event.dart';

class FestivalController extends ChangeNotifier {
  final MockFestivalRepository _repo;
  FestivalController({MockFestivalRepository? repo})
      : _repo = repo ?? MockFestivalRepository();

  DateTime _visibleMonth = DateTime.now();
  DateTime? _selected;
  List<FestivalEvent> _all = const [];

  DateTime get visibleMonth => DateTime(_visibleMonth.year, _visibleMonth.month);
  DateTime? get selectedDate => _selected;
  List<FestivalEvent> get upcoming => _all.where((e) => e.date.isAfter(DateTime.now().subtract(const Duration(days: 1)))).toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  void load() {
    _all = _repo.fetchEvents();
    notifyListeners();
  }

  void nextMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    notifyListeners();
  }

  void prevMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    notifyListeners();
  }

  void select(DateTime day) {
    _selected = day;
    notifyListeners();
  }

  bool isFestivalDay(DateTime day) =>
      _all.any((e) => e.date.year == day.year && e.date.month == day.month && e.date.day == day.day);
}
