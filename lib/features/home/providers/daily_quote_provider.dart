import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> _mockQuotes = [
  'Her gün küçük bir adım, uzun yolun başlangıcıdır.',
  'Tutarlılık, yetenekten daha önemlidir.',
  'Bugün yaptıkların yarının alışkanlıklarını yaratır.',
  'Zorlandığında durma; gelişiyorsun demektir.',
  'Kendine olan inancın, sınırlarını yenmendir.',
];

/// Provides the motivational quote for a given date. If [date] is null,
/// uses DateTime.now(). Use Provider.family for testability.
final dailyQuoteProvider = Provider.family<String, DateTime?>((ref, date) {
  final d = date ?? DateTime.now();
  final idx = d.day % _mockQuotes.length;
  return _mockQuotes[idx];
});
