import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle ptHeadLine() => TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 1.5);

TextStyle ptHeadLineSmall() => TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 1.3);

TextStyle ptBigTitle() =>
    TextStyle(fontWeight: FontWeight.w600, fontSize: 17, letterSpacing: 0.5);

TextStyle ptTitle() => TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: Colors.black87);

TextStyle ptButton() => GoogleFonts.nunito(
    letterSpacing: 0.2, fontSize: 17, fontWeight: FontWeight.w600);

TextStyle ptBigBody() =>
    GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle ptBody() =>
    GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400);

TextStyle ptSmall() =>
    GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w400);

TextStyle ptTiny() =>
    GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400);
