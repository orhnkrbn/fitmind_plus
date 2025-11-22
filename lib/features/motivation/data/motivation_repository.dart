// ignore_for_file: public_member_api_docs
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MotivationRepository {
  const MotivationRepository();

  Future<String> randomQuote({String mood = 'neutral'}) async {
    final raw = await rootBundle.loadString('assets/json/motivation_quotes.json');
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
    final List<dynamic> quotes = json['quotes'] as List<dynamic>? ?? <dynamic>[];

    final filtered = quotes.where((q) {
      final m = (q as Map<String, dynamic>)['mood'] as String? ?? 'neutral';
      return m == mood || mood == 'neutral';
    }).toList();

    final list = filtered.isNotEmpty ? filtered : quotes;
    if (list.isEmpty) return 'Devam et — her adım değerli.';

    final rnd = Random();
    final chosen = list[rnd.nextInt(list.length)] as Map<String, dynamic>;
    return chosen['text'] as String? ?? 'Devam et — her adım değerli.';
  }
}

final motivationRepositoryProvider = Provider<MotivationRepository>((ref) => const MotivationRepository());

final randomQuoteProvider = FutureProvider.family<String, String>((ref, mood) async {
  final repo = ref.watch(motivationRepositoryProvider);
  return repo.randomQuote(mood: mood);
});

