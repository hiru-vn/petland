import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color ptPrimaryColor(BuildContext context) => Theme.of(context).primaryColor;
Color ptSecondaryColor(BuildContext context) => Theme.of(context).accentColor;
Color ptPrimaryColorLight(BuildContext context) =>
    Theme.of(context).primaryColorLight;
Color ptPrimaryColorDark(BuildContext context) =>
    Theme.of(context).primaryColorDark;
Color ptBackgroundColor(BuildContext context) =>
    Theme.of(context).backgroundColor;
Color ptAccentColor(BuildContext context) => HexColor('#ffe7e7');
Color ptLineColor(BuildContext context) => Colors.black.withOpacity(0.2);
Color ptGreyColor(BuildContext context) => HexColor('#d1d1d1');
Color ptDarkColor(BuildContext context) => HexColor('#21323A');

class HexColor extends Color {
  static const MethodChannel _channel = const MethodChannel('hexcolor');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color fromHex(String hexColor) {
    try {
      return Color(_getColorFromHex(hexColor));
    } catch (e) {
      return Colors.white;
    }
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
