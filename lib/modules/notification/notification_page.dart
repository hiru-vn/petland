import 'package:petland/modules/inbox/inbox_list.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/empty_widget.dart';

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
      body: Column(
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
                      text: 'Bài viết',
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 2 - 50,
                    child: Tab(text: 'Người theo dõi'),
                  ),
                ]),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              NotificationTab(),
              EmptyWidget(
                assetImg: 'assets/image/no_user.png',
                title: 'Bạn chưa có người theo dõi nào',
                content: 'Đăng bài và tương tác nhiều để boss của bạn được nhiều người chú ý.',
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: ptBackgroundColor(context),
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/image/logo.png'),
          ),
          title: Text(
            '1 người đã thích bài đăng của bạn',
            style: ptBody(),
          ),
          subtitle: Text(
            'Vừa xong',
            style: ptTiny(),
          ),
        ),
        Divider(height: 1,),
        ListTile(
          tileColor: ptBackgroundColor(context),
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/image/logo.png'),
          ),
          title: Text(
            'Comment mới từ bài đăng:\n"hihi"',
            style: ptBody(),
          ),
          subtitle: Text(
            'Vừa xong',
            style: ptTiny(),
          ),
        ),
      ],
    );
  }
}

class FollowerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
