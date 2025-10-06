import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/mock/mock_category_repository.dart';
import '../models/category.dart';

class CategoryController extends ChangeNotifier {
  final MockCategoryRepository _repo;
  CategoryController({MockCategoryRepository? repo})
    : _repo = repo ?? MockCategoryRepository();

  List<Category> _items = const [];
  List<Category> get items => _items;

  void load() {
    _items = _repo.fetchCategories();
    notifyListeners();
  }
}
