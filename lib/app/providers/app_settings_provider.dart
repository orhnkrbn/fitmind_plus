import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App-wide theme settings provider.
class AppSettingsNotifier extends StateNotifier<ThemeMode> {
  AppSettingsNotifier() : super(ThemeMode.system);

  /// Cycle through system -> light -> dark -> system
  void toggleThemeMode() {
    state = switch (state) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
  }

  /// Set explicitly
  void setThemeMode(ThemeMode mode) => state = mode;
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, ThemeMode>((ref) {
      return AppSettingsNotifier();
    });
