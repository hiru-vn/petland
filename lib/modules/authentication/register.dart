import 'package:flutter/material.dart';
import 'package:petland/navigator.dart';
import 'package:petland/share/widgets/appbar.dart';
import 'package:petland/share/widgets/back_btn.dart';
import 'package:petland/share/widgets/expand_btn.dart';
import 'package:petland/share/widgets/input.dart';
import 'package:petland/share/widgets/page_builder.dart';
import 'package:petland/share/widgets/spacing_box.dart';
import 'package:petland/share/import.dart';

class RegisterPage extends StatelessWidget {
  static navigate(BuildContext context) {
    navigatorKey.currentState.push(pageBuilder(RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        leading: BackBtn(),
        bgColor: ptDartColor(context),
      ),
      backgroundColor: HexColor('#21323A'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            height: deviceHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  'Create your account',
                  style: ptHeadLineSmall().copyWith(color: Colors.white),
                ),
                SpacingBox(h: 5),
                InputWithLeading(
                  icon: Icons.pets,
                  hint: 'User name',
                  textStyle: ptTitle().copyWith(color: Colors.white70),
                ),
                SpacingBox(h: 5),
                InputWithLeading(
                  icon: Icons.mail,
                  hint: 'Email',
                  textStyle: ptTitle().copyWith(color: Colors.white70),
                ),
                SpacingBox(h: 5),
                InputWithLeading(
                  icon: Icons.lock,
                  hint: 'Password',
                  textStyle: ptTitle().copyWith(color: Colors.white70),
                ),
                SpacingBox(h: 5),
                InputWithLeading(
                  icon: Icons.lock,
                  hint: 'Password Confirm',
                  textStyle: ptTitle().copyWith(color: Colors.white70),
                ),
                SpacingBox(h: 8),
                ExpandBtn(text: 'Let\'s get started', onPress: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
