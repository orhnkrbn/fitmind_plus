class WorkoutSession {
  final String id;
  final String planId;
  final DateTime startedAt;

  WorkoutSession({required this.id, required this.planId, DateTime? startedAt}) : startedAt = startedAt ?? DateTime.now();
}
