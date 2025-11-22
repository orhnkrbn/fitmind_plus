import 'package:flutter/material.dart';
import '../theme.dart';

class GoldenCard extends StatelessWidget {
  final Widget child;
  const GoldenCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: goldenPad(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: goldenPad(10),
        child: child,
      ),
    );
  }
}