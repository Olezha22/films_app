import 'package:flutter/material.dart';

final ThemeData filmAppTheme = ThemeData(
  primarySwatch: Colors.yellow,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF111111),
  appBarTheme: const AppBarTheme(
    elevation: 1,
    color: Color(0xFF111111),
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 22,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.yellow,
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF111111),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow),
    ),
  ),
);
