// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  name: json['name'] as String,
  age: (json['age'] as num?)?.toInt(),
  heightCm: (json['heightCm'] as num?)?.toDouble(),
  weightKg: (json['weightKg'] as num?)?.toDouble(),
  goal: json['goal'] as String? ?? 'recomp',
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'heightCm': instance.heightCm,
      'weightKg': instance.weightKg,
      'goal': instance.goal,
    };
