// ignore_for_file: public_member_api_docs

abstract class AIService {
  /// Suggest a workout plan summary for the given goal, available days per week
  /// and experience level (e.g. 0=beginner,1=intermediate,2=advanced).
  Future<String> suggestPlan({
    required String goal,
    required int weeklyDays,
    required int experienceLevel,
  });

  /// Return a short motivational message based on the user's current mood.
  Future<String> dailyMotivation({required String mood});
}
