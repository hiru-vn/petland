import 'package:petland/modules/wiki/post_list_page.dart';
import 'package:petland/share/import.dart';

class WikiPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(WikiPage()));
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "title": "Bệnh thường gặp",
        "img": "assets/image/cat_race_1.jpg",
        "sub": "12 bài viết",
        "color": "#3215a"
      },
      {
        "title": "Chăm sóc chó",
        "img": "assets/image/cat_race_2.jpg",
        "sub": "12 bài viết",
        "color": "#48da9c"
      },
      {
        "title": "Chăm sóc mèo",
        "img": "assets/image/cat_race_3.jpg",
        "sub": "12 bài viết",
        "color": "#ee3ad1"
      },
      {
        "title": "Các loại vacxin",
        "img": "assets/image/cat_race_4.jpg",
        "sub": "12 bài viết",
        "color": "#ee3a11"
      },
      {
        "title": "Câu chuyện thú cưng",
        "img": "assets/image/cat_race_5.jpeg",
        "sub": "12 bài viết",
        "color": "#00ee3a"
      },
    ];
    final list2 = [
      {
        "title": "Các giống chó",
        "img": "assets/image/dog_cover.jpg",
        "sub": "12 bài viết",
        "color": "#3215a"
      },
      {
        "title": "Các giống mèo",
        "img": "assets/image/cat_race_2.jpg",
        "sub": "12 bài viết",
        "color": "#48da9c"
      },
      {
        "title": "Các giống hamster",
        "img": "assets/image/hamster_cover.jpg",
        "sub": "12 bài viết",
        "color": "#48da9c"
      },
      {
        "title": "Các giống Vẹt",
        "img": "assets/image/parrot_cover.jpg",
        "sub": "12 bài viết",
        "color": "#ee3ad1"
      },
    ];
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
          Padding(
            padding: EdgeInsets.all(15),
            child: WikiListCategory(
              list: list,
              title: 'Chăm sóc thú cưng',
            ),
          ),
          Divider(
            thickness: 20,
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: WikiListCategory(
              list: list2,
              title: 'Giống thú cưng',
            ),
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
  final List list;
  final String title;

  const WikiListCategory({Key key, this.list, this.title}) : super(key: key);
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
              title: list[index]['title'],
              sub: list[index]['sub'],
              image: list[index]['img'],
              color: list[index]['color'],
              onTap: () => PostListPage.navigate(),
            );
          }),
        ),
      ],
    );
  }
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
