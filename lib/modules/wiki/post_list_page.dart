import 'package:petland/modules/wiki/post_detail_page.dart';
import 'package:petland/share/functions/share_to.dart';
import 'package:petland/share/import.dart';

class PostListPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(PostListPage()));
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "title": "Các bệnh tiêu hóa hay gặp ở mèo",
        "image": "assets/image/cat_cover.webp",
        "content":
            "Sau đây là những bệnh tiêu hóa khá phổ biến ở mèo với các triệu chứng có vẻ thường gặp, khi thấy mèo có bất kì biểu hiện nào hãy đi khám bác sĩ để được chuẩn đoán và chữa trị đúng cách nhé.",
        "date": DateTime.now(),
        "writer": 'Edison Mal',
        "avatar": 'assets/image/avatar.png',
        "seen": 1521,
        "like": 12,
      },
      {
        "title": "Các bệnh tiêu hóa hay gặp ở chó",
        "image": "assets/image/dog_cover.jpg",
        "content":
            "Sau đây là những bệnh tiêu hóa khá phổ biến ở chó với các triệu chứng có vẻ thường gặp, khi thấy chó của bạn có bất kì biểu hiện nào hãy đi khám bác sĩ để được chuẩn đoán và chữa trị đúng cách nhé.",
        "date": DateTime.now(),
        "writer": 'Adersion Alter',
        "avatar": 'assets/image/avatar.png',
        "seen": 212,
        "like": 12,
      },
    ];
    return Scaffold(
        backgroundColor: ptBackgroundColor(context),
        appBar: MyAppBar(
          title: 'Bệnh thường gặp',
          automaticallyImplyLeading: true,
          centerTitle: true,
          bgColor: Colors.white,
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 15),
          itemCount: list.length,
          itemBuilder: (context, index) => PostCard(
              content: list[index]['content'],
              image: list[index]["image"],
              title: list[index]["title"],
              date: list[index]["date"],
              avatar: list[index]["avatar"],
              writer: list[index]["writer"],
              seen: list[index]["seen"],
              like: list[index]['like']),
          separatorBuilder: (context, index) => SizedBox(
            height: 15,
          ),
        ));
  }
}

class PostCard extends StatefulWidget {
  final String image;
  final String title;
  final String content;
  final DateTime date;
  final String writer;
  final String avatar;
  final int seen;
  final int like;

  const PostCard(
      {Key key,
      this.image,
      this.title,
      this.content,
      this.date,
      this.writer,
      this.avatar,
      this.seen,
      this.like})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _like;
  bool _isLiked = false;

  @override
  void initState() {
    _like = widget.like;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          PostDetailPage.navigate();
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: SizedBox(
                  width: deviceWidth(context),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                child: Text(
                  widget.title,
                  maxLines: null,
                  style: ptBigTitle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 15),
                child: Text(
                  widget.content,
                  maxLines: null,
                  style: ptBody(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.heart,
                            color: _isLiked ? Colors.red : Colors.black54,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            _like.toString(),
                            style: ptTiny(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.black54,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.seen.toString(),
                      style: ptTiny(),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        shareTo(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.share,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Share',
                            style: ptTiny(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(12).copyWith(top: 8),
                child: Row(children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(widget.avatar),
                  ),
                  SizedBox(width: 7),
                  Text(widget.writer,
                      style: ptSmall().copyWith(fontWeight: FontWeight.w700)),
                  Spacer(),
                  Text(
                    Formart.formatToDate(widget.date),
                    style: ptSmall(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
