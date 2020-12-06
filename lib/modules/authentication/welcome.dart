import 'package:flutter/material.dart';
import 'package:petland/share/widgets/spacing_box.dart';
import 'package:petland/themes/color.dart';
import 'package:petland/themes/font.dart';

class WelcomePage extends StatelessWidget {
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
            ],
          ),
        ),
      ),
    );
  }
}
