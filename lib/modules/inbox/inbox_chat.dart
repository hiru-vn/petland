import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/inbox/inbox_bloc.dart';
import 'package:petland/share/import.dart';
import 'package:dash_chat/dash_chat.dart';

class InboxChat extends StatefulWidget {
  final String groupId;
  InboxChat(this.groupId);
  static Future navigate(String groupId) {
    return navigatorKey.currentState.push(pageBuilder(InboxChat(groupId)));
  }

  @override
  _InboxChatState createState() => _InboxChatState();
}

class _InboxChatState extends State<InboxChat> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  final ChatUser user = ChatUser(
    name: 'Huy',
    uid: 'Huy',
  );
  final ChatUser userOther = ChatUser(
    name: 'Anh',
    uid: 'Anh',
  );
  File _file;
  InboxBloc _inboxBloc;
  AuthBloc _authBloc;

  List<ChatMessage> messages = List<ChatMessage>();

  var i = 0;

  @override
  void didChangeDependencies() {
    _inboxBloc = Provider.of<InboxBloc>(context);
    _authBloc = Provider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> onSend(ChatMessage message) async {
    String text = message.text;

    _updateGroupPageText(
        widget.groupId, _authBloc.userModel.name, text, message.createdAt);
    if (text.length > 0) {
      _file = null;
      await _inboxBloc.addMessage(
          widget.groupId,
          text,
          message.createdAt,
          _authBloc.userModel.uid,
          _authBloc.userModel.name,
          _authBloc.userModel.avatar);
    }
    await Future.delayed(Duration(milliseconds: 100), () {
      _chatViewKey.currentState.scrollController
        ..animateTo(
          _chatViewKey.currentState.scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
    });
  }

  _updateGroupPageText(
      String groupid, String lastUser, String lastMessage, DateTime time) {
    if (lastMessage.length > 20) {
      lastMessage = lastMessage.substring(0, 20) + "...";
    }

    _inboxBloc.updateGroupOnMessage(groupid, lastUser, time, lastMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Lady Gaga'),
      body: DashChat(
        key: _chatViewKey,
        inverted: false,
        onSend: onSend,
        sendOnEnter: true,
        textInputAction: TextInputAction.send,
        user: user,
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
        onQuickReply: (Reply reply) {
          setState(() {
            messages.add(ChatMessage(
                text: reply.value, createdAt: DateTime.now(), user: user));

            messages = [...messages];
          });

          Timer(Duration(milliseconds: 300), () {
            _chatViewKey.currentState.scrollController
              ..animateTo(
                _chatViewKey
                    .currentState.scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
          });
        },
        onLoadEarlier: () {
          print("laoding...");
        },
        shouldShowLoadEarlier: false,
        showTraillingBeforeSend: true,
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
}
