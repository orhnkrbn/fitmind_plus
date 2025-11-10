import 'package:flutter_test/flutter_test.dart';
import 'package:fitmind_plus_ultra_22/main.dart';

void main() {
  testWidgets('App loads smoke test', (tester) async {
    await tester.pumpWidget(const FitMindUltraApp());
    expect(find.text('FitMind+'), findsOneWidget);
  });
}
