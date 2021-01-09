import 'package:petland/share/import.dart';

class PostDetailPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(PostDetailPage()));
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "title": "Các bệnh tiêu hóa hay gặp ở mèo",
        "image": "assets/image/cat_cover.webp",
        "content":
            "Sau đây là những bệnh tiêu hóa khá phổ biến ở mèo với các triệu chứng có vẻ thường gặp, khi thấy mèo có bất kì biểu hiện nào hãy đi khám bác sĩ để được chuẩn đoán và chữa trị đúng cách nhé."
      },
      {
        "title": "Các bệnh tiêu hóa hay gặp ở chó",
        "image": "assets/image/dog_cover.jpg",
        "content":
            "Sau đây là những bệnh tiêu hóa khá phổ biến ở chó với các triệu chứng có vẻ thường gặp, khi thấy chó của bạn có bất kì biểu hiện nào hãy đi khám bác sĩ để được chuẩn đoán và chữa trị đúng cách nhé."
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
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 15,
          ),
        ));
  }
}

class PostCard extends StatelessWidget {
  final String image;
  final String title;
  final String content;

  const PostCard({Key key, this.image, this.title, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {},
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
                    image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                child: Text(
                  title,
                  maxLines: null,
                  style: ptBigTitle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 15),
                child: Text(
                  content,
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
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.black54,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '212',
                      style: ptTiny(),
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
                    backgroundImage: AssetImage('assets/image/avatar.png'),
                  ),
                  SizedBox(width: 7),
                  Text('Adresion Alter',
                      style: ptSmall().copyWith(fontWeight: FontWeight.w700)),
                  Spacer(),
                  Text(
                    '14/5/2020',
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
