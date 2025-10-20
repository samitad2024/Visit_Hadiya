import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

enum TextSizeMode { small, medium, large }

/// Global app settings provider that controls theme, language, text size, and other preferences
class AppSettingsProvider extends ChangeNotifier {
  static const String _keyThemeMode = 'themeMode';
  static const String _keyLanguageCode = 'languageCode';
  static const String _keyTextSize = 'textSize';
  static const String _keyOfflineMode = 'offlineMode';
  static const String _keyNotifications = 'notifications';

  AppThemeMode _themeMode = AppThemeMode.system;
  String _languageCode = 'en';
  TextSizeMode _textSize = TextSizeMode.medium;
  bool _offlineMode = false;
  bool _notificationsEnabled = true;
  bool _isLoading = true;

  // Getters
  AppThemeMode get themeMode => _themeMode;
  String get languageCode => _languageCode;
  TextSizeMode get textSize => _textSize;
  bool get offlineMode => _offlineMode;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isLoading => _isLoading;

  // Get actual Flutter ThemeMode for MaterialApp
  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  // Get Locale for MaterialApp
  Locale get locale => Locale(_languageCode);

  // Get text scale factor based on text size
  double get textScaleFactor {
    switch (_textSize) {
      case TextSizeMode.small:
        return 0.85;
      case TextSizeMode.medium:
        return 1.0;
      case TextSizeMode.large:
        return 1.15;
    }
  }

  AppSettingsProvider() {
    _loadSettings();
  }

  /// Load all settings from SharedPreferences
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final themeModeIndex = prefs.getInt(_keyThemeMode);
      if (themeModeIndex != null && themeModeIndex < AppThemeMode.values.length) {
        _themeMode = AppThemeMode.values[themeModeIndex];
      }

      _languageCode = prefs.getString(_keyLanguageCode) ?? 'en';

      final textSizeIndex = prefs.getInt(_keyTextSize);
      if (textSizeIndex != null && textSizeIndex < TextSizeMode.values.length) {
        _textSize = TextSizeMode.values[textSizeIndex];
      }

      _offlineMode = prefs.getBool(_keyOfflineMode) ?? false;
      _notificationsEnabled = prefs.getBool(_keyNotifications) ?? true;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading settings: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Set theme mode (light, dark, system)
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyThemeMode, mode.index);
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  /// Set app language
  Future<void> setLanguage(String languageCode) async {
    if (_languageCode == languageCode) return;
    
    _languageCode = languageCode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyLanguageCode, languageCode);
    } catch (e) {
      debugPrint('Error saving language: $e');
    }
  }

  /// Set text size
  Future<void> setTextSize(TextSizeMode size) async {
    if (_textSize == size) return;
    
    _textSize = size;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyTextSize, size.index);
    } catch (e) {
      debugPrint('Error saving text size: $e');
    }
  }

  /// Toggle offline mode
  Future<void> setOfflineMode(bool enabled) async {
    if (_offlineMode == enabled) return;
    
    _offlineMode = enabled;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyOfflineMode, enabled);
    } catch (e) {
      debugPrint('Error saving offline mode: $e');
    }
  }

  /// Toggle notifications
  Future<void> setNotifications(bool enabled) async {
    if (_notificationsEnabled == enabled) return;
    
    _notificationsEnabled = enabled;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyNotifications, enabled);
    } catch (e) {
      debugPrint('Error saving notifications: $e');
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      // Clear image cache
      imageCache.clear();
      imageCache.clearLiveImages();
      
      // You can add more cache clearing logic here
      // For example: clearing downloaded files, cached API responses, etc.
      
      debugPrint('Cache cleared successfully');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
      rethrow;
    }
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    _themeMode = AppThemeMode.system;
    _languageCode = 'en';
    _textSize = TextSizeMode.medium;
    _offlineMode = false;
    _notificationsEnabled = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      debugPrint('Error resetting settings: $e');
    }
  }
}
