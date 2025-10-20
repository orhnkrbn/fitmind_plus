import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout.dart';

class WorkoutService {
  final _db = FirebaseFirestore.instance;

  Future<List<Workout>> fetch(String uid) async {
    final q = await _db
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .orderBy('date', descending: true)
        .get();
    return q.docs.map((d) => Workout.fromDoc(d)).toList();
  }

  Future<void> add(String uid, Workout w) async {
    await _db.collection('users').doc(uid).collection('workouts').add(w.toMap());
  }

  Stream<List<Workout>> watch(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .orderBy('date', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => Workout.fromDoc(d)).toList());
  }
}
