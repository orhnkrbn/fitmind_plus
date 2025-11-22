// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  name: json['name'] as String,
  sets: (json['sets'] as num).toInt(),
  reps: (json['reps'] as num).toInt(),
  note: json['note'] as String?,
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'name': instance.name,
  'sets': instance.sets,
  'reps': instance.reps,
  'note': instance.note,
};

_WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) => _WorkoutPlan(
  day: json['day'] as String,
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  level: json['level'] as String,
  exercises: (json['exercises'] as List<dynamic>)
      .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WorkoutPlanToJson(_WorkoutPlan instance) =>
    <String, dynamic>{
      'day': instance.day,
      'durationMinutes': instance.durationMinutes,
      'level': instance.level,
      'exercises': instance.exercises,
    };
