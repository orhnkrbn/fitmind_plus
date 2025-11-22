import 'package:flutter/material.dart';
import 'models.dart';
import '../../ui/fm_scaffold.dart';

class WorkoutDetailPage extends StatelessWidget {
  final WorkoutDay workoutDay;

  const WorkoutDetailPage({
    super.key,
    required this.workoutDay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FmScaffold(
      title: workoutDay.title,
      subtitle: '${workoutDay.dayLabel} • ${workoutDay.durationMinutes} dk • ${workoutDay.difficulty}',
      body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          workoutDay.dayLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.schedule, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                      const SizedBox(width: 4),
                      Text(
                        '${workoutDay.durationMinutes} dk',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${workoutDay.exercises.length} Egzersiz',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Exercise list
            Text(
              'Egzersizler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            ...workoutDay.exercises.asMap().entries.map((entry) {
              final index = entry.key;
              final exercise = entry.value;
              return _buildExerciseCard(context, index + 1, exercise);
            }),

            const SizedBox(height: 24),

            // Note section
            if (workoutDay.note != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade700.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.amber.shade700.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Not',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      workoutDay.note!,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
        ],
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context, int number, Exercise exercise) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Number badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber.shade600,
                  Colors.amber.shade800,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Exercise info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exercise.muscleGroup,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.repeat, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 4),
                    Text(
                      '${exercise.sets} set',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.fitness_center, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 4),
                    Text(
                      '${exercise.reps} tekrar',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
