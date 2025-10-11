import 'package:flutter/foundation.dart';

import '../data/mock/mock_media_repository.dart';
import '../models/media_item.dart';

class MediaController extends ChangeNotifier {
  final MockMediaRepository _repo;
  MediaController({MockMediaRepository? repo})
    : _repo = repo ?? const MockMediaRepository();

  int _tabIndex = 0; // 0=Audio, 1=Video, 2=Photos
  int get tabIndex => _tabIndex;
  void setTab(int i) {
    if (_tabIndex != i) {
      _tabIndex = i;
      notifyListeners();
    }
  }

  List<MediaCategory> _categories = const [];
  List<MediaItem> _items = const [];

  List<MediaCategory> get audioCategories => _categories
      .where((c) => c.type == MediaType.audio)
      .toList(growable: false);
  List<MediaCategory> get videoCategories => _categories
      .where((c) => c.type == MediaType.video)
      .toList(growable: false);
  List<MediaCategory> get photoCategories => _categories
      .where((c) => c.type == MediaType.photo)
      .toList(growable: false);

  List<MediaItem> itemsForCategory(String categoryId) =>
      _items.where((i) => i.categoryId == categoryId).toList(growable: false);

  Future<void> load() async {
    _categories = _repo.fetchCategories();
    _items = _repo.fetchItems();
    notifyListeners();
  }
}
