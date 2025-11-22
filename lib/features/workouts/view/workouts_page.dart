import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitmind_plus_ultra_22/features/workouts/providers/workout_plan_provider.dart';

class WorkoutsPageView extends ConsumerWidget {
  const WorkoutsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(workoutPlanProvider);
    final mq = MediaQuery.of(context);
    final isSmall = mq.size.width < 380;

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 20,
            vertical: 12,
          ),
          itemCount: plans.length >= 3 ? 3 : plans.length,
          itemBuilder: (ctx, i) {
            final p = plans[i];
            return Card(
              key: ValueKey('workout_card_$i'),
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(child: Text(p.day.substring(0, 1))),
                title: Text(p.day),
                subtitle: Text('${p.durationMinutes} dk • ${p.level}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.go('/workouts/$i'),
              ),
            );
          },
        ),
      ),
    );
  }
}
