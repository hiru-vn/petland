import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle ptHeadLine() => TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    letterSpacing: 1.5);

TextStyle ptBigTitle() =>
    TextStyle(fontWeight: FontWeight.w400, fontSize: 17, letterSpacing: 0.5);

TextStyle ptTitle() =>
    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.3);

TextStyle ptButton() => GoogleFonts.rubik(
    letterSpacing: 0.2, fontSize: 14, fontWeight: FontWeight.w400);

TextStyle ptBody() => GoogleFonts.rubik(
    letterSpacing: 0.15, fontSize: 13.5, fontWeight: FontWeight.w400);

TextStyle ptSmall() => GoogleFonts.rubik(
    letterSpacing: 0.1, fontSize: 13, fontWeight: FontWeight.w400);

TextStyle ptTiny() => GoogleFonts.rubik(
    letterSpacing: 0.5, fontSize: 12, fontWeight: FontWeight.w400);
