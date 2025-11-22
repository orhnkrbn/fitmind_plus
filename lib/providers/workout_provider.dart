import 'package:flutter/foundation.dart';
import '../models/workout.dart';
import '../services/workout_service.dart';

class WorkoutProvider extends ChangeNotifier {
  final _service = WorkoutService();

  List<Workout> items = [];
  bool loading = false;

  Future<void> fetchForUser(String uid) async {
    loading = true;
    notifyListeners();
    items = await _service.fetch(uid);
    loading = false;
    notifyListeners();
  }

  Future<void> add(String uid, Workout w) async {
    await _service.add(uid, w);
    await fetchForUser(uid);
  }
}
