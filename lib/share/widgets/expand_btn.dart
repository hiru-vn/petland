import 'package:flutter/material.dart';
import 'package:petland/themes/color.dart';
import 'package:petland/themes/font.dart';
import 'package:petland/utils/constants.dart';

class ExpandBtn extends StatelessWidget {
  final String text;
  final Function onPress;

  const ExpandBtn({Key key, @required this.text, @required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: ptPrimaryColor(context),
        onPressed: onPress,
        child: Text(
          text,
          style: ptButton().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class FacebookBtn extends StatelessWidget {
  final Function onPress;

  const FacebookBtn({Key key, @required this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: HexColor('#7583ca'),
        onPressed: onPress,
        child: Row(
          children: [
            SizedBox(
              width: deviceWidth(context) / 10,
              child: Center(
                child: Image.asset('assets/image/facebook.png'),
              ),
            ),
            SizedBox(width: deviceWidth(context) / 15),
            Expanded(
              child: Text(
                'Đăng nhập bằng Facebook',
                style: ptButton().copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleBtn extends StatelessWidget {
  final Function onPress;

  const GoogleBtn({Key key, @required this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white.withOpacity(0.98),
        onPressed: onPress,
        child: Row(
          children: [
            SizedBox(
              width: deviceWidth(context) / 10,
              child: Image.asset('assets/image/google.png'),
            ),
            SizedBox(width: deviceWidth(context) / 15),
            Expanded(
              child: Text(
                'Đăng nhập bằng Google',
                style: ptButton().copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
