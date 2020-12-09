import 'package:flutter/material.dart';
import 'package:petland/navigator.dart';
import 'package:petland/themes/color.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigatorKey.currentState.maybePop(),
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: HexColor('#286053'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_left,
                color: HexColor('#46d598'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
