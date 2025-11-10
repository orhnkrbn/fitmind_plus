import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  final List<Map<String, dynamic>> _meals = const [
    {"name": "Kahvaltı", "calories": 350},
    {"name": "Ara Öğün", "calories": 150},
    {"name": "Öğle Yemeği", "calories": 500},
    {"name": "Ara Öğün", "calories": 200},
    {"name": "Akşam Yemeği", "calories": 450},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beslenme Takibi"),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _meals.length,
          itemBuilder: (context, index) {
            final meal = _meals[index];
            return _AnimatedMealCard(
              title: meal["name"],
              calories: meal["calories"],
              delay: (index + 1) * 300,
            );
          },
        ),
      ),
    );
  }
}

// -------------------- Animated Meal Card --------------------
class _AnimatedMealCard extends StatefulWidget {
  final String title;
  final int calories;
  final int delay;

  const _AnimatedMealCard(
      {required this.title, required this.calories, required this.delay});

  @override
  State<_AnimatedMealCard> createState() => _AnimatedMealCardState();
}

class _AnimatedMealCardState extends State<_AnimatedMealCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Row(
                children: [
                  const Icon(Icons.local_fire_department,
                      color: Colors.orangeAccent),
                  const SizedBox(width: 6),
                  Text(
                    "${widget.calories} kcal",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
