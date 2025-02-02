import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: GoogleFonts.sunflowerTextTheme(
      ThemeData.light().textTheme,
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blue,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(165, 63, 81, 181),
    textTheme: GoogleFonts.sunflowerTextTheme(
      ThemeData.dark().textTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color.fromARGB(165, 63, 81, 181),
      secondary: const Color.fromARGB(165, 63, 81, 181),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(165, 63, 81, 181),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
