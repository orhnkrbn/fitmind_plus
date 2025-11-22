import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_plan.freezed.dart';
part 'workout_plan.g.dart';

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String name,
    required int sets,
    required int reps,
    String? note,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}

@freezed
abstract class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String day,
    required int durationMinutes,
    required String level,
    required List<Exercise> exercises,
  }) = _WorkoutPlan;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);
}
