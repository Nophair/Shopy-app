import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    titleSpacing: 20.0,
    backgroundColor: HexColor('090909'),
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    backgroundColor: HexColor('090909'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  scaffoldBackgroundColor: HexColor('090909'),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
  fontFamily: 'NoyhR',
);
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[300],
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.grey[300],
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 50.0,
    backgroundColor: Color(0xFFE0E0E0),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.black,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      color: Colors.grey,
    ),
    headlineLarge: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'NoyhR',
  useMaterial3: true,
  colorSchemeSeed: Colors.blue,
);
