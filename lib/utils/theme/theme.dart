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
      secondary: Colors.blueAccent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    textTheme: GoogleFonts.sunflowerTextTheme(
      ThemeData.dark().textTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.indigo,
      secondary: Colors.indigo[700]!,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo[700]!,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
