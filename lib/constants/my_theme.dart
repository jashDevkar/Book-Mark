import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final mytheme = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: GoogleFonts.robotoTextTheme(
      
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor:Color(0xff0E1C36),
      foregroundColor: Color(0xfffaf7ff) ,
      shape: CircleBorder() 
    ),
    
    appBarTheme: AppBarTheme(
      color: Color(0xff0E1C36),
      foregroundColor: Color(0xfffaf7ff),
      
      
      
    ),
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
