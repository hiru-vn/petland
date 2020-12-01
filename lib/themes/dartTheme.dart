import 'package:flutter/material.dart';
import 'package:petland/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: HexColor('#347af0'),
  accentColor: HexColor('#f1f8fe'),
  bottomAppBarColor: HexColor('#0E2036'),
  scaffoldBackgroundColor: HexColor('#ffffff'),
  cardTheme: CardTheme(
    color: HexColor('#FEFEFE'),
    shadowColor: HexColor('#FEFEFE'),
  ),
  primaryIconTheme: IconThemeData(
    color: HexColor('#444444'),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: HexColor('#2D9B7A'),
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: IconThemeData(size: 21, color: HexColor('#444444')),
  dividerColor: Colors.black.withOpacity(0.2),
  textTheme: TextTheme(
    bodyText2: GoogleFonts.rubik(
        letterSpacing: 0.15, fontSize: 13.5, fontWeight: FontWeight.w400),
    bodyText1: GoogleFonts.rubik(
        letterSpacing: 0.1, fontSize: 12.5, fontWeight: FontWeight.w400),
    button: GoogleFonts.rubik(
        letterSpacing: 0.2, fontSize: 14, fontWeight: FontWeight.w400),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
