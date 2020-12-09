import 'package:flutter/material.dart';
import 'package:petland/share/widgets/spacing_box.dart';
import 'package:petland/themes/color.dart';
import 'package:petland/themes/font.dart';

class InputWithLeading extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextStyle textStyle;
  final Color iconColor;
  final Color iconBgColor;

  const InputWithLeading(
      {Key key, @required this.hint, @required this.icon, this.textStyle, this.iconBgColor, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 48,
          decoration: BoxDecoration(
              color: iconBgColor??HexColor('#625b39'),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Icon(
              icon,
              color: iconColor?? HexColor('#ffc644'),
            ),
          ),
        ),
        SpacingBox(w: 4),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextFormField(
              style: textStyle ?? ptBody(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                hintText: hint,
                hintStyle: textStyle ?? ptBody(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
