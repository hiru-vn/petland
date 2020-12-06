import 'package:flutter/material.dart';
import 'package:petland/main.dart';
import 'package:petland/modules/authentication/welcome.dart';
import 'package:petland/share/widgets/page_builder.dart';
import 'package:petland/utils/constants.dart';

class SplashPage extends StatelessWidget {
  static navigate(BuildContext context, Widget page) {
    navigatorKey.currentState.pushReplacement(pageBuilder(page));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      () => navigate(context, WelcomePage()),
    );
    return Scaffold(
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: splash,
      ),
    );
  }
}
