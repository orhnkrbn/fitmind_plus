
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../src/splash.dart';
import '../src/home_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      /// Splash screen shown at startup. After the short delay it navigates
      /// to `/home` using GoRouter (see `lib/src/splash.dart`).
      GoRoute(path: '/', builder: (_, __) => const SplashGate()),

      /// Main shell with bottom navigation.
      GoRoute(path: '/home', builder: (_, __) => const HomeShell()),

      /// Existing feature route kept as example.
      GoRoute(path: '/nutrition/history', builder: (_, __) => const Scaffold(body: Center(child: Text('History')))),
      GoRoute(path: '/counter', builder: (_, __) => const _CounterPlaceholder()),
    ],
  );
});

class _CounterPlaceholder extends StatelessWidget {
  const _CounterPlaceholder({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Open /counter route to see Counter (use feature branch)')));
}
