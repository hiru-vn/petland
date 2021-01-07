import 'package:petland/modules/inbox/inbox_list.dart';
import 'package:petland/share/import.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Notification',
        actions: [
          Center(child: AnimatedSearchBar()),
          IconButton(
              icon: Icon(
                Icons.message,
                size: 21,
              ),
              onPressed: () {
                InboxList.navigate();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  indicatorColor: ptPrimaryColor(context),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black87,
                  unselectedLabelStyle:
                      TextStyle(fontSize: 16, color: Colors.black54),
                  labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  tabs: [
                    SizedBox(
                      width: deviceWidth(context) / 2 - 50,
                      child: Tab(
                        text: 'All',
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) / 2 - 50,
                      child: Tab(text: 'Unread'),
                    ),
                  ]),
            ),
            ListTile(
              tileColor: ptBackgroundColor(context),
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/image/cat1.png'),
              ),
              title: Text(
                'Cuti pit và 3 người khác theo dõi bạn',
                style: ptBody(),
              ),
              subtitle: Text(
                '1 tháng trước',
                style: ptTiny(),
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              tileColor: ptBackgroundColor(context),
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/image/cat2.png'),
              ),
              title: Text(
                'Cuti pit và 3 người khác theo dõi bạn',
                style: ptBody(),
              ),
              subtitle: Text(
                '1 tháng trước',
                style: ptTiny(),
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              tileColor: ptBackgroundColor(context),
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/image/cat3.png'),
              ),
              title: Text(
                'Cuti pit và 3 người khác theo dõi bạn',
                style: ptBody(),
              ),
              subtitle: Text(
                '1 tháng trước',
                style: ptTiny(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
