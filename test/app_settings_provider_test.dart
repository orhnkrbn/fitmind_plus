import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/app/providers/app_settings_provider.dart';

void main() {
  test('AppSettingsProvider toggles theme mode', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // initial is system
    expect(container.read(appSettingsProvider), ThemeMode.system);

    container.read(appSettingsProvider.notifier).toggleThemeMode();
    expect(container.read(appSettingsProvider), ThemeMode.light);

    container.read(appSettingsProvider.notifier).toggleThemeMode();
    expect(container.read(appSettingsProvider), ThemeMode.dark);

    container.read(appSettingsProvider.notifier).setThemeMode(ThemeMode.light);
    expect(container.read(appSettingsProvider), ThemeMode.light);
  });
}
