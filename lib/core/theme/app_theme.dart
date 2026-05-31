import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors (Vibrant Amber & Deep Charcoal)
  static const Color primaryColor = Color(0xFFFF7A00); // Vibrant Amber Orange
  static const Color primaryDark = Color(0xFFE05300);
  static const Color secondaryColor = Color(0xFFFFB03A);
  
  static const Color darkBackground = Color(0xFF0F0F13); // Deep Dark Slate
  static const Color darkSurface = Color(0xFF1B1B22); // Dark Card/Surface
  static const Color darkCardHover = Color(0xFF262630);
  
  static const Color lightBackground = Color(0xFFFAFAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  
  static const Color textDark = Color(0xFF0F0F13);
  static const Color textLight = Color(0xFFF3F3F5);
  static const Color textMuted = Color(0xFF88889C);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: darkBackground,
        surface: darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onBackground: textLight,
        onSurface: textLight,
        error: Color(0xFFFF4D4D),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.04), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: textLight),
        titleTextStyle: TextStyle(
          color: textLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: textLight, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.5),
        headlineMedium: TextStyle(color: textLight, fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: textLight, fontSize: 20, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: textLight, fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textLight, fontSize: 16),
        bodyMedium: TextStyle(color: textMuted, fontSize: 14),
        labelLarge: TextStyle(color: textLight, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        hintStyle: const TextStyle(color: textMuted, fontSize: 14),
        prefixIconColor: textMuted,
        suffixIconColor: textMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.04), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
