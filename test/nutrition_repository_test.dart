import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/features/nutrition/data/nutrition_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('weeklyMealPlanProvider returns a 7-day plan for fatloss', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final plan = await container.read(weeklyMealPlanProvider('fatloss').future);
    expect(plan, isNotNull);
    expect(plan.days, isNotEmpty);
    expect(plan.days.length, greaterThanOrEqualTo(7));
    final today = plan.days.first;
    expect(today.breakfast.name, isNotEmpty);
  });
}
