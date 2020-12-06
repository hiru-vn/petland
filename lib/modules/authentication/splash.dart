import 'package:flutter/material.dart';
import 'package:petland/utils/constants.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: AssetImage('assets/image/splash.png'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
