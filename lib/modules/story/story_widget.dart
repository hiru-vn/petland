import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/model/post.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/story/comment_page.dart';
import 'package:petland/share/functions/share_to.dart';
import 'package:petland/share/import.dart';
import 'package:popup_menu/popup_menu.dart';

class StoryWidget extends StatefulWidget {
  final PostModel post;

  const StoryWidget({Key key, this.post}) : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with AutomaticKeepAliveClientMixin {
  PostModel _post;
  PostBloc _postBloc;
  bool _isLike = false;
  GlobalKey<State<StatefulWidget>> moreBtnKey =
      GlobalKey<State<StatefulWidget>>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _post = widget.post;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_postBloc == null) {
      _postBloc = Provider.of<PostBloc>(context);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    menu.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PopupMenu.context = context;
    initMenu();
    return Stack(
      children: [
        Container(
          color: ptDarkColor(context),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: _post.user.avatar != null
                          ? NetworkImage(_post.user.avatar)
                          : AssetImage('assets/image/avatar.png'),
                    ),
                    SizedBox(width: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: _post.user?.name.toString(),
                                style: ptTitle().copyWith(color: Colors.white),
                              ),
                              if (_post.petTags.length > 0) ...[
                                TextSpan(
                                  text: ' with ',
                                  style: ptBody().copyWith(color: Colors.white),
                                ),
                                TextSpan(
                                  text: (PetBloc.instance.pets.length > 0)
                                      ? PetBloc.instance.pets
                                          .firstWhere((element) =>
                                              element.id ==
                                              _post.petTags[0]?.toString())
                                          .name
                                      : '',
                                  style:
                                      ptTitle().copyWith(color: Colors.white),
                                ),
                              ],
                            ]),
                          ),
                          Text(
                            '3 giờ trước',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ]),
                    Spacer(),
                    IconButton(
                        key: moreBtnKey,
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          menu.show(widgetKey: moreBtnKey);
                        }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.post.content,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SpacingBox(h: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.post.images.length > 0
                    ? Image.network(widget.post.images[0])
                    : Container(),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0).copyWith(top: 0),
              //   child: Row(children: [
              //     Image.network(widget.post.images[1]),
              //     SizedBox(width: 8),
              //     Image.network(widget.post.images[2]),
              //   ]),
              // ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          bottom: 100,
          child: Column(
            children: [
              Text(
                '2,1k',
                style: ptTiny().copyWith(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLike = !_isLike;
                    if (_isLike) {
                      _postBloc.likePost(_post.id);
                    } else {
                      _postBloc.unlikePost(_post.id);
                    }
                  });
                },
                child: Icon(
                  MdiIcons.heart,
                  color: _isLike ? Colors.red : Colors.white,
                  size: 29,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '32',
                style: ptTiny().copyWith(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      useRootNavigator: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return SizedBox(
                            height: deviceHeight(context) - kToolbarHeight - 10,
                            child: Column(
                              children: [
                                Container(
                                  height: 10,
                                  width: deviceWidth(context),
                                  color: Colors.white,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 4,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: CommentPage()),
                              ],
                            ));
                      });
                },
                child: Icon(
                  MdiIcons.comment,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  shareTo(context);
                },
                child: Icon(
                  MdiIcons.share,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  initMenu() {
    menu = PopupMenu(
        items: [
          if (_post.userId != AuthBloc.instance.userModel.id)
            MenuItem(
                title: 'Save post',
                image: Icon(
                  Icons.post_add,
                  color: Colors.white,
                )),
          if (_post.userId == AuthBloc.instance.userModel.id)
            MenuItem(
                title: 'Delete post',
                image: Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
          MenuItem(
              title: 'Report',
              image: Icon(
                Icons.report,
                color: Colors.white,
              )),
        ],
        onClickMenu: (val) {
          if (val.menuTitle == 'Voice call') {}
          if (val.menuTitle == 'Video call') {}
        },
        stateChanged: (val) {},
        onDismiss: () {});
  }

  PopupMenu menu;
}
