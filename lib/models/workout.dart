import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime date;
  final int duration; // minutes
  final List<Map<String, dynamic>> exercises; // [{name, sets, reps, weight}]

  Workout({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.duration,
    required this.exercises,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(date),
        'duration': duration,
        'exercises': exercises,
      };

  factory Workout.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Workout(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] is Timestamp)
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
      duration: data['duration'] ?? 0,
      exercises: List<Map<String, dynamic>>.from(data['exercises'] ?? []),
    );
  }
}
