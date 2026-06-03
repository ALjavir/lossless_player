import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fontstyle {
  static TextStyle appbarfont(double fontSize, Color color) {
    return GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }

  static TextStyle thambalfont(double fontSize, FontWeight fontWeight) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        // color: color,
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
