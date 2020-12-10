import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';
import 'package:petland/themes/color.dart';

enum StoryOptions { Following, Popular }

class StoryAppbar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final Widget leading;
  final Function(StoryOptions) optionChange;

  StoryAppbar({this.leading, this.optionChange});

  @override
  _StoryAppbarState createState() => _StoryAppbarState();
}

class _StoryAppbarState extends State<StoryAppbar> {
  StoryOptions options = StoryOptions.Popular;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ptDartColor(context) ?? Colors.transparent,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: widget.leading,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                options = StoryOptions.Following;
              });
              widget.optionChange(StoryOptions.Following);
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Following',
                style: ptTitle().copyWith(
                    color: options == StoryOptions.Following
                        ? Colors.white
                        : Colors.white60),
              ),
            ),
          ),
          Container(
            width: 2,
            height: 15,
            color: Colors.white60,
            margin: EdgeInsets.symmetric(horizontal: 3),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                options = StoryOptions.Popular;
              });
              widget.optionChange(StoryOptions.Popular);
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Popular',
                style: ptTitle().copyWith(
                    color: options == StoryOptions.Popular
                        ? Colors.white
                        : Colors.white60),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/image/chat.png'),
        ),
      ],
    );
  }
}
