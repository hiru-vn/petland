import 'package:petland/share/import.dart';

class PickMyPetListpage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(PickMyPetListpage()));
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {"name": "Mick", "img": "assets/image/cat1.png"},
      {"name": "Tô", "img": "assets/image/cat_race_2.jpg"},
    ];
    return Scaffold(
      appBar: innerAppBar(context, 'My pets'),
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
                onTap: () => navigatorKey.currentState.maybePop(),
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
  final Function onTap;

  const PetRaceCard({Key key, this.image, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GestureDetector(
        onTap: onTap,
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
                  height: deviceWidth(context) / 2 - 20,
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
      ),
    );
  }
}
