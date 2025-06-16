import 'package:flutter/material.dart';

class MyTheme {
  static final mytheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Color(0xfffaf7ff),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
