import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/features/workouts/providers/workout_plan_provider.dart';

void main() {
  test('WorkoutPlanProvider returns a weekly plan', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final plans = container.read(workoutPlanProvider);
    expect(plans, isNotEmpty);
    expect(plans.length, greaterThanOrEqualTo(5));
    final monday = plans.first;
    expect(monday.day, isNotEmpty);
    expect(monday.exercises, isNotEmpty);
  });
}
