import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900]!,
    foregroundColor: Colors.grey[300]!,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.grey[300]!,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.blue[200]!,
    secondary: Colors.grey[700]!,
    background: Colors.grey[900]!,
    error: const Color.fromARGB(255, 134, 9, 9),
    tertiary: Colors.grey[600]!,
  ),
);
