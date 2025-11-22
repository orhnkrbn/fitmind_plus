// Nutrition Models

class NutritionSummary {
  final int targetCalories;
  final int consumedCalories;

  NutritionSummary({
    required this.targetCalories,
    required this.consumedCalories,
  });

  int get remainingCalories => targetCalories - consumedCalories;
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
}

extension MealTypeExtension on MealType {
  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Sabah';
      case MealType.lunch:
        return 'Öğle';
      case MealType.dinner:
        return 'Akşam';
      case MealType.snack:
        return 'Ara Öğün';
    }
  }
}

class Meal {
  final MealType type;
  final List<MealItem> items;

  Meal({
    required this.type,
    required this.items,
  });

  int get totalCalories => items.fold(0, (sum, item) => sum + item.calories);
}

class MealItem {
  final String name;
  final int calories;

  MealItem({
    required this.name,
    required this.calories,
  });
}
