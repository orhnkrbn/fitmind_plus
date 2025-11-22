import 'package:flutter/material.dart';

const double phi = 1.618;

EdgeInsets goldenPad([double base = 8]) => EdgeInsets.all(base * phi);

ThemeData buildLightTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(centerTitle: true),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(height: 1.2),
    ),
  );
}

ThemeData buildDarkTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(centerTitle: true),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(height: 1.2),
    ),
  );
}