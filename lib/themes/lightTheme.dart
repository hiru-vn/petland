import 'package:flutter/material.dart';
import 'package:petland/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petland/themes/font.dart';

final lightTheme = ThemeData(
  primaryColor: HexColor('#48da9c'),
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
    bodyText2: ptBody(),
    bodyText1: ptSmall(),
    button: ptButton(),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
