// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themeprov with ChangeNotifier {
  late bool _isDark;

  late SharedPreferences storage;

  Themeprov() {
    _isDark = false; // Set default theme
    init(); // Initialize theme
  }

  // Custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  // Custom light theme
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
  );

  // Getter for isDark
  bool get isDark => _isDark;

  // Method to toggle theme
  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners(); // Notify listeners to update UI

    // Save theme preference
    storage.setBool('isDark', _isDark);
  }

  // Initialize theme
  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool('isDark') ?? false; // Read theme preference
    notifyListeners(); // Notify listeners to update UI
  }
}
