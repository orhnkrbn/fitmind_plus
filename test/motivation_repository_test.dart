import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/features/motivation/data/motivation_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('randomQuoteProvider returns a non-empty quote for neutral mood', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final quote = await container.read(randomQuoteProvider('neutral').future);
    expect(quote, isNotEmpty);
  });
}
