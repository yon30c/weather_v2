import 'package:flutter/material.dart';
import 'theme_services.dart';

class ThemeController with ChangeNotifier {
  final ThemeService _themeService;
  late ThemeMode _themeMode;
  ThemeController(this._themeService);

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    _themeMode = await _themeService.themeMode();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();

    await _themeService.updateThemeMode(newThemeMode);
  }
}