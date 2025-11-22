import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../widgets/gradient_appbar.dart';

class WorkoutDetailScreen extends StatelessWidget {
  static const routeName = '/workout_detail';
  const WorkoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Workout w = ModalRoute.of(context)!.settings.arguments as Workout;

    return Scaffold(
      appBar: gradientAppBar('Antrenman Detayı'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(w.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text('${w.date.toLocal().toString().split(" ").first} • ${w.duration} dk'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(w.description),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Hareketler', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          if (w.exercises.isEmpty)
            const Text('Kayıtlı hareket yok.')
          else
            ...w.exercises.map((e) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(e['name'] ?? ''),
                    subtitle: Text('${e['sets'] ?? '?'} set • ${e['reps'] ?? '?'} tekrar • ${e['weight'] ?? '-'} kg'),
                  ),
                )),
        ],
      ),
    );
  }
}
