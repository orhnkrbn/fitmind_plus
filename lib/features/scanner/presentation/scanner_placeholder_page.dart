// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

class ScannerPlaceholderPage extends StatelessWidget {
  const ScannerPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner')),
      body: const Center(
        child: Text('Yakında: Fotoğraftan yiyecek analizi (placeholder)', textAlign: TextAlign.center),
      ),
    );
  }
}

