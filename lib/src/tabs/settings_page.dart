import 'package:flutter/material.dart';
import '../widgets/golden_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tm = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(
        children: [
          GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Görünüm', style: tm.textTheme.titleMedium),
                const SizedBox(height: 8),
                const Text('Sistem temasını kullanır. Yakında: Elle tema seçimi, renk ayarı.'),
              ],
            ),
          ),
          GoldenCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hakkında', style: tm.textTheme.titleMedium),
                const SizedBox(height: 8),
                const Text('FitMind+ — Fitness & motivasyon asistanı.\nSürüm 1.0.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}