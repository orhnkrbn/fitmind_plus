// ignore_for_file: public_member_api_docs
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Simple exercise model used by the repository and UI.
class Exercise {
  final String name;
  final int sets;
  final String reps;
  final int restSec;
  final String tips;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.restSec,
    required this.tips,
  });

  factory Exercise.fromMap(Map<String, dynamic> m) => Exercise(
        name: m['name'] as String? ?? '',
        sets: (m['sets'] is int) ? m['sets'] as int : int.tryParse('${m['sets']}') ?? 0,
        reps: m['reps'] as String? ?? '${m['reps'] ?? ''}',
        restSec: (m['rest_sec'] is int) ? m['rest_sec'] as int : int.tryParse('${m['rest_sec']}') ?? (m['restSec'] is int ? m['restSec'] as int : 60),
        tips: m['tips'] as String? ?? '',
      );
}

/// One day entry in the plan.
class WorkoutDay {
  final String day;
  final List<Exercise> exercises;

  WorkoutDay({required this.day, required this.exercises});
}

class WorkoutsRepository {
  const WorkoutsRepository();

  Future<List<WorkoutDay>> getPlan({String goal = 'fatloss'}) async {
    final raw = await rootBundle.loadString('assets/json/workouts_ppl.json');
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;

    final List<dynamic> weeks = json['weeks'] as List<dynamic>? ?? <dynamic>[];

    // Flatten days from the first week that contains detailed exercises if possible.
    // If multiple weeks contain 'days' with exercises, return the first full week's days.
    for (final w in weeks) {
      final Map<String, dynamic> week = w as Map<String, dynamic>;
      final days = week['days'] as List<dynamic>?;
      if (days == null) continue;

      final List<WorkoutDay> result = [];
      for (final d in days) {
        final Map<String, dynamic> dayMap = d as Map<String, dynamic>;

        // Some day entries may be simplified (only name/variant). Skip those without exercises.
        final exercisesRaw = dayMap['exercises'] as List<dynamic>?;
        if (exercisesRaw == null) continue;

        // Some entries include a 'goal' array; respect it when present.
        final goalList = (dayMap['goal'] as List<dynamic>?)?.map((e) => e.toString()).toList();
        if (goalList != null && goalList.isNotEmpty && !goalList.contains(goal)) {
          // skip this day for the requested goal
          continue;
        }

        final exercises = exercisesRaw.map((e) => Exercise.fromMap(e as Map<String, dynamic>)).toList();
        result.add(WorkoutDay(day: dayMap['day'] as String? ?? 'Unknown', exercises: exercises));
      }

      if (result.isNotEmpty) return result;
    }

    // Fallback: return empty list if nothing found
    return <WorkoutDay>[];
  }
}

// Riverpod providers
final workoutsRepositoryProvider = Provider<WorkoutsRepository>((ref) => const WorkoutsRepository());

final weeklyWorkoutPlanProvider = FutureProvider.family<List<WorkoutDay>, String>((ref, goal) async {
  final repo = ref.watch(workoutsRepositoryProvider);
  return repo.getPlan(goal: goal);
});

