import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../nutrition/smart_scanner/domain/i_smart_scanner.dart';
import '../../../nutrition/smart_scanner/domain/models/nutrition_estimate.dart';
import '../../../../services/ai/ai_service.dart';

class SmartScannerImpl implements ISmartScanner {
  final AIService _ai;

  SmartScannerImpl(this._ai);

  @override
  Future<NutritionEstimate> analyzePhoto(Uint8List bytes) async {
    // For MVP, forward to AIService mock/implementation.
    return _ai.analyzeImage(bytes);
  }
}

final smartScannerProvider = Provider<ISmartScanner>((ref) {
  final ai = ref.read(aiServiceProvider);
  return SmartScannerImpl(ai);
});
