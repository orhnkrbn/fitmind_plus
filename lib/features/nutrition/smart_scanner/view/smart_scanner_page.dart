import 'package:flutter/material.dart';

class SmartScannerPage extends StatelessWidget {
  const SmartScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akıllı Kalori Tarayıcı')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.camera_alt_outlined, size: 96, color: Colors.grey),
                const SizedBox(height: 12),
                const Text('Fotoğraftan kalori tahmini — Yakında', textAlign: TextAlign.center),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  key: const Key('smart_scanner_pick_btn'),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Fotoğraf Seç (placeholder)'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Smart scanner: Yakında')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
