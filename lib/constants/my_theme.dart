import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final mytheme = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: GoogleFonts.blinkerTextTheme(
      
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor:Colors.blue,
      foregroundColor: Color(0xfffaf7ff) ,
      shape: CircleBorder() 
    ),
    
    appBarTheme: AppBarTheme(
      color: Colors.blue.shade700,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        wordSpacing: 2.0,
        letterSpacing: 1.5
      )
      
      
    ),
    scaffoldBackgroundColor: Colors.white,
  
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
