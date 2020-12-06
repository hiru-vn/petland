import 'package:flutter/material.dart';
import 'package:petland/utils/responsive.dart';

class SpacingBox extends StatelessWidget {
  final double h;
  final double w;

  SpacingBox({this.h = 0, this.w = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * Responsive.heightMultiplier,
      width: w * Responsive.widthMultiplier,
    );
  }
}
