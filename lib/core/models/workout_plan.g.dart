// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) => _WorkoutPlan(
  id: json['id'] as String,
  name: json['name'] as String,
  days: (json['days'] as List<dynamic>).map((e) => e as String).toList(),
  notes:
      (json['notes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$WorkoutPlanToJson(_WorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'days': instance.days,
      'notes': instance.notes,
    };
