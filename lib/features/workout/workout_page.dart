import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'models.dart';
import '../../ui/fm_scaffold.dart';

/// Fake data for workout plans
final _fakeWorkoutPlan = WorkoutPlan(
  title: 'Bu Haftanın Antrenman Planı',
  days: [
    WorkoutDay(
      dayLabel: 'Gün 1',
      title: 'Göğüs + Omuz + Kardiyo',
      durationMinutes: 55,
      difficulty: 'Orta',
      note: 'Bugünkü odak: form, nefes ve tempo.',
      exercises: [
        Exercise(name: 'Bench Press', muscleGroup: 'Göğüs', sets: 4, reps: '8-10'),
        Exercise(name: 'Incline Dumbbell Press', muscleGroup: 'Üst Göğüs', sets: 3, reps: '10-12'),
        Exercise(name: 'Cable Fly', muscleGroup: 'Göğüs', sets: 3, reps: '12-15'),
        Exercise(name: 'Side Lateral Raise', muscleGroup: 'Omuz', sets: 3, reps: '12'),
        Exercise(name: 'Overhead Press', muscleGroup: 'Omuz', sets: 4, reps: '8-10'),
        Exercise(name: 'Treadmill Run', muscleGroup: 'Kardiyo', sets: 1, reps: '15 dk'),
      ],
    ),
    WorkoutDay(
      dayLabel: 'Gün 2',
      title: 'Sırt + Bacak',
      durationMinutes: 60,
      difficulty: 'Zor',
      note: 'Ağır ağırlıklar, derin nefes.',
      exercises: [
        Exercise(name: 'Deadlift', muscleGroup: 'Sırt + Bacak', sets: 4, reps: '6-8'),
        Exercise(name: 'Pull-Up', muscleGroup: 'Sırt', sets: 4, reps: 'Max'),
        Exercise(name: 'Barbell Row', muscleGroup: 'Sırt', sets: 4, reps: '8-10'),
        Exercise(name: 'Squat', muscleGroup: 'Bacak', sets: 4, reps: '8-10'),
        Exercise(name: 'Leg Press', muscleGroup: 'Bacak', sets: 3, reps: '12'),
        Exercise(name: 'Leg Curl', muscleGroup: 'Arka Bacak', sets: 3, reps: '12'),
      ],
    ),
    WorkoutDay(
      dayLabel: 'Gün 3',
      title: 'Full Body + Esneme',
      durationMinutes: 45,
      difficulty: 'Hafif',
      note: 'Hafif tempo, maksimum hareket genişliği.',
      exercises: [
        Exercise(name: 'Goblet Squat', muscleGroup: 'Bacak', sets: 3, reps: '15'),
        Exercise(name: 'Push-Up', muscleGroup: 'Göğüs', sets: 3, reps: '15'),
        Exercise(name: 'Dumbbell Row', muscleGroup: 'Sırt', sets: 3, reps: '12'),
        Exercise(name: 'Plank', muscleGroup: 'Core', sets: 3, reps: '60 sn'),
        Exercise(name: 'Stretching', muscleGroup: 'Full Body', sets: 1, reps: '10 dk'),
      ],
    ),
  ],
);

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return FmScaffold(
      title: 'Antrenman Programı',
      subtitle: 'Bu haftanın egzersiz planı',
      body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            Text(
              _fakeWorkoutPlan.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_fakeWorkoutPlan.days.length} günlük program',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Workout day cards
            ..._fakeWorkoutPlan.days.map((day) => _buildWorkoutDayCard(context, day)),
        ],
      ),
    );
  }

  Widget _buildWorkoutDayCard(BuildContext context, WorkoutDay day) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Color difficultyColor;
    switch (day.difficulty) {
      case 'Hafif':
        difficultyColor = Colors.green.shade600;
        break;
      case 'Orta':
        difficultyColor = Colors.orange.shade600;
        break;
      case 'Zor':
        difficultyColor = Colors.red.shade600;
        break;
      default:
        difficultyColor = Colors.grey.shade600;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            context.push('/workout-detail', extra: day);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day label chip
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        day.dayLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: difficultyColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        day.difficulty,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  day.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),

                // Duration and exercise count
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 4),
                    Text(
                      '${day.durationMinutes} dk',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.fitness_center, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 4),
                    Text(
                      '${day.exercises.length} egzersiz',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Muscle groups preview
                Text(
                  day.exercises.map((e) => e.muscleGroup).toSet().join(' • '),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
