import 'package:flutter/material.dart';
import 'package:prism/themes/dark_mode.dart';
import 'package:prism/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themePreferenceKey = "theme_preference";

  ThemeData _themeData = lightMode;

  ThemeProvider();

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveThemeToPrefs();
  }

  void toggleTheme() {
    themeData = (_themeData == lightMode) ? darkMode : lightMode;
  }

  Future<void> loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themePreferenceKey) ?? false;
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themePreferenceKey, isDarkMode);
  }
}
