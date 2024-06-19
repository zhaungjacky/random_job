import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    secondary: Colors.white70,
    tertiary: Colors.white60,
    inversePrimary: Colors.white10,
    surface: Colors.black,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.josefinSansTextTheme(),
);
