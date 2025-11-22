import 'dart:typed_data';

import 'models/nutrition_estimate.dart';

/// Interface for smart-scanner implementations.
abstract class ISmartScanner {
  /// Analyze the provided image bytes and return a nutrition estimate.
  Future<NutritionEstimate> analyzePhoto(Uint8List bytes);
}
