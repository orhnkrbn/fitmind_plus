import 'package:flutter/material.dart';
import '../widgets/golden_card.dart';
import '../models/workout.dart';
import '../theme.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final _plans = <Workout>[
    Workout(title: 'Gün 1 — Göğüs & Triceps', exercises: ['Bench Press', 'Incline DB Press', 'Cable Fly', 'Triceps Pushdown']),
    Workout(title: 'Gün 2 — Sırt & Biceps', exercises: ['Deadlift', 'Lat Pulldown', 'Row', 'Curl']),
    Workout(title: 'Gün 3 — Omuz & Bacak', exercises: ['Squat', 'OHP', 'Lateral Raise', 'Leg Curl']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antrenman')),
      body: ListView.builder(
        itemCount: _plans.length,
        itemBuilder: (ctx, i) {
          final w = _plans[i];
          return GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(w.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final ex in w.exercises) Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4 * phi),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 18),
                      const SizedBox(width: 8),
                      Text(ex),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: const Text('Başlat')),
                    const SizedBox(width: 8),
                    OutlinedButton(onPressed: (){}, child: const Text('Düzenle')),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}