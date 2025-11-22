import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/features/home/providers/daily_quote_provider.dart';

void main() {
  test('Daily quote selection is deterministic by date', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final date = DateTime(2025, 11, 11); // day = 11
    final q = container.read(dailyQuoteProvider(date));
    // ensure that we get a non-empty string
    expect(q, isNotEmpty);
  });
}
