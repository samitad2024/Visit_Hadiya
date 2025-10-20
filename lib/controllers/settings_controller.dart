import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

enum TextSizeMode { small, medium, large }

class SettingsController extends ChangeNotifier {
  bool _offline = false;
  bool _notifications = true;
  AppThemeMode _themeMode = AppThemeMode.system;
  TextSizeMode _textSize = TextSizeMode.medium;
  String _languageCode = 'en';

  bool get offline => _offline;
  bool get notifications => _notifications;
  AppThemeMode get themeMode => _themeMode;
  TextSizeMode get textSize => _textSize;
  String get languageCode => _languageCode;

  SettingsController() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _offline = prefs.getBool('offline') ?? false;
    _notifications = prefs.getBool('notifications') ?? true;
    _themeMode = AppThemeMode.values[prefs.getInt('themeMode') ?? 2];
    _textSize = TextSizeMode.values[prefs.getInt('textSize') ?? 1];
    _languageCode = prefs.getString('languageCode') ?? 'en';
    notifyListeners();
  }

  Future<void> toggleOffline(bool v) async {
    _offline = v;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('offline', v);
    notifyListeners();
  }

  Future<void> toggleNotifications(bool v) async {
    _notifications = v;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', v);
    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    notifyListeners();
  }

  Future<void> setTextSize(TextSizeMode size) async {
    _textSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('textSize', size.index);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', code);
    notifyListeners();
  }

  Future<void> clearCache() async {
    // Implement cache clearing logic
    notifyListeners();
  }
}
