import 'package:flutter/material.dart';
import '../main.dart';
import 'config/config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) => MaterialApp.router(
        title: 'Material App',
        theme: AppTheme().getTheme(),
        darkTheme: AppTheme().getDarkTheme(),
        themeMode: themeController.themeMode,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
