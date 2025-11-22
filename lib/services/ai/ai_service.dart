import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/nutrition/smart_scanner/domain/models/nutrition_estimate.dart';

/// Abstract AI service used across the app for text generation and image analysis.
abstract class AIService {
  /// Generate text (e.g. motivational message). Returns plain text.
  Future<String> generateText(String prompt);

  /// Analyze image bytes and return a nutrition estimate (mockable).
  Future<NutritionEstimate> analyzeImage(Uint8List imageBytes);
}

/// Simple mock implementation that returns canned responses with a short delay.
class MockAIService implements AIService {
  const MockAIService();

  @override
  Future<String> generateText(String prompt) async {
    await Future.delayed(const Duration(milliseconds: 250));
    // Very small heuristic/mocked message.
    if (prompt.toLowerCase().contains('motiv')) {
      return 'Güzel bir adım attın — bugün küçük ama tutarlı adımlar at. Devam et!';
    }
    return 'Bu bir mock AI yanıtıdır: $prompt';
  }

  @override
  Future<NutritionEstimate> analyzeImage(Uint8List imageBytes) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Return a deterministic mock estimate so UI/tests can rely on a stable shape.
    return const NutritionEstimate(
      calories: 420.0,
      protein: 18.0,
      carbs: 46.0,
      fat: 14.0,
      confidence: 0.72,
    );
  }
}

/// Riverpod provider exposing the app's AIService (swap with real impl later).
final aiServiceProvider = Provider<AIService>((ref) => const MockAIService());
