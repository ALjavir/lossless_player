import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fontstyle {
  static TextStyle appbarfont(double fontSize, Color color) {
    return GoogleFonts.cormorant(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }

  static TextStyle thambalfont(double fontSize, Color color) {
    return GoogleFonts.aboreto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static TextStyle artistN(double fontsize) {
    return GoogleFonts.cinzel(textStyle: TextStyle(fontSize: fontsize));
  }

  static TextStyle songN(double Fontsize, Color color) {
    return GoogleFonts.jost(
      textStyle: TextStyle(fontSize: Fontsize, color: color),
    );
  }

  static TextStyle AlbamN(double Fontsize, FontWeight FontWeight) {
    return GoogleFonts.thasadith(
      textStyle: TextStyle(fontSize: Fontsize, fontWeight: FontWeight),
    );
  }

  //Lora
}

class X {
  bool expend = false;
  void printex() {
    print("From X $expend");
  }
}
