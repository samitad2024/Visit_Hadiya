import 'package:flutter/foundation.dart';

import '../data/mock/mock_historical_sites_repository.dart';
import '../models/historical_site.dart';

class HistoricalSitesController extends ChangeNotifier {
  final MockHistoricalSitesRepository _repo;
  HistoricalSitesController({MockHistoricalSitesRepository? repo})
    : _repo = repo ?? const MockHistoricalSitesRepository();

  List<HistoricalSite> _all = const [];
  List<HistoricalSite> _filtered = const [];
  String _query = '';
  bool _loaded = false;

  List<HistoricalSite> get sites => _filtered;
  String get query => _query;
  bool get isLoaded => _loaded;

  void load() {
    _all = _repo.fetchSites();
    _filtered = _all;
    _loaded = true;
    notifyListeners();
  }

  void setQuery(String q) {
    _query = q.trim().toLowerCase();
    if (_query.isEmpty) {
      _filtered = _all;
    } else {
      _filtered = _all
          .where(
            (s) =>
                s.nameKey.toLowerCase().contains(_query) ||
                s.subtitleKey.toLowerCase().contains(_query),
          )
          .toList(growable: false);
    }
    notifyListeners();
  }
}
