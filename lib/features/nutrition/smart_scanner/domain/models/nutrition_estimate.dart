import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_estimate.freezed.dart';
part 'nutrition_estimate.g.dart';

@freezed
abstract class NutritionEstimate with _$NutritionEstimate {
  const factory NutritionEstimate({
    required double calories,
    required double protein,
    required double carbs,
    required double fat,

    /// Confidence between 0.0 and 1.0
    required double confidence,
  }) = _NutritionEstimate;

  factory NutritionEstimate.fromJson(Map<String, dynamic> json) => _$NutritionEstimateFromJson(json);
}
