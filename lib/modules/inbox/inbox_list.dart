import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/inbox/inbox_bloc.dart';
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
  InboxBloc _inboxBloc;
  AuthBloc _authBloc;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_inboxBloc == null || _authBloc == null) {
      _inboxBloc = Provider.of<InboxBloc>(context);
      _authBloc = Provider.of<AuthBloc>(context);
      init();
    }
    super.didChangeDependencies();
  }

  init() async {
    _inboxBloc.createUser(_authBloc.userModel.id, _authBloc.userModel.name,
        _authBloc.userModel.avatar);
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "avatar": 'assets/image/cat1.png',
        "title": 'Laura Reference',
        "text": 'Have you tried this?',
        "isRead": false,
        "date": '12:00 AM'
      },
      {
        "avatar": 'assets/image/cat2.png',
        "title": 'John Dever',
        "text": 'Hello there',
        "isRead": true,
        "date": '12:11 PM'
      },
      {
        "avatar": 'assets/image/cat3.png',
        "title": 'Thomson Aura',
        "text": 'Thank you for the tools',
        "isRead": true,
        "date": '3:00 AM'
      }
    ];
    return Scaffold(
      appBar: MyAppBar(
        automaticallyImplyLeading: true,
        title: 'Messages',
        actions: [
          Center(
            child: AnimatedSearchBar(
              width: deviceWidth(context) / 2,
              height: 40,
            ),
          ),
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            InboxChat.navigate('1');
          },
          tileColor:
              list[index]['isRead'] ? Colors.white : ptBackgroundColor(context),
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(list[index]['avatar']),
          ),
          title: Text(
            list[index]['title'],
            style: ptTitle().copyWith(
                color: list[index]['isRead'] ? Colors.black54 : Colors.black87,
                fontSize: list[index]['isRead'] ? 15 : 16),
          ),
          subtitle: Text(
            list[index]['text'],
            style: ptTiny().copyWith(
                fontWeight:
                    list[index]['isRead'] ? FontWeight.w400 : FontWeight.w500,
                color: list[index]['isRead'] ? Colors.black54 : Colors.black87,
                fontSize: list[index]['isRead'] ? 12 : 13.5),
          ),
          trailing: Column(
            children: [
              SizedBox(height: 12),
              Text(
                list[index]['date'],
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
