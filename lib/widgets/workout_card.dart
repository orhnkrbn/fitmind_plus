import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../utils/routes.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      scale: 1,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          title: Text(workout.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            '${workout.description}\n${workout.date.toLocal().toString().split(" ").first} • ${workout.duration} dk',
          ),
          isThreeLine: true,
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.pushNamed(
            context,
            Routes.workoutDetail,
            arguments: workout,
          ),
        ),
      ),
    );
  }
}
