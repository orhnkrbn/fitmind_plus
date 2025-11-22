import 'package:flutter/material.dart';

/// Premium dark theme with golden accent colors and refined spacing based on golden ratio
class AppTheme {
  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFC857)),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData dark() {
    const primaryGold = Color(0xFFFFC857);
    const secondaryAmber = Color(0xFFFFB347);
    const darkBg = Color(0xFF050816);
    const surfaceDark = Color(0xFF0D1326);
    const surfaceVariant = Color(0xFF1A1F3A);
    
    const colorScheme = ColorScheme.dark(
      primary: primaryGold,
      secondary: secondaryAmber,
      surface: surfaceDark,
      surfaceContainerHighest: surfaceVariant,
      onPrimary: Colors.black87,
      onSecondary: Colors.black87,
      onSurface: Colors.white,
      outline: Color(0xFF3A3F5A),
      outlineVariant: Color(0xFF2A2F4A),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: darkBg,
      textTheme: AppTextStyles.textTheme(colorScheme),
      
      // Card theme
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
        ),
        elevation: 6,
        color: surfaceDark,
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: Colors.black87,
          elevation: 4,
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(120, 48),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Filled button theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: primaryGold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      // NavigationBar theme for bottom navigation
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceDark,
        elevation: 8,
        height: 80,
        indicatorColor: primaryGold.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryGold,
              letterSpacing: 0.5,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.6),
            letterSpacing: 0.5,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryGold, size: 28);
          }
          return IconThemeData(
            color: Colors.white.withValues(alpha: 0.6),
            size: 24,
          );
        }),
      ),

      // Text selection theme
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryGold,
        selectionColor: primaryGold.withValues(alpha: 0.3),
        selectionHandleColor: primaryGold,
      ),
    );
  }
}

/// Design tokens for spacing based on golden ratio (φ ≈ 1.618)
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;   // Base unit
  static const double sm = 8.0;   // xs × 2
  static const double md = 13.0;  // sm × φ ≈ 13
  static const double lg = 21.0;  // md × φ ≈ 21
  static const double xl = 34.0;  // lg × φ ≈ 34
  static const double xxl = 55.0; // xl × φ ≈ 55
}

/// Border radius values for different UI elements
class AppRadius {
  AppRadius._();

  static const double card = 20.0;
  static const double cardLarge = 24.0;
  static const double chip = 999.0; // Full pill shape
  static const double button = 16.0;
  static const double input = 16.0;
  static const double dialog = 20.0;
  
  // Backward compatibility
  static const double cardRadius = card;
  static const double buttonRadius = button;
}

/// Color utilities
class AppColors {
  AppColors._();

  static const Color primaryGold = Color(0xFFFFC857);
  static const Color secondaryGold = Color(0xFFFFB347);
  static const Color darkBg = Color(0xFF050816);
  static const Color surfaceDark = Color(0xFF0D1326);
  
  /// Shadow color for cards
  static Color shadowColor(bool isDark) => isDark ? Colors.black26 : Colors.black12;
  
  /// Gradient for premium UI elements
  static LinearGradient goldGradient() {
    return const LinearGradient(
      colors: [Color(0xFFFFC857), Color(0xFFFFB347)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

/// Typography scale based on golden ratio
class AppTextStyles {
  AppTextStyles._();

  static TextTheme textTheme(ColorScheme cs) {
    return TextTheme(
      // Headings
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: cs.onSurface,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: cs.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: cs.onSurface,
      ),
      
      // Titles
      titleLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w600,
        color: cs.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: cs.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: cs.onSurface,
      ),
      
      // Body
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: cs.onSurface,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: cs.onSurface,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: cs.onSurface.withValues(alpha: 0.7),
        height: 1.4,
      ),
      
      // Labels
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: cs.onSurface,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: cs.onSurface,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: cs.onSurface.withValues(alpha: 0.7),
        letterSpacing: 0.5,
      ),
    );
  }
}
