import 'package:flutter/foundation.dart' show ChangeNotifier;

class SettingsController extends ChangeNotifier {
  bool offline = false;
  bool notifications = false;

  void toggleOffline(bool v) {
    offline = v;
    notifyListeners();
  }

  void toggleNotifications(bool v) {
    notifications = v;
    notifyListeners();
  }
}
