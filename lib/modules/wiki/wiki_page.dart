import 'dart:math';

import 'package:petland/bloc/wiki_bloc.dart';
import 'package:petland/model/wiki_category.dart';
import 'package:petland/modules/wiki/post_list_page.dart';
import 'package:petland/share/import.dart';

class WikiPage extends StatefulWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(WikiPage()));
  }

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  WikiBloc _wikiBloc;

  @override
  void didChangeDependencies() {
    if (_wikiBloc == null) {
      _wikiBloc = Provider.of<WikiBloc>(context);
      if (_wikiBloc.categories == null || _wikiBloc.wikiTypes == null) {
        _wikiBloc.init();
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_wikiBloc.categories == null || _wikiBloc.wikiTypes == null)
      return kLoadingSpinner;
    return Scaffold(
      appBar: MyAppBar(
        automaticallyImplyLeading: true,
        title: 'Pet Wiki',
        actions: [
          Center(
            child: AnimatedSearchBar(
              width: deviceWidth(context) / 2,
              height: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Divider(
            thickness: 20,
            height: 20,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              thickness: 20,
              height: 20,
            ),
            itemCount: _wikiBloc.wikiTypes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: WikiListCategory(
                  list: _wikiBloc.categories
                      .where((element) =>
                          element.typeOfwiki.id ==
                          _wikiBloc.wikiTypes[index].id)
                      .toList(),
                  title: _wikiBloc.wikiTypes[index].name,
                ),
              );
            },
          ),
          Divider(
            thickness: 20,
            height: 20,
          ),
        ]),
      ),
    );
  }
}

class WikiListCategory extends StatelessWidget {
  final List<WikiCategoryModel> list;
  final String title;

  WikiListCategory({Key key, this.list, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ptBigTitle(),
        ),
        SizedBox(
          height: 10,
        ),
        StaggeredGridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          staggeredTiles: list.map((_) => StaggeredTile.fit(1)).toList(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 6,
          children: List.generate(list.length, (index) {
            return WikiCategoryCard(
              title: list[index].title,
              sub: '${list[index].numberOfPost} bài viết',
              image: list[index].image,
              color: color[Random().nextInt(4)],
              onTap: () => PostListPage.navigate(list[index]),
            );
          }),
        ),
      ],
    );
  }

  final color = ['#3215a', '#48da9c', '#ee3ad1', '#00ee3a', '#ee3a11'];
}

class WikiCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String sub;
  final String color;
  final Function onTap;

  const WikiCategoryCard(
      {Key key, this.image, this.title, this.sub, this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 6,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: deviceWidth(context) / 2,
                  height: deviceWidth(context) / 2,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: HexColor(color).withOpacity(0.7),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            title,
                            maxLines: null,
                            style: ptBody().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            sub,
                            maxLines: null,
                            style: ptSmall().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
