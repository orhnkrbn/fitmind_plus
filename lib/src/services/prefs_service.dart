import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/measurement.dart';
import '../models/meal.dart';

class PrefsService {
  static const _kMeasurements = 'measurements';
  static const _kMeals = 'meals';

  Future<List<Measurement>> getMeasurements() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getStringList(_kMeasurements) ?? [];
    return raw.map((s) => Measurement.fromJson(jsonDecode(s))).toList();
  }

  Future<void> saveMeasurement(Measurement m) async {
    final list = await getMeasurements();
    list.add(m);
    list.sort((a,b) => a.date.compareTo(b.date));
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList(_kMeasurements, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<List<MealItem>> getMeals() async {
    final sp = await SharedPreferences.getInstance();
    final raw = sp.getStringList(_kMeals) ?? [];
    return raw.map((s) => MealItem.fromJson(jsonDecode(s))).toList();
  }

  Future<void> saveMeal(MealItem m) async {
    final list = await getMeals();
    list.add(m);
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList(_kMeals, list.map((e) => jsonEncode(e.toJson())).toList());
  }
}