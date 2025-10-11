import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for managing favorite festivals with persistent storage
class FavoritesController extends ChangeNotifier {
  static const String _favoritesKey = 'favorite_festivals';

  Set<String> _favoriteIds = {};
  bool _isLoaded = false;

  /// Get all favorite festival IDs
  Set<String> get favoriteIds => _favoriteIds;

  /// Check if a festival is favorited
  bool isFavorite(String festivalId) => _favoriteIds.contains(festivalId);

  /// Load favorites from persistent storage
  Future<void> loadFavorites() async {
    if (_isLoaded) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesList = prefs.getStringList(_favoritesKey) ?? [];
      _favoriteIds = favoritesList.toSet();
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  /// Toggle favorite status for a festival
  Future<void> toggleFavorite(String festivalId) async {
    if (_favoriteIds.contains(festivalId)) {
      _favoriteIds.remove(festivalId);
    } else {
      _favoriteIds.add(festivalId);
    }

    await _saveFavorites();
    notifyListeners();
  }

  /// Add a festival to favorites
  Future<void> addFavorite(String festivalId) async {
    if (!_favoriteIds.contains(festivalId)) {
      _favoriteIds.add(festivalId);
      await _saveFavorites();
      notifyListeners();
    }
  }

  /// Remove a festival from favorites
  Future<void> removeFavorite(String festivalId) async {
    if (_favoriteIds.contains(festivalId)) {
      _favoriteIds.remove(festivalId);
      await _saveFavorites();
      notifyListeners();
    }
  }

  /// Clear all favorites
  Future<void> clearFavorites() async {
    _favoriteIds.clear();
    await _saveFavorites();
    notifyListeners();
  }

  /// Save favorites to persistent storage
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favoritesKey, _favoriteIds.toList());
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }
}
