import 'package:petland/bloc/wiki_bloc.dart';
import 'package:petland/model/wiki_category.dart';
import 'package:petland/model/wiki_post.dart';
import 'package:petland/modules/wiki/post_detail_page.dart';
import 'package:petland/share/functions/share_to.dart';
import 'package:petland/share/import.dart';

class PostListPage extends StatefulWidget {
  final WikiCategoryModel category;
  PostListPage(this.category);
  static navigate(WikiCategoryModel category) {
    return navigatorKey.currentState.push(pageBuilder(PostListPage(category)));
  }

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  WikiBloc _wikiBloc;
  List<WikiPostModel> list;

  @override
  void didChangeDependencies() {
    if (_wikiBloc == null) {
      _wikiBloc = Provider.of<WikiBloc>(context);
      _getList();
    }
    super.didChangeDependencies();
  }

  _getList() async {
    final res = await _wikiBloc.getListWikiPost(widget.category.id);
    if (res.isSuccess) {
      setState(() {
        list = res.data;
      });
    } else {
      showToast(res.errMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ptBackgroundColor(context),
        appBar: MyAppBar(
          title: 'Bệnh thường gặp',
          automaticallyImplyLeading: true,
          centerTitle: true,
          bgColor: Colors.white,
        ),
        body: list != null
            ? ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: list.length,
                itemBuilder: (context, index) => PostCard(
                    content: list[index].content,
                    image: list[index].image,
                    title: list[index].title,
                    date: DateTime.tryParse(list[index].updatedAt),
                    avatar: list[index].avatarWritter,
                    writer: list[index].nameWritter,
                    seen: list[index].seen,
                    like: list[index].like,
                    link: list[index].link),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
              )
            : kLoadingSpinner);
  }
}

class PostCard extends StatefulWidget {
  final String image;
  final String title;
  final String content;
  final DateTime date;
  final String writer;
  final String avatar;
  final int seen;
  final int like;
  final String link;

  const PostCard(
      {Key key,
      this.image,
      this.title,
      this.content,
      this.date,
      this.writer,
      this.avatar,
      this.seen,
      this.like,
      this.link})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _like;
  bool _isLiked = false;

  @override
  void initState() {
    _like = widget.like;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          PostDetailPage.navigate(widget.link);
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: SizedBox(
                  width: deviceWidth(context),
                  child: widget.image != null
                      ? Image.network(
                          widget.image,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.asset('assets/image/dog_cover.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                child: Text(
                  widget.title,
                  maxLines: null,
                  style: ptBigTitle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 15),
                child: Text(
                  widget.content,
                  maxLines: null,
                  style: ptBody(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.heart,
                            color: _isLiked ? Colors.red : Colors.black54,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            _like.toString(),
                            style: ptTiny(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.black54,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.seen.toString(),
                      style: ptTiny(),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        shareTo(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.share,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Share',
                            style: ptTiny(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(12).copyWith(top: 8),
                child: Row(children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: widget.avatar != null
                        ? NetworkImage(widget.avatar)
                        : AssetImage('assets/image/avatar.png'),
                  ),
                  SizedBox(width: 7),
                  Text(widget.writer ?? '',
                      style: ptSmall().copyWith(fontWeight: FontWeight.w700)),
                  Spacer(),
                  Text(
                    Formart.formatToDate(widget.date),
                    style: ptSmall(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
