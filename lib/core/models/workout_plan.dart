// ignore_for_file: public_member_api_docs
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_plan.freezed.dart';
part 'workout_plan.g.dart';

@freezed
abstract class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String id,
    required String name,
    required List<String> days,
    @Default(<String>[]) List<String> notes,
  }) = _WorkoutPlan;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => _$WorkoutPlanFromJson(json);
}

