import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_plan.dart';

/// Provides a mock weekly split of workout plans.
final workoutPlanProvider = Provider<List<WorkoutPlan>>((ref) {
  return [
    const WorkoutPlan(
      day: 'Monday',
      durationMinutes: 30,
      level: 'Beginner',
      exercises: [
        Exercise(name: 'Squat', sets: 3, reps: 10),
        Exercise(name: 'Push-up', sets: 3, reps: 12),
      ],
    ),
    const WorkoutPlan(
      day: 'Tuesday',
      durationMinutes: 35,
      level: 'Beginner',
      exercises: [
        Exercise(name: 'Deadlift', sets: 3, reps: 8),
        Exercise(name: 'Row', sets: 3, reps: 10),
      ],
    ),
    const WorkoutPlan(
      day: 'Wednesday',
      durationMinutes: 25,
      level: 'Active Recovery',
      exercises: [
        Exercise(name: 'Plank', sets: 3, reps: 60, note: 'seconds'),
        Exercise(name: 'Stretching', sets: 1, reps: 1, note: '10 minutes'),
      ],
    ),
    const WorkoutPlan(
      day: 'Thursday',
      durationMinutes: 40,
      level: 'Intermediate',
      exercises: [
        Exercise(name: 'Bench Press', sets: 4, reps: 8),
        Exercise(name: 'Incline DB Press', sets: 3, reps: 10),
      ],
    ),
    const WorkoutPlan(
      day: 'Friday',
      durationMinutes: 30,
      level: 'Intermediate',
      exercises: [
        Exercise(name: 'Overhead Press', sets: 3, reps: 8),
        Exercise(name: 'Lateral Raise', sets: 3, reps: 12),
      ],
    ),
    const WorkoutPlan(
      day: 'Saturday',
      durationMinutes: 50,
      level: 'Advanced',
      exercises: [
        Exercise(name: 'Squat (heavy)', sets: 5, reps: 5),
        Exercise(name: 'Romanian Deadlift', sets: 4, reps: 8),
      ],
    ),
    const WorkoutPlan(
      day: 'Sunday',
      durationMinutes: 20,
      level: 'Rest',
      exercises: [
        Exercise(name: 'Walking', sets: 1, reps: 1, note: '30-60 minutes'),
      ],
    ),
  ];
});
