// ignore_for_file: public_member_api_docs
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MealPart {
  final String name;
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final double portionG;

  MealPart({
    required this.name,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.portionG,
  });

  factory MealPart.fromMap(Map<String, dynamic> m) => MealPart(
        name: m['name'] as String? ?? '',
        kcal: (m['kcal'] is num) ? (m['kcal'] as num).toDouble() : double.tryParse('${m['kcal']}') ?? 0.0,
        protein: (m['p'] is num) ? (m['p'] as num).toDouble() : double.tryParse('${m['p']}') ?? 0.0,
        carbs: (m['c'] is num) ? (m['c'] as num).toDouble() : double.tryParse('${m['c']}') ?? 0.0,
        fat: (m['f'] is num) ? (m['f'] as num).toDouble() : double.tryParse('${m['f']}') ?? 0.0,
        portionG: (m['portion_g'] is num) ? (m['portion_g'] as num).toDouble() : double.tryParse('${m['portion_g']}') ?? 0.0,
      );
}

class DailyMeals {
  final String day;
  final MealPart breakfast;
  final MealPart lunch;
  final MealPart dinner;
  final List<MealPart> snacks;

  DailyMeals({required this.day, required this.breakfast, required this.lunch, required this.dinner, required this.snacks});

  factory DailyMeals.fromMap(Map<String, dynamic> m) => DailyMeals(
        day: m['day'] as String? ?? '',
        breakfast: MealPart.fromMap(m['breakfast'] as Map<String, dynamic>),
        lunch: MealPart.fromMap(m['lunch'] as Map<String, dynamic>),
        dinner: MealPart.fromMap(m['dinner'] as Map<String, dynamic>),
        snacks: (m['snacks'] as List<dynamic>? ?? <dynamic>[]).map((s) => MealPart.fromMap(s as Map<String, dynamic>)).toList(),
      );

  Map<String, double> dailyTotals() {
    double kcal = breakfast.kcal + lunch.kcal + dinner.kcal;
    double p = breakfast.protein + lunch.protein + dinner.protein;
    double c = breakfast.carbs + lunch.carbs + dinner.carbs;
    double f = breakfast.fat + lunch.fat + dinner.fat;
    for (final s in snacks) {
      kcal += s.kcal;
      p += s.protein;
      c += s.carbs;
      f += s.fat;
    }
    return {'kcal': kcal, 'p': p, 'c': c, 'f': f};
  }
}

class MealPlan {
  final List<DailyMeals> days;
  MealPlan({required this.days});
}

class NutritionRepository {
  const NutritionRepository();

  Future<MealPlan> getWeeklyPlan({String goal = 'fatloss'}) async {
    final raw = await rootBundle.loadString('assets/json/meals_sample.json');
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;

    final rawList = (json[goal] as List<dynamic>? ?? <dynamic>[]);
    final days = rawList.map((d) => DailyMeals.fromMap(d as Map<String, dynamic>)).toList();
    return MealPlan(days: days);
  }
}

final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) => const NutritionRepository());

final weeklyMealPlanProvider = FutureProvider.family<MealPlan, String>((ref, goal) async {
  final repo = ref.watch(nutritionRepositoryProvider);
  return repo.getWeeklyPlan(goal: goal);
});

