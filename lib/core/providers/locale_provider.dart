import 'package:flutter/material.dart';

/// Simple locale provider using [ChangeNotifier].
/// Persists choice in-memory for now; can be extended to SharedPreferences.
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Mock supported languages (code -> display)
  final List<LocaleOption> supported = const [
    LocaleOption(code: 'hdy', name: 'Hadiyigna'),
    LocaleOption(code: 'am', name: 'Amharic'),
    LocaleOption(code: 'en', name: 'English'),
  ];

  void setLocale(String code) {
    _locale = Locale(code);
    notifyListeners();
  }
}

class LocaleOption {
  final String code;
  final String name;
  const LocaleOption({required this.code, required this.name});
}
