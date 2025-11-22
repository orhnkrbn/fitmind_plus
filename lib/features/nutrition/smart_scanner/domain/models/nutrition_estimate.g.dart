// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_estimate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NutritionEstimate _$NutritionEstimateFromJson(Map<String, dynamic> json) =>
    _NutritionEstimate(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$NutritionEstimateToJson(_NutritionEstimate instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'confidence': instance.confidence,
    };
