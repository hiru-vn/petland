import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/model/comment.dart';
import 'package:petland/model/post.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/share/import.dart';

class CommentPage extends StatefulWidget {
  final PostModel post;

  const CommentPage({Key key, this.post}) : super(key: key);
  static Future navigate(PostModel post) {
    return navigatorKey.currentState.push(pageBuilder(CommentPage(post: post)));
  }

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  PostBloc _postBloc;
  List<CommentModel> comments;
  TextEditingController _commentC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_postBloc == null) {
      _postBloc = Provider.of<PostBloc>(context);
      _postBloc.getListPostComment(widget.post.id).then((res) => {
            if (res.isSuccess)
              {
                setState(() {
                  comments = res.data;
                })
              }
            else
              {showToast('Có lỗi khi lấy dữ liệu', context)}
          });
    }
    super.didChangeDependencies();
  }

  _comment(String text) async {
    if (comments == null) await Future.delayed(Duration(seconds: 1));
    _commentC.clear();
    comments.insert(0, CommentModel(
        content: text,
        like: 0,
        user: AuthBloc.instance.userModel,
        updatedAt: DateTime.now().toIso8601String()));
    FocusScope.of(context).unfocus();
    final res = await _postBloc.createComment(widget.post.id, text);
    if (!res.isSuccess) {
      showToast(res.errMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: MyAppBar(
            title: 'Comments',
            actions: [
              Center(
                child: Text(
                  'Mới nhất',
                  style: ptSmall(),
                ),
              ),
              Center(
                child: Icon(Icons.arrow_drop_down),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (comments != null)
                ListView.separated(
                  itemCount: comments.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      // InboxChat.navigate();
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
                        backgroundImage: comments[index].user.avatar != null
                            ? NetworkImage(comments[index].user.avatar)
                            : AssetImage('assets/image/avatar.png'),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Text(
                        comments[index].user.name ?? '',
                        style: ptTitle()
                            .copyWith(color: Colors.black87, fontSize: 15),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          comments[index].content ?? '',
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
                              Formart.formatToDate(
                                  DateTime.tryParse(comments[index].updatedAt)),
                              style: ptTiny(),
                            ),
                            Spacer(),
                            GestureDetector(
                              child: Row(children: [
                                Icon(
                                  MdiIcons.heart,
                                  size: 18,
                                  color: comments[index].isLike
                                      ? Colors.red
                                      : Colors.grey[200],
                                ),
                                SizedBox(width: 2),
                                Text(
                                  comments[index].like.toString(),
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color: ptBackgroundColor(context),
                  child: Center(
                    child: TextField(
                      onSubmitted: _comment,
                      maxLines: null,
                      controller: _commentC,
                      maxLength: 200,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _comment(_commentC.text);
                            },
                            child: Icon(Icons.send)),
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
        ),
        if (comments == null) kLoadingSpinner
      ],
    );
  }
}
