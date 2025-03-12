import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF121212); // Fond sombre MMORPG
  static const Color gold = Color(0xFFC9A758); // Doré noble, moins flashy
  static const Color parchment = Color(0xFFE5D6B3); // Blanc cassé parchemin
  static const Color blueGlow = Color(0xFF7FAFFF); // Bleu magique
  static const Color redAccent = Color(0xFFB03030); // Rouge guerrier
  static const Color panelBg = Color(0xFF2A2A2A); // Fond panneau métal

  static ThemeData theme = ThemeData(
    fontFamily: 'Morpheus',
    scaffoldBackgroundColor: darkBg,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: parchment), // Texte immersif
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF202020),
      foregroundColor: parchment,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: gold,
        fontFamily: 'Morpheus',
      ),
    ),
  );
}
