import 'package:flutter/material.dart';
import 'package:petland/modules/authentication/login.dart';
import 'package:petland/modules/authentication/register.dart';
import 'package:petland/navigator.dart';
import 'package:petland/share/widgets/expand_btn.dart';
import 'package:petland/share/widgets/page_builder.dart';
import 'package:petland/share/widgets/spacing_box.dart';
import 'package:petland/themes/color.dart';
import 'package:petland/themes/font.dart';

class WelcomePage extends StatelessWidget {
  static navigate(BuildContext context) {
    navigatorKey.currentState.push(pageBuilder(WelcomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#21323A'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacingBox(h: 8),
              Image.asset('assets/image/logo.png'),
              SpacingBox(h: 1.5),
              Text(
                'Wellcome!',
                style: ptHeadLine().copyWith(color: Colors.white),
              ),
              SpacingBox(h: 1),
              Text(
                'Sen ơi đăng nhập vào đây nhé',
                style: ptTitle().copyWith(color: Colors.white70),
              ),
              SpacingBox(h: 35),
              ExpandBtn(text: 'Đăng ký tài khoản', onPress: () {
                RegisterPage.navigate(context);
              }),
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'ALREADY HAVE AN ACCOUNT?  ',
                  style: TextStyle(color: Colors.white70),
                ),
                GestureDetector(
                  onTap: () => LoginPage.navigate(context),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
              SpacingBox(h: 5),
            ],
          ),
        ),
      ),
    );
  }
}
