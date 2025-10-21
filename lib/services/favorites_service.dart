import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite.dart';

class FavoritesService extends ChangeNotifier {
  static const String _favoritesKey = 'favorites';

  Map<String, Favorite> _favorites = {};
  bool _isLoaded = false;

  Map<String, Favorite> get favorites => _favorites;

  bool isFavorite(String id) => _favorites.containsKey(id);

  Future<void> loadFavorites() async {
    if (_isLoaded) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = jsonDecode(favoritesJson);
        _favorites = {
          for (var fav in favoritesList) fav['id']: Favorite.fromJson(fav),
        };
      }
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  Future<void> toggleFavorite(Favorite favorite) async {
    if (isFavorite(favorite.id)) {
      _favorites.remove(favorite.id);
    } else {
      _favorites[favorite.id] = favorite;
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> clearFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesList = _favorites.values
          .map((fav) => fav.toJson())
          .toList();
      await prefs.setString(_favoritesKey, jsonEncode(favoritesList));
    } catch (e) {
      debugPrint('Error saving favorites: $e');
    }
  }
}
