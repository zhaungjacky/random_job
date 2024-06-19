import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.black87,
    tertiary: Colors.black45,
    inversePrimary: Colors.white70,
    surface: Colors.white,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.josefinSansTextTheme(),
);
