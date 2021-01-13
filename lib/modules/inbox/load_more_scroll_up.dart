import 'package:flutter/material.dart';

class LoadMoreScrollUp extends StatelessWidget {
  final Widget list;
  final Function onLoadMore;
  final ScrollController scrollController;
  LoadMoreScrollUp({@required this.list, @required this.onLoadMore, @required this.scrollController});


  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              scrollController.position.extentBefore == 0) {
            onLoadMore();
          }
          return true;
        },
        child: list);
  }
}
