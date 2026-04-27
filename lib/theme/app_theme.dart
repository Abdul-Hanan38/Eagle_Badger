import 'package:eagle_badger/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color brandRed = Color(0xFFC6102E);
  static const Color darkBg = Color(0xFF251111);
  static const Color cardColor = Color(0xFF1A0F0F);
  static const Color greyText = Colors.grey;
  static const Color greyContainer = Color(0xFF1A222D);
  static const Color success = Colors.green;

  static ThemeData darkTheme(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width <= 400;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: darkBg,
        primary: brandRed,
        primaryContainer: const Color(0xFF381A1A),
        onPrimary: Color.fromARGB(255, 185, 157, 161),
        primaryFixed: greyText,
        onSecondaryContainer: greyContainer,
        onSecondaryFixed: const Color.fromARGB(255, 39, 28, 29),
        onSecondaryFixedVariant: Color.fromARGB(255, 66, 52, 54),
        surface: darkBg,
        secondary: const Color(0xFF2D2D2D),
        secondaryContainer: cardColor,
        onSurface: Colors.white,
        tertiary: Color.fromARGB(255, 38, 28, 28),
        tertiaryContainer: const Color.fromARGB(255, 39, 28, 29),
        tertiaryFixed: success,
        tertiaryFixedDim: Colors.white10,
      ),
      textTheme: GoogleFonts.publicSansTextTheme(
        ThemeData.dark().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: context.isSmall ? 26 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: context.isSmall ? 22 : 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontSize: context.isSmall ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: context.isSmall ? 14 : 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: context.isSmall ? 12 : 14,
            color: greyText,
          ),
          bodySmall: TextStyle(
            fontSize: context.isSmall ? 10 : 12,
            color: greyText,
          ),
          labelLarge: TextStyle(
            fontSize: context.isSmall ? 18 : 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            fontSize: context.isSmall ? 14 : 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
