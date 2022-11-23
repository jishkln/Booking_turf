import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

class TurffTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.robotoSlab(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline1: GoogleFonts.robotoSlab(
      fontSize: 38,
      color: (Colors.black),
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.robotoSlab(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.robotoSlab(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: subTextColor,
    ),
    headline4: GoogleFonts.robotoSlab(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: subTextColor,
    ),
    headline5:   GoogleFonts.robotoSlab(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: black1Color,
    ),
    headline6: GoogleFonts.robotoSlab(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.robotoSlab(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: white1Color,
    ),
    headline1: GoogleFonts.robotoSlab(
      fontSize: 38.0,
      fontWeight: FontWeight.bold,
      color:white1Color,
    ),
    headline2: GoogleFonts.robotoSlab(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color:white1Color,
    ),
    headline3: GoogleFonts.robotoSlab(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: subTextColor,
    ),
    headline5:   GoogleFonts.robotoSlab(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: white1Color,
    ),
    headline6: GoogleFonts.robotoSlab(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color:white1Color,
        decorationStyle: TextDecorationStyle.dotted),
  );
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
      ),
      appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black, backgroundColor: backGrountColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backGrountColor),
          foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
