// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final u = auth.user; // firebaseUser ile aynı

    return Scaffold(
      appBar: AppBar(title: const Text('FitMind+')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (u != null) ...[
              Text('Hoş geldin, ${u.email ?? u.uid}'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => auth.signOut(),
                child: const Text('Çıkış yap'),
              ),
            ] else ...[
              const Text('Giriş yapmadın'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final err = await auth.signInWithGoogle();
                  if (!context.mounted) return;
                  if (err != null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(err)));
                  }
                },
                child: const Text('Google ile giriş'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
