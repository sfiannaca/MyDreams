import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  // COLORS
  static const Color primaryColor = Color(0xFF9370DB);
  static const seedColor = Color(0xFF9370DB);
  static const unselectedLabelColor = seedColor;
  static const customBgCards = Color.fromARGB(100, 60, 60, 50);
  static const customLightCards = Color(0xFF423b52);
  static const customDarkCards = Color.fromARGB(100, 60, 60, 50);
  // TEXT STYLES
  static const labelsTextStyle = TextStyle(fontSize: 20);
  static const primaryTextStyle = TextStyle(fontSize: 18);
  static const secondaryTextStyle = TextStyle(fontSize: 16);
  // CUSTOM STYLES
  static const filtersTextStyle = [
    TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)
  ];

  static ThemeData themeData(String theme, BuildContext context) {
    final isDarkMode = theme == 'dark';
    final themeData = ThemeData(
        tabBarTheme: TabBarTheme(
            labelColor: isDarkMode
                ? Theme.of(context).tabBarTheme.labelColor
                : Colors.black),
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true);

    return themeData.copyWith(
      textTheme: GoogleFonts.latoTextTheme(themeData.textTheme),
    );
  }
}
