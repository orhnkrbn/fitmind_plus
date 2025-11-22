import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fitmind_plus_ultra_22/app/app.dart';
import 'package:fitmind_plus_ultra_22/app/router.dart' as app_router;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates to workouts and finds AI suggestion button', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FitMindApp()));

    // Ensure the app is built
    await tester.pumpAndSettle();

    // Navigate directly to workouts route
    app_router.router.go('/workouts');
    await tester.pumpAndSettle();

    // Expect to find the AI suggestion button on Workouts page
    expect(find.text('AI Önerisi Al'), findsOneWidget);
  });
}
