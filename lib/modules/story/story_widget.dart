import 'package:petland/model/post.dart';
import 'package:petland/share/import.dart';

class StoryWidget extends StatelessWidget {
  final Post post;

  const StoryWidget({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ptDarkColor(context),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Image.asset('assets/image/avatar.png'),
                    SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.ownerName,
                            style: ptTitle().copyWith(color: Colors.white),
                          ),
                          Text(
                            '3 giờ trước',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ]),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  post.content,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SpacingBox(h: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(post.images[0]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                child: Row(children: [
                  Image.asset(post.images[1]),
                  SizedBox(width: 8),
                  Image.asset(post.images[2]),
                ]),
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          bottom: 100,
          child: Column(
            children: [
              Text(
                '212',
                style: ptTiny().copyWith(color: Colors.white),
              ),
              Icon(
                MdiIcons.heart,
                color: Colors.white,
                size: 29,
              ),
              SizedBox(height: 10),
              Text(
                '32',
                style: ptTiny().copyWith(color: Colors.white),
              ),
              Icon(
                MdiIcons.comment,
                color: Colors.white,
                size: 27,
              ),
              SizedBox(height: 20),
              Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 29,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
