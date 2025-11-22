import 'package:flutter/material.dart';
import '../styles/styles.dart';

/// Builds the light ThemeData for the app using Material 3.
ThemeData buildLightTheme() {
  const seed = Colors.blue;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
  );

  final base = ThemeData.from(colorScheme: colorScheme, useMaterial3: true);

  final textTheme = base.textTheme.copyWith(
    headlineMedium: base.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
  );

  return base.copyWith(
    textTheme: textTheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      elevation: AppElevations.low,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: AppShapes.rounded16,
      shadowColor: Colors.black.withAlpha(15),
      centerTitle: true,
      foregroundColor: colorScheme.onSurface,
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: AppElevations.medium,
      shape: AppShapes.rounded16,
      margin: const EdgeInsets.all(AppSpacing.md),
    ),
    shadowColor: Colors.black.withAlpha(15),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: AppShapes.rounded16),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: AppElevations.medium,
      shape: AppShapes.rounded16,
    ),
  );
}

/// Builds the dark ThemeData for the app using Material 3.
ThemeData buildDarkTheme() {
  const seed = Colors.blue;
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
  );

  final base = ThemeData.from(colorScheme: colorScheme, useMaterial3: true);

  final textTheme = base.textTheme.copyWith(
    headlineMedium: base.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
  );

  return base.copyWith(
    brightness: Brightness.dark,
    textTheme: textTheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      elevation: AppElevations.low,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: AppShapes.rounded16,
      shadowColor: Colors.black.withAlpha(20),
      centerTitle: true,
      foregroundColor: colorScheme.onSurface,
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: AppElevations.low,
      shape: AppShapes.rounded16,
      margin: const EdgeInsets.all(AppSpacing.md),
    ),
    shadowColor: Colors.black.withAlpha(20),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: AppShapes.rounded16),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: AppElevations.medium,
      shape: AppShapes.rounded16,
    ),
  );
}

/// A convenience extension to access the app's motivational text style.
/// "MotivationalText" is based on headlineMedium with a slightly heavier weight.
extension AppTextStyles on ThemeData {
  TextStyle get motivationalText =>
      textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700);
}
