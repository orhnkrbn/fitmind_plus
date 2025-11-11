import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashGate extends StatefulWidget {
  const SplashGate({super.key});

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Use GoRouter to navigate so navigation is consistent with app router.
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 72, color: cs.primary),
            const SizedBox(height: 16),
            Text('FitMind+', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text('Güç • Disiplin • Zihin'),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}