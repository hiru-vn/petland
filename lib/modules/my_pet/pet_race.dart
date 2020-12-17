import 'package:petland/share/import.dart';

class PetRacePage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(PetRacePage()));
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "name": "Brishtish short-hair",
        "img": "assets/image/cat_race_1.jpg"
      },
      {
        "name": "Brishtish short-hair golden",
        "img": "assets/image/cat_race_2.jpg"
      },
      {
        "name": "Brishtish long-hair",
        "img": "assets/image/cat_race_3.jpg"
      },
      {
        "name": "beganli",
        "img": "assets/image/cat_race_4.jpg"
      },
      {
        "name": "Burmilla",
        "img": "assets/image/cat_race_5.jpeg"
      },
      {
        "name": "Exotic short hair",
        "img": "assets/image/cat_race_6.jpg"
      },
      {
        "name": "Yellow cat",
        "img": "assets/image/cat_race_7.png"
      },
      {
        "name": "Muchin",
        "img": "assets/image/cat_race_8.png"
      }
    ];
    return Scaffold(
      appBar: innerAppBar(context, 'Pet race'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              staggeredTiles: list.map((_) => StaggeredTile.fit(1)).toList(),
              children: List.generate(list.length, (index) {
                return PetRaceCard(
                  title: list[index]['name'],
                  image: list[index]['img'],
                );
              }),
            ),
        ),
      ),
    );
  }
}

class PetRaceCard extends StatelessWidget {
  final String image;
  final String title;

  const PetRaceCard({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: SizedBox(
                width: deviceWidth(context) / 2,
                child: Image.asset(
                  image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                maxLines: null,
                style: ptTitle().copyWith(
                  color: ptPrimaryColor(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
