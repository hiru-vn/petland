import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/share/import.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popup_menu/popup_menu.dart';

import 'inbox_bloc.dart';
import 'inbox_model.dart';
import 'video_call_page.dart';

class InboxChat extends StatefulWidget {
  final FbInboxGroupModel group;
  final String title;

  InboxChat(this.group, this.title);
  static Future navigate(FbInboxGroupModel group, String title) {
    return navigatorKey.currentState.push(pageBuilder(InboxChat(group, title)));
  }

  @override
  _InboxChatState createState() => _InboxChatState();
}

class _InboxChatState extends State<InboxChat> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  final List<ChatUser> _users = [];
  final List<FbInboxUserModel> _fbUsers = [];

  File _file;
  InboxBloc _inboxBloc;
  AuthBloc _authBloc;
  ScrollController scrollController = ScrollController();
  bool shouldShowLoadEarlier = true;
  bool reachEndList = false;
  bool onLoadMore = false;
  Stream<QuerySnapshot> _incomingMessageStream;
  StreamSubscription _incomingMessageListener;
  GlobalKey<State<StatefulWidget>> moreBtnKey =
      GlobalKey<State<StatefulWidget>>();

  List<ChatMessage> messages = List<ChatMessage>();

  var i = 0;

  @override
  void didChangeDependencies() {
    if (_inboxBloc == null || _authBloc == null) {
      _inboxBloc = Provider.of<InboxBloc>(context);
      _authBloc = Provider.of<AuthBloc>(context);
      loadUsers().then((value) => initMenu());
      loadFirst20Message();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    for (final id in widget.group.users) {
      _users.add(ChatUser(uid: id, name: ''));
    }
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _incomingMessageListener?.cancel();
  }

  Future<void> loadUsers() async {
    final fbUsers = await _inboxBloc.getUsers(widget.group.users);
    _fbUsers.addAll(fbUsers);
    for (final fbUser in fbUsers) {
      final user = _users.firstWhere((user) => user.uid == fbUser.id);
      user.avatar = fbUser.image;
      user.name = fbUser.name;
    }
    setState(() {});
  }

  Future<void> loadFirst20Message() async {
    // get list first 20 message by group id
    final fbMessages = await _inboxBloc.get20Messages(widget.group.id);
    if (fbMessages.isEmpty) return;
    messages.addAll(fbMessages.map((element) {
      return ChatMessage(
          user: _users.firstWhere((user) => user.uid == element.uid),
          text: element.text,
          id: element.id,
          createdAt: DateTime.tryParse(element.date));
    }).toList());
    setState(() {});
    Future.delayed(Duration(milliseconds: 50), () => jumpToEnd());

    // init stream with last messageId
    _incomingMessageStream = await _inboxBloc.getStreamIncomingMessages(
        widget.group.id, fbMessages[fbMessages.length - 1].id);
    // add listener to cancel listener, or else will cause bug setState when dispose state
    _incomingMessageListener = _incomingMessageStream.listen(onIncomingMessage);
  }

  void onIncomingMessage(event) async {
    print('new message!!!');
    final newMessages = event as QuerySnapshot;
    final fbMessages = newMessages.docs
        .map((e) => FbInboxMessageModel.fromJson(e.data(), e.id))
        .toList();
    // do not add message come for this user
    fbMessages.removeWhere((message) => message.uid == _authBloc.userModel.id);
    if (fbMessages.isEmpty) return;
    // add incoming message to first
    messages.addAll(fbMessages.map((element) {
      return ChatMessage(
          user: _users.firstWhere((user) => user.uid == element.uid),
          text: element.text,
          id: element.id,
          createdAt: DateTime.tryParse(element.date));
    }).toList());

    // now update stream with new last message id
    _incomingMessageStream = await _inboxBloc.getStreamIncomingMessages(
        widget.group.id, fbMessages[fbMessages.length - 1].id);
    // refresh lisener to prevent bug
    _incomingMessageListener?.cancel();
    _incomingMessageListener = _incomingMessageStream.listen(onIncomingMessage);

    if (mounted) setState(() {});
    // new message! scroll to bottom to see them
    Future.delayed(Duration(milliseconds: 100), () {
      if (_chatViewKey.currentState.scrollController.position.pixels >
          _chatViewKey.currentState.scrollController.position.maxScrollExtent -
              200) scrollToEnd();
    });
  }

  Future<void> loadNext20Message() async {
    if (reachEndList) return; // none to fetch
    // get list first 20 message by group id
    setState(() {
      onLoadMore = true;
    });
    final fbMessages = await _inboxBloc.get20Messages(widget.group.id,
        lastMessageId: messages[0].id);
    setState(() {
      onLoadMore = false;
    });
    if (fbMessages.length < 20) {
      // if return messages is smaller than 20 then it must have get everything
      setState(() {
        reachEndList = true;
      });
      if (fbMessages.length == 0) return; //if zero do not insert or setState
    }
    messages.insertAll(
        0,
        fbMessages.map((element) {
          return ChatMessage(
              user: _users.firstWhere((user) => user.uid == element.uid),
              text: element.text,
              id: element.id,
              createdAt: DateTime.tryParse(element.date));
        }).toList());
    setState(() {});
  }

  Future<void> onSend(ChatMessage message) async {
    setState(() {
      messages.add(message);
    });
    scrollToEnd();

    String text = message.text;

    _updateGroupPageText(widget.group.id, _authBloc.userModel.name, text,
        message.createdAt, message.user.avatar);
    if (text.length > 0) {
      _file = null;
      await _inboxBloc.addMessage(
          widget.group.id,
          text,
          message.createdAt,
          _authBloc.userModel.id,
          _authBloc.userModel.name,
          _authBloc.userModel.avatar);
    }
  }

  _updateGroupPageText(String groupid, String lastUser, String lastMessage,
      DateTime time, String image) {
    if (lastMessage.length > 20) {
      lastMessage = lastMessage.substring(0, 20) + "...";
    }

    _inboxBloc.updateGroupOnMessage(
        groupid, lastUser, time, lastMessage, image);
  }

  void scrollToEnd() {
    _chatViewKey.currentState.scrollController
      ..animateTo(
        _chatViewKey.currentState.scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
  }

  void jumpToEnd() {
    _chatViewKey.currentState.scrollController
      ..jumpTo(
        _chatViewKey.currentState.scrollController.position.maxScrollExtent,
      );
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        automaticallyImplyLeading: true,
        bgColor: Colors.white,
        actions: [
          Center(
            child: AnimatedSearchBar(
              width: deviceWidth(context) / 2,
              height: 40,
            ),
          ),
          IconButton(
              key: moreBtnKey,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black.withOpacity(0.7),
              ),
              onPressed: () {
                menu.show(widgetKey: moreBtnKey);
              }),
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: DashChat(
        scrollController: scrollController,
        key: _chatViewKey,
        inverted: false,
        onSend: onSend,
        sendOnEnter: true,
        textInputAction: TextInputAction.send,
        user: _users.firstWhere((user) => user.uid == _authBloc.userModel.id),
        textCapitalization: TextCapitalization.sentences,
        messageTextBuilder: (text, [messages]) {
          return Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              text,
              style: ptBigBody(),
            ),
          );
        },
        messageTimeBuilder: (text, [messages]) {
          return Text(
            text,
            style: ptSmall(),
          );
        },
        inputToolbarPadding: EdgeInsets.all(4),
        inputDecoration: InputDecoration.collapsed(hintText: "Send message..."),
        dateFormat: DateFormat('yyyy-MMM-dd'),
        timeFormat: DateFormat('HH:mm'),
        messages: messages,
        showUserAvatar: false,
        showAvatarForEveryMessage: false,
        scrollToBottom: true,
        onPressAvatar: (ChatUser user) {
          print("OnPressAvatar: ${user.name}");
        },
        onLongPressAvatar: (ChatUser user) {
          print("OnLongPressAvatar: ${user.name}");
        },
        inputMaxLines: 5,
        messageContainerPadding: EdgeInsets.only(left: 10, right: 10),
        alwaysShowSend: true,
        inputTextStyle: TextStyle(fontSize: 16.0),
        inputContainerStyle: BoxDecoration(
          border: Border.all(width: 0.0),
          color: Colors.white,
        ),
        onQuickReply: (Reply reply) {},
        shouldShowLoadEarlier: true,
        showTraillingBeforeSend: true,
        showLoadEarlierWidget: () {
          if (!reachEndList)
            return LoadEarlierWidget(
              onLoadEarlier: () {
                print("loading...");
                loadNext20Message();
              },
              onLoad: onLoadMore,
            );
          else
            return SizedBox.shrink();
        },
        inputFooterBuilder: () => _file != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.file_present),
                          Text(
                            path.basename(_file.path),
                            style: ptBody().copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.file_present),
            onPressed: () async {
              imagePicker(context, (str) {}, (str) {});
            },
          )
        ],
      ),
    );
  }

  initMenu() {
    menu = PopupMenu(
        items: [
          MenuItem(
              title: 'Voice call',
              image: Icon(
                Icons.phone,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Video call',
              image: Icon(
                Icons.video_call,
                color: Colors.white,
              )),
        ],
        onClickMenu: (val) {
          if (val.menuTitle == 'Voice call') {}
          if (val.menuTitle == 'Video call') {
            VideoCallPage.navigate(widget.group.id, _fbUsers);
          }
        },
        stateChanged: (val) {},
        onDismiss: () {});
  }

  PopupMenu menu;
}

class LoadEarlierWidget extends StatelessWidget {
  const LoadEarlierWidget(
      {Key key, @required this.onLoadEarlier, @required this.onLoad})
      : super(key: key);

  final Function onLoadEarlier;
  final bool onLoad;

  @override
  Widget build(BuildContext context) {
    return onLoad
        ? SizedBox(
            width: 30,
            height: 30,
            child: Center(child: CircularProgressIndicator()),
          )
        : GestureDetector(
            onTap: () {
              if (onLoadEarlier != null) {
                onLoadEarlier();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1.0,
                      blurRadius: 5.0,
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 10),
                    )
                  ]),
              child: Text(
                "Load more",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          );
  }
}
