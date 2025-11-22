import 'package:flutter/material.dart';

/// App-wide spacing, radius, durations and elevation constants.
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
}

class AppDurations {
  static const Duration short = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration long = Duration(milliseconds: 400);
}

class AppElevations {
  static const double low = 2.0;
  static const double medium = 6.0;
  static const double high = 12.0;
}

/// A small helper for commonly used rounded shapes.
class AppShapes {
  static RoundedRectangleBorder rounded16 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );
}
