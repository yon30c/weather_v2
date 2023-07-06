import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_v2/src/app.dart';
import 'package:weather_v2/src/config/config.dart';

final ThemeController themeController = ThemeController(ThemeService());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  themeController.loadTheme();
  runApp(const ProviderScope(child: MyApp()));
}
