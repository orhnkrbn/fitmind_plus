import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/features/workouts/data/workouts_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('weeklyWorkoutPlanProvider loads a non-empty plan for fatloss', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final plan = await container.read(weeklyWorkoutPlanProvider('fatloss').future);
    expect(plan, isNotNull);
    expect(plan, isNotEmpty);
    final first = plan.first;
    expect(first.day, isNotEmpty);
    expect(first.exercises, isNotEmpty);
  });
}
