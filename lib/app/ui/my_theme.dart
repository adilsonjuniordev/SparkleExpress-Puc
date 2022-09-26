import 'package:flutter/material.dart';

class MyTheme {
  static Color primary = const Color(0xffF5CF16);
  static Color secondary = Colors.grey;
  static Color error = Colors.red;
  static final principal = ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xffF5CF16)),
    primaryColor: const Color(0xffF5CF16),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffF5CF16),
        elevation: 4,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xffF5CF16),
      ),
    ),
  );
}
