import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/mock/mock_culture_repository.dart';
import '../models/culture_topic.dart';

class CultureController extends ChangeNotifier {
  final MockCultureRepository _repo;
  CultureController({MockCultureRepository? repo})
    : _repo = repo ?? MockCultureRepository();

  List<CultureTopic> _topics = const [];
  List<CultureTopic> get topics => _topics;

  void load() {
    _topics = _repo.fetchTopics();
    notifyListeners();
  }
}
