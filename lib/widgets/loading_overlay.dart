import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: const SizedBox(
        height: 56,
        width: 56,
        child: CircularProgressIndicator(strokeWidth: 4),
      ),
    );
  }
}
