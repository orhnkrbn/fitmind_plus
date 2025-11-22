// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'ai_service.dart';

class MockAIService implements AIService {
  const MockAIService();

  @override
  Future<String> suggestPlan({
    required String goal,
    required int weeklyDays,
    required int experienceLevel,
  }) async {
    // Small artificial delay to simulate network/compute latency.
    await Future.delayed(const Duration(milliseconds: 250));

    final levelLabel =
        experienceLevel <= 0 ? 'beginner' : (experienceLevel == 1 ? 'intermediate' : 'advanced');

    return 'Plan suggestion: $goal-oriented, $weeklyDays days/week, suitable for $levelLabel.\n'
        'Sample split: ${_sampleSplit(weeklyDays)}. Start light and progress each week.';
  }

  @override
  Future<String> dailyMotivation({required String mood}) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final lower = mood.toLowerCase();
    if (lower.contains('tired') || lower.contains('yorgun')) {
      return 'Küçük bir mola al, sonra 10 dakika hafif hareketle başla — minik kazanımlar büyük fark yaratır.';
    }
    if (lower.contains('stressed') || lower.contains('stres')) {
      return 'Derin bir nefes al. 3-4-5 nefes döngüsüyle rahatla, sonra kısa bir yürüyüş iyi gelir.';
    }

    return 'Harika hissettiğine sevindim — bugün hedeflerine küçük bir adım at! Hadi başlayalım.';
  }

  String _sampleSplit(int days) {
    if (days <= 2) return 'full-body 2x';
    if (days == 3) return 'push/pull/legs';
    if (days == 4) return 'upper/lower split';
    return 'push/pull/legs + accessory day';
  }
}
