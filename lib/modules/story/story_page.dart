import 'package:flutter/material.dart';
import 'package:petland/modules/story/story_appbar.dart';

class StoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StoryAppbar(),
      body: SafeArea(
        child: Stack(
          children: [],
        ),
      ),
    );
  }
}
