import 'package:flutter/material.dart';

PageRouteBuilder pageBuilder(
  Widget page,
) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: transitionUpBuilder);
}

Widget transitionUpBuilder(BuildContext context, Animation<double> start,
    Animation<double> end, Widget child) {
  var begin = Offset(0.0, 1.0);
  var end = Offset.zero;
  var curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: start.drive(tween),
    child: child,
  );
}

Widget transitionRightBuilder(BuildContext context, Animation<double> start,
    Animation<double> end, Widget child) {
  var begin = Offset(1.0, 0.0);
  var end = Offset.zero;
  var curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: start.drive(tween),
    child: child,
  );
}