import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[900]!,
    foregroundColor: Colors.grey[300]!,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.grey[300]!,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.blue[900]!,
    secondary: Colors.grey[800]!,
    background: Colors.grey[300]!,
    error: const Color.fromARGB(255, 134, 9, 9),
    tertiary: Colors.grey[900]!,
  ),
);
