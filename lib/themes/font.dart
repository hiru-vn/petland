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
    letterSpacing: 0.2, fontSize: 15.5, fontWeight: FontWeight.w500);

TextStyle ptBody() => GoogleFonts.nunito(
    letterSpacing: 0.15, fontSize: 14, fontWeight: FontWeight.w400);

TextStyle ptSmall() => GoogleFonts.nunito(
    letterSpacing: 0.1, fontSize: 13, fontWeight: FontWeight.w400);

TextStyle ptTiny() => GoogleFonts.nunito(
    letterSpacing: 0.05, fontSize: 12, fontWeight: FontWeight.w400);
