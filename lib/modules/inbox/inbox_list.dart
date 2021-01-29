import 'package:flutter/material.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/navigator.dart';
import 'package:provider/provider.dart';

import 'import/animated_search_bar.dart';
import 'import/app_bar.dart';
import 'import/color.dart';
import 'import/font.dart';
import 'import/formart.dart';
import 'import/page_builder.dart';
import 'import/spin_loader.dart';
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
    final res = await _inboxBloc.getList20InboxGroup(_authBloc.userModel.id);
    setState(() {
      _inboxBloc.groupInboxList = res;
    });
  }

  reload() async {
    final res = await _inboxBloc.getList20InboxGroup(_authBloc.userModel.id);
    setState(() {
      _inboxBloc.groupInboxList = res;
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
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
            ),
          ),
        ],
      ),
      body: _inboxBloc.groupInboxList != null
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: _inboxBloc.groupInboxList.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  InboxChat.navigate(_inboxBloc.groupInboxList[index], _inboxBloc.groupInboxList[index].lastUser)
                      .then((value) => reload());
                },
                tileColor: _inboxBloc.groupInboxList[index].reader.contains(_authBloc.userModel.id)
                    ? Colors.white
                    : ptBackgroundColor(context),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(
                      _inboxBloc.groupInboxList[index].image ?? 'assets/image/avatar.png'),
                ),
                title: Text(
                  _inboxBloc.groupInboxList[index].lastUser,
                  style: ptTitle().copyWith(
                      color:
                          _inboxBloc.groupInboxList[index].reader.contains(_authBloc.userModel.id)
                              ? Colors.black54
                              : Colors.black87,
                      fontSize:
                          _inboxBloc.groupInboxList[index].reader.contains(_authBloc.userModel.id)
                              ? 15
                              : 16),
                ),
                subtitle: Text(
                  _inboxBloc.groupInboxList[index].lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: ptTiny().copyWith(
                      fontWeight:
                          _inboxBloc.groupInboxList[index].reader.contains(_authBloc.userModel.id)
                              ? FontWeight.w400
                              : FontWeight.w500,
                      color:
                          _inboxBloc.groupInboxList[index].reader.contains(_authBloc.userModel.id)
                              ? Colors.black54
                              : Colors.black87,
                      fontSize:
                          _inboxBloc.groupInboxList[index].reader.contains(_authBloc.userModel.id)
                              ? 12
                              : 13.5),
                ),
                trailing: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      Formart.timeByDay(DateTime.tryParse(_inboxBloc.groupInboxList[index].time)),
                      style: ptSmall().copyWith(
                          fontWeight: _inboxBloc.groupInboxList[index]
                                  .reader
                                  .contains(_authBloc.userModel.id)
                              ? FontWeight.w500
                              : FontWeight.w600,
                          color: _inboxBloc.groupInboxList[index]
                                  .reader
                                  .contains(_authBloc.userModel.id)
                              ? Colors.black54
                              : Colors.black87,
                          fontSize: _inboxBloc.groupInboxList[index]
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
