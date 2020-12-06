import 'package:flutter/material.dart';
import 'package:petland/share/widgets/transitions.dart';

PageRouteBuilder pageBuilder(
  Widget page,
) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: transitionUpBuilder);
}
