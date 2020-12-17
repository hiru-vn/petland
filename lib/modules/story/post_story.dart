import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class PostStory extends StatelessWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(PostStory()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Pets story', actions: [
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: 30,
            width: 70,
            child: Center(
              child: Text(
                'Post',
                style: ptBigTitle().copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'IMAGE AND VIDEOS',
            style: ptBigTitle().copyWith(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          Divider(height: 5),
          SizedBox(
            height: 110,
            child: ImageRowPicker(
              ['https://media2.giphy.com/media/H4DjXQXamtTiIuCcRU/giphy.gif'],
              onUpdateListImg: (listImg) {},
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: TextField(
                maxLength: 200,
                maxLines: null,
                style: ptBigBody().copyWith(color: Colors.black54),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a status',
                  hintStyle: ptTitle()
                      .copyWith(color: Colors.black38, letterSpacing: 1),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
