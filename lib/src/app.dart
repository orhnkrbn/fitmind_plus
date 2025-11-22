import 'package:flutter/material.dart';
import 'theme.dart';
import 'splash.dart';

class FitMindApp extends StatelessWidget {
  const FitMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitMind+',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const SplashGate(),
    );
  }
}