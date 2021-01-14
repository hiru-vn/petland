import 'package:petland/modules/authentication/auth_bloc.dart';

import 'package:petland/share/import.dart';

import 'inbox_bloc.dart';
import 'inbox_chat.dart';
import 'inbox_model.dart';

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
  List<FbInboxGroupModel> groups;

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
    await _inboxBloc.createUser(_authBloc.userModel.id,
        _authBloc.userModel.name, _authBloc.userModel.avatar);
    final res = await _inboxBloc.getList20Inbox(_authBloc.userModel.id);
    setState(() {
      groups = res;
    });
  }

  reload() async {
    final res = await _inboxBloc.getList20Inbox(_authBloc.userModel.id);
    setState(() {
      groups = res;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: groups != null
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: groups.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  InboxChat.navigate(groups[index], groups[index].lastUser)
                      .then((value) => reload());
                },
                tileColor: groups[index].reader.contains(_authBloc.userModel.id)
                    ? Colors.white
                    : ptBackgroundColor(context),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(
                      groups[index].image ?? 'assets/image/avatar.png'),
                ),
                title: Text(
                  groups[index].lastUser,
                  style: ptTitle().copyWith(
                      color:
                          groups[index].reader.contains(_authBloc.userModel.id)
                              ? Colors.black54
                              : Colors.black87,
                      fontSize:
                          groups[index].reader.contains(_authBloc.userModel.id)
                              ? 15
                              : 16),
                ),
                subtitle: Text(
                  groups[index].lastMessage,
                  style: ptTiny().copyWith(
                      fontWeight:
                          groups[index].reader.contains(_authBloc.userModel.id)
                              ? FontWeight.w400
                              : FontWeight.w500,
                      color:
                          groups[index].reader.contains(_authBloc.userModel.id)
                              ? Colors.black54
                              : Colors.black87,
                      fontSize:
                          groups[index].reader.contains(_authBloc.userModel.id)
                              ? 12
                              : 13.5),
                ),
                trailing: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      Formart.timeByDay(DateTime.tryParse(groups[index].time)),
                      style: ptSmall().copyWith(
                          fontWeight: groups[index]
                                  .reader
                                  .contains(_authBloc.userModel.id)
                              ? FontWeight.w500
                              : FontWeight.w600,
                          color: groups[index]
                                  .reader
                                  .contains(_authBloc.userModel.id)
                              ? Colors.black54
                              : Colors.black87,
                          fontSize: groups[index]
                                  .reader
                                  .contains(_authBloc.userModel.id)
                              ? 12
                              : 13),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => Divider(
                height: 1,
              ),
            )
          : kLoadingSpinner,
    );
  }
}
