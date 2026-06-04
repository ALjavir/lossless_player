import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fontstyle {
  static TextStyle appbarfont(double fontSize) {
    return GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        //color: color,
      ),
    );
  }

  static TextStyle navfont(double fontSize) {
    return GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal),
    );
  }

  static TextStyle artistN(
    double fontsize,
    FontWeight fontWeight,
    Color color,
  ) {
    return GoogleFonts.elmsSans(
      textStyle: TextStyle(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static TextStyle songN(double Fontsize, Color color, FontWeight fontWeight) {
    return GoogleFonts.sura(
      textStyle: TextStyle(
        fontSize: Fontsize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  static TextStyle AlbamN(double Fontsize, FontWeight FontWeight, Color color) {
    return GoogleFonts.robotoSlab(
      textStyle: TextStyle(
        fontSize: Fontsize,
        fontWeight: FontWeight,
        color: color,
      ),
    );
  }

  //Lora
}
