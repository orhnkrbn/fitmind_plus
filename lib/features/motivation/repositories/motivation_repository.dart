abstract class MotivationRepository {
  /// Fetch a small list of motivational suggestions.
  /// In future this will call an AI service; keep the interface stable.
  Future<List<String>> fetchSuggestions();
}

/// A simple mock implementation used for local UI and tests.
class MockMotivationRepository implements MotivationRepository {
  MockMotivationRepository();

  @override
  Future<List<String>> fetchSuggestions() async {
    // Simulate a tiny delay like a network call
    await Future.delayed(const Duration(milliseconds: 120));
    return const [
      'Bugün küçük bir adım at — ilerleme süreklidir.',
      'Kendine nazik ol; her tekrar güçlendirir.',
      'Zorlandığında, hedefini hatırla ve tekrar dene.',
    ];
  }
}
