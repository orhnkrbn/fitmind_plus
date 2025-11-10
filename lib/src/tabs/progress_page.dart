import 'package:flutter/material.dart';
import '../widgets/golden_card.dart';
import '../services/prefs_service.dart';
import '../models/measurement.dart';
import '../widgets/sparkline.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final _svc = PrefsService();
  final _weight = TextEditingController();
  final _waist = TextEditingController();
  final _chest = TextEditingController();
  List<Measurement> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _items = await _svc.getMeasurements();
    if (mounted) setState(() {});
  }

  Future<void> _add() async {
    final m = Measurement(
      date: DateTime.now(),
      weight: double.tryParse(_weight.text) ?? 0,
      waist: double.tryParse(_waist.text) ?? 0,
      chest: double.tryParse(_chest.text) ?? 0,
    );
    await _svc.saveMeasurement(m);
    _weight.clear(); _waist.clear(); _chest.clear();
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final weights = _items.map((e) => e.weight).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('İlerleme')),
      body: ListView(
        children: [
          GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ölçü Gir', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: TextField(controller: _weight, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Kilo (kg)'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextField(controller: _waist, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Bel (cm)'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextField(controller: _chest, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Göğüs (cm)'))),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton(onPressed: _add, child: const Text('Kaydet')),
              ],
            ),
          ),
          GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kilo Grafiği', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Sparkline(values: weights.isEmpty ? [0,0,0] : weights),
                const SizedBox(height: 8),
                if (_items.isNotEmpty)
                  Text('Son kayıt: ${_items.last.weight.toStringAsFixed(1)} kg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}