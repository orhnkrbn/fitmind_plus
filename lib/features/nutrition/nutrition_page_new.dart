import 'package:flutter/material.dart';
import 'models.dart';
import '../../ui/fm_scaffold.dart';

/// Fake nutrition data
final _fakeSummary = NutritionSummary(
  targetCalories: 2200,
  consumedCalories: 1650,
);

final _fakeMeals = [
  Meal(
    type: MealType.breakfast,
    items: [
      MealItem(name: 'Yulaf + Whey', calories: 380),
      MealItem(name: 'Muz', calories: 90),
      MealItem(name: 'Kahve', calories: 5),
    ],
  ),
  Meal(
    type: MealType.lunch,
    items: [
      MealItem(name: 'Tavuk Pilav', calories: 550),
      MealItem(name: 'Salata', calories: 80),
    ],
  ),
  Meal(
    type: MealType.dinner,
    items: [
      MealItem(name: 'Izgara Somon', calories: 420),
      MealItem(name: 'Brokoli', calories: 55),
    ],
  ),
  Meal(
    type: MealType.snack,
    items: [
      MealItem(name: 'Yoğurt + Meyve', calories: 150),
    ],
  ),
];

class NutritionPageNew extends StatelessWidget {
  const NutritionPageNew({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return FmScaffold(
      title: 'Beslenme Takibi',
      subtitle: 'Günlük kalori ve makro takibi',
      body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Daily summary card
            _buildSummaryCard(context),
            const SizedBox(height: 24),

            // Meals section
            Text(
              'Bugünkü Öğünler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            ..._fakeMeals.map((meal) => _buildMealCard(context, meal)),

            const SizedBox(height: 24),

            // Add meal button
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Open add meal dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Yeni öğün ekleme özelliği yakında!')),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Yeni Öğün Ekle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final progress = _fakeSummary.consumedCalories / _fakeSummary.targetCalories;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade600,
            Colors.amber.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Günlük Kalori Hedefi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          
          // Progress circle
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_fakeSummary.consumedCalories}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '/ ${_fakeSummary.targetCalories}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Remaining calories
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.restaurant, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${_fakeSummary.remainingCalories} kcal kaldı',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, Meal meal) {
    final colorScheme = Theme.of(context).colorScheme;
    
    IconData mealIcon;
    switch (meal.type) {
      case MealType.breakfast:
        mealIcon = Icons.breakfast_dining;
        break;
      case MealType.lunch:
        mealIcon = Icons.lunch_dining;
        break;
      case MealType.dinner:
        mealIcon = Icons.dinner_dining;
        break;
      case MealType.snack:
        mealIcon = Icons.fastfood;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal type header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade700.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(mealIcon, color: Colors.amber.shade700, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                meal.type.displayName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${meal.totalCalories} kcal',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Meal items
          ...meal.items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                Text(
                  '${item.calories} kcal',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
