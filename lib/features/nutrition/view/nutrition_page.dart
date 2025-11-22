import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitmind_plus_ultra_22/core/styles/styles.dart';

class NutritionPageView extends StatelessWidget {
  const NutritionPageView({super.key});

  List<Map<String, dynamic>> _mockMeals() => [
        {'name': 'Kahvaltı', 'cal': 420, 'protein': 18},
        {'name': 'Ara Öğün', 'cal': 150, 'protein': 6},
        {'name': 'Öğle', 'cal': 650, 'protein': 32},
        {'name': 'Ara Öğün', 'cal': 120, 'protein': 4},
        {'name': 'Akşam', 'cal': 580, 'protein': 34},
      ];

  @override
  Widget build(BuildContext context) {
    final meals = _mockMeals();
    final totalCalories = meals.fold<int>(0, (p, e) => p + (e['cal'] as int));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Beslenme')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Günlük Kalori Özeti', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.md),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: ListTile(
                  title: Text(
                    '$totalCalories kcal',
                    style: theme.textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    'Hedef: 2200 kcal • ${DateFormat.yMMMd().format(DateTime.now())}',
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
              Text('Öğünler', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),

              Expanded(
                child: ListView.separated(
                  itemCount: meals.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (ctx, i) {
                    final m = meals[i];
                    return Card(
                      key: ValueKey('meal_$i'),
                      child: ListTile(
                        leading: const Icon(Icons.restaurant_menu),
                        title: Text(m['name'] as String),
                        subtitle: Text('${m['cal']} kcal • ${m['protein']} g P'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
