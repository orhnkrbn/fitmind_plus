import 'package:flutter/material.dart';
import '../widgets/golden_card.dart';
import '../services/prefs_service.dart';
import '../models/meal.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final _name = TextEditingController();
  final _cal = TextEditingController();
  final _pro = TextEditingController();
  final _svc = PrefsService();
  List<MealItem> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _items = await _svc.getMeals();
    if (mounted) setState(() {});
  }

  Future<void> _add() async {
    if (_name.text.isEmpty) return;
    final m = MealItem(
      name: _name.text,
      calories: int.tryParse(_cal.text) ?? 0,
      protein: int.tryParse(_pro.text) ?? 0,
    );
    await _svc.saveMeal(m);
    _name.clear(); _cal.clear(); _pro.clear();
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final totalCal = _items.fold<int>(0, (p, e) => p + e.calories);
    final totalPro = _items.fold<int>(0, (p, e) => p + e.protein);
    return Scaffold(
      appBar: AppBar(title: const Text('Beslenme')),
      body: ListView(
        children: [
          GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Öğün Ekle', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                TextField(controller: _name, decoration: const InputDecoration(labelText: 'Yemek Adı')),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: TextField(controller: _cal, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Kalori'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextField(controller: _pro, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Protein (g)'))),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton(onPressed: _add, child: const Text('Ekle')),
              ],
            ),
          ),
          GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bugün', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final m in _items) Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(m.name),
                      Text("${m.calories} kcal • ${m.protein}g P"),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Toplam'),
                    Text("${totalCal} kcal • ${totalPro}g P", style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}