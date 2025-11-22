import 'package:flutter/material.dart';
import 'screens/motivation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final navigator = Navigator.of(context);
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => const MotivationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "FitMind+",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
