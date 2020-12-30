import 'package:petland/modules/inbox/inbox_chat.dart';
import 'package:petland/share/import.dart';

class CommentPage extends StatefulWidget {
  static Future navigate() {
    return navigatorKey.currentState.push(pageBuilder(CommentPage()));
  }

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "avatar": 'assets/image/cat1.png',
        "title": 'Laura Reference',
        "text":
            "Winter carnival offers New Year's Day fun; Nom Nom Vietnam - Episode 73: Grilled beef wrapped in lolot leaf Nom, Nom Vietnam",
        "date": '02/10/2012',
        "isLike": true,
        "likeCount": 9,
      },
      {
        "avatar": 'assets/image/cat2.png',
        "title": 'John Dever',
        "text": 'Hello there',
        "date": '30/10/2012',
        "isLike": true,
        "likeCount": 7,
      },
      {
        "avatar": 'assets/image/cat3.png',
        "title": 'Thomson Aura',
        "text": 'Thank you for the tools',
        "date": '18/09/2012',
        "isLike": false,
        "likeCount": 2,
      }
    ];
    return Scaffold(
      appBar: MyAppBar(
        title: 'Comments',
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.separated(
            itemCount: list.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                SupportChat.navigate();
              },
              tileColor: Colors.white,
              leading: Container(
                padding: EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.black45),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(list[index]['avatar']),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text(
                  list[index]['title'],
                  style:
                      ptTitle().copyWith(color: Colors.black87, fontSize: 15),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    list[index]['text'],
                    style: ptTiny().copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 13.5),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        list[index]['date'],
                        style: ptTiny(),
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Row(children: [
                          Icon(
                            MdiIcons.heart,
                            size: 18,
                            color: list[index]['isLike']
                                ? Colors.red
                                : Colors.grey[200],
                          ),
                          SizedBox(width: 2),
                          Text(
                            list[index]['likeCount'].toString(),
                            style: ptTiny(),
                          )
                        ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              height: 1,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: deviceWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: ptBackgroundColor(context),
              child: Center(
                child: TextField(
                  maxLines: null,
                  maxLength: 200,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.send),
                    contentPadding: EdgeInsets.all(10),
                    isDense: true,
                    hintText: 'Write a comment.',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
