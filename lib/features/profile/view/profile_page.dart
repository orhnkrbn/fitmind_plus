import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/app_settings_provider.dart';
import '../../../core/styles/styles.dart';

/// Profile page showing a mock target, weight and program.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mocked values for now
    const String goal = 'Fit & Kaslı';
    const double currentWeight = 94.0;
    const String program = 'Yağ yakım + kas';

    final themeMode = ref.watch(appSettingsProvider);
    final settings = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Card(
            shape: AppShapes.rounded16,
            elevation: AppElevations.medium,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goal, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mevcut kilo',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              '${currentWeight.toStringAsFixed(0)} kg',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Program',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text(program),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showEditGoalsDialog(context),
                      child: const Text('Hedefleri düzenle'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Card(
            shape: AppShapes.rounded16,
            elevation: AppElevations.low,
            child: Column(
              children: [
                // SwitchListTile toggles System theme on/off. When off, user can choose Light/Dark.
                SwitchListTile(
                  title: const Text('Sistem temasını kullan'),
                  value: themeMode == ThemeMode.system,
                  onChanged: (v) {
                    if (v) {
                      settings.setThemeMode(ThemeMode.system);
                    } else {
                      // default to light when disabling system
                      settings.setThemeMode(ThemeMode.light);
                    }
                  },
                ),

                // If not using system, allow selecting light or dark explicitly
                if (themeMode != ThemeMode.system) ...[
                  ListTile(
                    title: const Text('Açık (Light)'),
                    trailing: themeMode == ThemeMode.light
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () => settings.setThemeMode(ThemeMode.light),
                  ),
                  ListTile(
                    title: const Text('Koyu (Dark)'),
                    trailing: themeMode == ThemeMode.dark
                        ? const Icon(Icons.check)
                        : null,
                    onTap: () => settings.setThemeMode(ThemeMode.dark),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditGoalsDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hedefleri düzenle'),
        content: const Text(
          'Bu alan şu an için placeholder. Hedefleri burada düzenleyebilirsiniz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }
}
