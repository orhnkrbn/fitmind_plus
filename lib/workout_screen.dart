import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final List<Map<String, dynamic>> _workouts = [
    {"name": "Göğüs", "progress": 0.7},
    {"name": "Sırt", "progress": 0.5},
    {"name": "Bacak", "progress": 0.4},
    {"name": "Karın", "progress": 0.6},
    {"name": "Omuz", "progress": 0.3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Günlük Antrenman"),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _workouts.length,
          itemBuilder: (context, index) {
            final workout = _workouts[index];
            return _AnimatedWorkoutCard(
              title: workout["name"],
              progress: workout["progress"],
              onUpdate: (value) {
                setState(() {
                  _workouts[index]["progress"] = value;
                });
              },
              delay: (index + 1) * 300,
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedWorkoutCard extends StatefulWidget {
  final String title;
  final double progress;
  final int delay;
  final Function(double) onUpdate;

  const _AnimatedWorkoutCard({
    required this.title,
    required this.progress,
    required this.delay,
    required this.onUpdate,
  });

  @override
  State<_AnimatedWorkoutCard> createState() => _AnimatedWorkoutCardState();
}

class _AnimatedWorkoutCardState extends State<_AnimatedWorkoutCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  void _increaseProgress() {
    setState(() {
      _progress += 0.1;
      if (_progress > 1) _progress = 1;
      widget.onUpdate(_progress);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnim,
      child: Card(
        color: Colors.white24,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    height: 12,
                    width: MediaQuery.of(context).size.width * _progress,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _increaseProgress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                ),
                child: const Text("Tamamlandı +10%"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
