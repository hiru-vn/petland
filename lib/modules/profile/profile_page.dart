import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = [
      {"name": "Brishtish short-hair", "img": "assets/image/cat_race_1.jpg"},
      {
        "name": "Brishtish short-hair golden",
        "img": "assets/image/cat_race_2.jpg"
      },
      {"name": "Brishtish long-hair", "img": "assets/image/cat_race_3.jpg"},
      {"name": "beganli", "img": "assets/image/cat_race_4.jpg"},
      {"name": "Burmilla", "img": "assets/image/cat_race_5.jpeg"},
      {"name": "Exotic short hair", "img": "assets/image/cat_race_6.jpg"},
      {"name": "Yellow cat", "img": "assets/image/cat_race_7.png"},
      {"name": "Muchin", "img": "assets/image/cat_race_8.png"}
    ];
    return Scaffold(
      appBar: MyAppBar(
        title: 'Profile',
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 21,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.message,
                size: 21,
              ),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/image/cat1.png'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pet Choy',
                          style:
                              ptTitle().copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Change profile infomation',
                          style: ptSmall().copyWith(color: Colors.black54),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: ptDarkColor(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Create a Profile for your pet',
                            maxLines: null,
                            style: ptBody().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              StaggeredGridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                staggeredTiles: list.map((_) => StaggeredTile.fit(1)).toList(),
                children: List.generate(list.length, (index) {
                  return ProfileItemCard(
                    title: list[index]['name'],
                    image: list[index]['img'],
                    onTap: () => navigatorKey.currentState.maybePop(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItemCard extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const ProfileItemCard({Key key, this.image, this.title, this.onTap})
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
