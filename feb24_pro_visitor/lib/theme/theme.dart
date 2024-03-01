import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData customTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.purple,
    backgroundColor: const Color(0xFF1D1E22),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.senTextTheme().apply(
    // Set the font family for all text styles
    fontFamily: 'Avenir',
    displayColor: const Color(0xFFFAF9F6),
  ),
);
