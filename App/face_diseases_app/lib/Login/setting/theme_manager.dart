import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    notifyListeners();
  }
}
