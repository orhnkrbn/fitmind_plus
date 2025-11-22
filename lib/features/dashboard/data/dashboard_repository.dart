// ignore_for_file: public_member_api_docs
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodaySummary {
  final DateTime date;
  final int caloriesBurned;
  final int steps;
  final bool workoutDone;
  final String note;

  TodaySummary({required this.date, required this.caloriesBurned, required this.steps, required this.workoutDone, required this.note});

  factory TodaySummary.fromMap(Map<String, dynamic> m) => TodaySummary(
        date: DateTime.parse(m['date'] as String),
        caloriesBurned: (m['calories_burned'] as num).toInt(),
        steps: (m['steps'] as num).toInt(),
        workoutDone: m['workout_done'] as bool? ?? false,
        note: m['note'] as String? ?? '',
      );
}

class DashboardRepository {
  const DashboardRepository();

  Future<TodaySummary?> todaySummary() async {
    final raw = await rootBundle.loadString('assets/json/daily_summaries.json');
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
    final List<dynamic> list = json['summaries'] as List<dynamic>? ?? <dynamic>[];
    if (list.isEmpty) return null;

    // Try to find exact today's entry first
    final todayKey = DateTime.now().toIso8601String().split('T').first;
    for (final item in list) {
      final m = item as Map<String, dynamic>;
      if ((m['date'] as String?) == todayKey) return TodaySummary.fromMap(m);
    }

    // Otherwise pick the most recent by date
    list.sort((a, b) => (b as Map<String, dynamic>)['date'].compareTo((a as Map<String, dynamic>)['date']));
    return TodaySummary.fromMap(list.first as Map<String, dynamic>);
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) => const DashboardRepository());

final todaySummaryProvider = FutureProvider<TodaySummary?>((ref) async {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.todaySummary();
});
