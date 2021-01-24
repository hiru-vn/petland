import 'package:flutter/material.dart';
import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/modules/story/story_appbar.dart';
import 'package:petland/modules/story/story_image_widget.dart';
import 'package:petland/share/import.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  PostBloc _postBloc;
  PageController _pageController = PageController();
  int _currentPage = 0;
  int _postCounter = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.toInt();
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_postBloc == null) {
      _postBloc = Provider.of<PostBloc>(context);
      _postBloc.getListPost();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  children: _postBloc.posts
                      .map((e) => StoryImageWidget(post: e))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}
