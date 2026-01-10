import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFF26430);
  static const Color primaryDark = Color(0xFFCC4A21);
  static const Color accent = Color(0xFF1F9D8A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F5F1);
  static const Color text = Color(0xFF2C2C2C);
  static const Color mutedText = Color(0xFF6D6D6D);
}

class AppGradients {
  static const LinearGradient hero = LinearGradient(
    colors: [
      Color(0xFFFF7A3D),
      Color(0xFFF26430),
      Color(0xFFE05225),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.spaceGroteskTextTheme(base.textTheme).apply(
        bodyColor: AppColors.text,
        displayColor: AppColors.text,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.mutedText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Convenience aliases used across legacy UI code.
  // They map to the new design system (AppColors/AppShadows/AppRadii).
  // NOTE: These are *fields* (not getters) so they can be used inside const
  // widgets (e.g., const Icon(color: AppTheme.primary)).
  static const Color primary = AppColors.primary;
  static const Color primaryDark = AppColors.primaryDark;
  static const Color secondary = AppColors.accent;
  static const Color muted = AppColors.mutedText;

  static const Color border = Color(0xFFE6E8EF);

  static TextTheme get textTheme => light().textTheme;

  static List<BoxShadow> get shadow => AppShadows.soft;

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: border),
        boxShadow: shadow,
      );
}

/// Shadow presets used by [AppTheme].
class AppShadows {
  AppShadows._();

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x14000000), // ~8% black
      blurRadius: 18,
      offset: Offset(0, 10),
    ),
  ];
}

/// Radius presets used by [AppTheme].
class AppRadii {
  AppRadii._();

  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
}
