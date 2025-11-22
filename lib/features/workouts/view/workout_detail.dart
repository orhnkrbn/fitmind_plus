import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitmind_plus_ultra_22/features/workouts/providers/workout_plan_provider.dart';

class WorkoutDetailPage extends ConsumerWidget {
  const WorkoutDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idStr = GoRouterState.of(context).pathParameters['id'] ?? '';
    final id = int.tryParse(idStr) ?? 0;
    final plans = ref.watch(workoutPlanProvider);
    if (id < 0 || id >= plans.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Program')),
        body: const Center(child: Text('Program bulunamadı')),
      );
    }

    final plan = plans[id];

    return Scaffold(
      appBar: AppBar(title: Text(plan.day)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                title: Text('${plan.durationMinutes} dk'),
                subtitle: Text(plan.level),
              ),
            ),
            const SizedBox(height: 12),
            Text('Egzersizler', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (var i = 0; i < plan.exercises.length; i++)
              (
                () {
                  final ex = plan.exercises[i];
                  return Card(
                    key: ValueKey('${plan.day}_exercise_$i'),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(ex.name),
                      subtitle: Text(
                        '${ex.sets} x ${ex.reps} ${ex.note != null ? '• ${ex.note}' : ''}',
                      ),
                    ),
                  );
                }
              )(),
          ],
        ),
      ),
    );
  }
}
