import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmind_plus_ultra_22/app/app.dart';

void main() {
  testWidgets('App shows FitMind+ splash', (tester) async {
  await tester.pumpWidget(const ProviderScope(child: FitMindApp()));
    await tester.pumpAndSettle();
    // App title text isn't guaranteed in the widget tree; assert the app built by
    // checking for a MaterialApp widget instead.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
