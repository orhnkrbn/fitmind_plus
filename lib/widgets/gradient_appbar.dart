import 'package:flutter/material.dart';

PreferredSizeWidget gradientAppBar(String title) {
  return AppBar(
    title: Text(title),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5B4BDF), Color(0xFF9C6CF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
}
