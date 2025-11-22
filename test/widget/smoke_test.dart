// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fitmind_plus_ultra_22/app/app.dart';

void main() {
  testWidgets('FitMindApp builds and has title', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FitMindApp()));
    await tester.pumpAndSettle();

    final material = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(material.title, 'FitMind+');
  });
}
