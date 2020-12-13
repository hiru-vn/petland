import 'package:flutter/material.dart';
import 'package:petland/model/post.dart';
import 'package:petland/modules/story/story_appbar.dart';
import 'package:petland/modules/story/story_widget.dart';
import 'package:petland/share/import.dart';

class StoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StoryAppbar(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  children: postData.map((e) => StoryWidget(
                    post:e
                  )).toList(),
                )),
          ],
        ),
      ),
    );
  }
}
