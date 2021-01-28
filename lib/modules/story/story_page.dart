import 'package:flutter/material.dart';
import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/modules/story/story_appbar.dart';
import 'package:petland/modules/story/story_widget.dart';
import 'package:petland/share/import.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  PostBloc _postBloc;
  PageController _pageController = PageController();
  PageController _tabController = PageController();
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
      backgroundColor: ptDarkColor(context),
      appBar: StoryAppbar(
        optionChange: (option) {
          if (option == StoryOptions.Popular)
            _tabController.animateToPage(1,
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate);
          if (option == StoryOptions.Following)
            _tabController.animateToPage(0,
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate);
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: PageView(
                    controller: _tabController,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      PageView(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        children: _postBloc.posts
                            .map((e) => StoryWidget(post: e))
                            .toList(),
                      ),
                      PageView(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        children: _postBloc.posts
                            .map((e) => StoryWidget(post: e))
                            .toList(),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
