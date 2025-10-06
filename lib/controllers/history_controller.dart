import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/mock/mock_history_repository.dart';
import '../models/history_event.dart';

class HistoryController extends ChangeNotifier {
  final MockHistoryRepository _repo;
  HistoryController({MockHistoryRepository? repo})
    : _repo = repo ?? MockHistoryRepository();

  List<HistoryEvent> _events = const [];
  List<HistoryEvent> get events => _events;

  void load() {
    final list = List<HistoryEvent>.from(_repo.fetchEvents());
    list.sort((a, b) => a.order.compareTo(b.order));
    _events = list;
    notifyListeners();
  }
}
