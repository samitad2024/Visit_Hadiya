import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/mock/mock_icons_repository.dart';
import '../models/person_icon.dart';

class IconsController extends ChangeNotifier {
  final MockIconsRepository _repo;
  IconsController({MockIconsRepository? repo})
    : _repo = repo ?? MockIconsRepository();

  List<PersonIcon> _all = const [];
  String _query = '';

  void load() {
    _all = _repo.fetchIcons();
    notifyListeners();
  }

  void setQuery(String q) {
    _query = q.trim().toLowerCase();
    notifyListeners();
  }

  List<PersonIcon> get leaders => _filtered(IconCategory.leader);
  List<PersonIcon> get warriors => _filtered(IconCategory.warrior);
  List<PersonIcon> get cultural => _filtered(IconCategory.cultural);

  List<PersonIcon> _filtered(IconCategory category) {
    final list = _all.where((e) => e.category == category).toList();
    if (_query.isEmpty) return list;
    return list.where((e) => e.nameKey.toLowerCase().contains(_query)).toList();
  }
}
