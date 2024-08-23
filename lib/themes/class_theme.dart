import 'package:flutter/material.dart';


const Color bluishClr = Color(0xFF4e5ae8);
const Color pinkClr = Color(0xFFFF4667);
const Color yellowClr = Color(0xFFF4B746);
const Color white = Color(0xFFFFFFFF);
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const darkHeaderClr = Color(0xFF424242);



class Themes {
  static final light = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      primary: Color(0xff1067F5),
      secondary: Color(0xff1067F5),
      inversePrimary: Color(0xff1067F5),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF0F4F64), // Set the desired text color for all text
        fontFamily: 'Roboto', // Set the desired font family
      ),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade500,
      primary:  Colors.grey.shade700,
      secondary: const Color(0xff1067F5),
      inversePrimary:const  Color(0xff1067F5),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white, // Set the desired text color for all text
        fontFamily: 'Roboto', // Set the desired font family
      ),
    ),
  );
}
