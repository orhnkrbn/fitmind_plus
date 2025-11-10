
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const Scaffold(body: Center(child: Text('Dashboard')))),
      GoRoute(path: '/nutrition/history', builder: (_, __) => const Scaffold(body: Center(child: Text('History')))),
    ],
  );
});
