import 'package:flutter/material.dart';
import 'package:petland/modules/story/post_story.dart';
import 'package:petland/share/import.dart';
import 'package:petland/themes/color.dart';

enum StoryOptions { Following, Popular }

class StoryAppbar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight - 20);
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
      backgroundColor: ptDarkColor(context) ?? Colors.transparent,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: widget.leading ??
          SizedBox(
            width: 10,
          ),
      title: Padding(padding: EdgeInsets.only(top: 6),
              child: Row(
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
      ),
      actions: [
        IconButton(
          onPressed: () {
            PostStory.navigate();
          },
          icon: Icon(
            Icons.add_circle,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
