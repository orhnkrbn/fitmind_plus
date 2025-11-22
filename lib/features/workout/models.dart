// Workout Models

class WorkoutPlan {
  final String title;
  final List<WorkoutDay> days;

  WorkoutPlan({required this.title, required this.days});
}

class WorkoutDay {
  final String dayLabel; // "Gün 1", "Gün 2"
  final String title; // "Göğüs + Omuz + Kardiyo"
  final int durationMinutes;
  final String difficulty; // "Hafif", "Orta", "Zor"
  final List<Exercise> exercises;
  final String? note;

  WorkoutDay({
    required this.dayLabel,
    required this.title,
    required this.durationMinutes,
    required this.difficulty,
    required this.exercises,
    this.note,
  });
}

class Exercise {
  final String name;
  final String muscleGroup;
  final int sets;
  final String reps; // "12", "10-12", "Max"

  Exercise({
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
  });
}
