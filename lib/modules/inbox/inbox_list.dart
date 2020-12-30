import 'package:petland/modules/inbox/inbox_chat.dart';
import 'package:petland/share/import.dart';

class InboxList extends StatefulWidget {
  static Future navigate() {
    return navigatorKey.currentState.push(pageBuilder(InboxList()));
  }

  @override
  _InboxListState createState() => _InboxListState();
}

class _InboxListState extends State<InboxList>
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
        "text": 'Have you tried this?',
        "isRead": false,
      },
      {
        "avatar": 'assets/image/cat2.png',
        "title": 'John Dever',
        "text": 'Hello there',
        "isRead": true,
      },
      {
        "avatar": 'assets/image/cat3.png',
        "title": 'Thomson Aura',
        "text": 'Thank you for the tools',
        "isRead": true,
      }
    ];
    return Scaffold(
      appBar: MyAppBar(
        automaticallyImplyLeading: true,
        title: 'Messages',
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 21,
              ),
              onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            SupportChat.navigate();
          },
          tileColor:
              list[index]['isRead'] ? Colors.white : ptBackgroundColor(context),
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/image/cat1.png'),
          ),
          title: Text(
            'Laura Reference',
            style: ptTitle().copyWith(
                color: list[index]['isRead'] ? Colors.black54 : Colors.black87,
                fontSize: list[index]['isRead'] ? 15 : 16),
          ),
          subtitle: Text(
            'Have you tried this?',
            style: ptTiny().copyWith(
                fontWeight:
                    list[index]['isRead'] ? FontWeight.w400 : FontWeight.w500,
                color: list[index]['isRead'] ? Colors.black54 : Colors.black87,
                fontSize: list[index]['isRead'] ? 12 : 13),
          ),
          trailing: Column(
            children: [
              SizedBox(height: 12),
              Text(
                '12:03 AM',
                style: ptSmall().copyWith(
                    fontWeight: list[index]['isRead']
                        ? FontWeight.w500
                        : FontWeight.w600,
                    color:
                        list[index]['isRead'] ? Colors.black54 : Colors.black87,
                    fontSize: list[index]['isRead'] ? 12 : 13),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
      ),
    );
  }
}
