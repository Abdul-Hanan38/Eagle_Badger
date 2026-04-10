import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color brandRed = Color(0xFFC6102E);
  static const Color darkBg = Color(0xFF251111);
  static const Color cardColor = Color(0xFF1A0F0F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color greyContainer = Color(0xFF1A222D);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: darkBg,
        primary: brandRed,
        primaryContainer: const Color(0xFF381A1A),
        onSecondaryContainer: greyContainer,
        surface: darkBg,
        secondary: const Color(0xFF2D2D2D),
        secondaryContainer: cardColor,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.publicSansTextTheme(
        ThemeData.dark().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: const TextStyle(fontSize: 14, color: greyText),
          bodySmall: const TextStyle(fontSize: 12, color: greyText),
          labelLarge: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
