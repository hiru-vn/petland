import 'package:flutter/material.dart';
import 'package:petland/modules/inbox/inbox_list.dart';
import 'package:petland/modules/my_pet/pick_my_pet_list.dart';
import 'package:petland/modules/my_pet/pick_pet.dart';
import 'package:petland/share/import.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = [
      {"name": "My Pets", "img": "assets/image/my_pet_icon.png"},
      {"name": "Invite Friends", "img": "assets/image/invite_friend.jpg"},
      {"name": "Save Images", "img": "assets/image/save_post.png"},
      {"name": "Language", "img": "assets/image/language.png"},
      {"name": "Night Mode", "img": "assets/image/night_mode.png"},
      {"name": "Terms & Policy", "img": "assets/image/policy.png"},
      {"name": "About Petland", "img": "assets/image/logo.png"},
    ];
    return Scaffold(
      appBar: MyAppBar(
        title: 'Profile',
        actions: [
          Center(child: AnimatedSearchBar()),
          IconButton(
              icon: Icon(
                Icons.message,
                size: 21,
              ),
              onPressed: () {
                InboxList.navigate();
              }),
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
                    Container(
                      width: 57,
                      height: 57,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1.5, color: ptDarkColor(context)),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage: AssetImage('assets/image/cat1.png'),
                        ),
                      ),
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
                child: GestureDetector(
                  onTap: () {
                    PickPet.navigate();
                  },
                  child: Card(
                    color: ptDarkColor(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10)
                                    .copyWith(bottom: 5),
                                child: Text(
                                  'Create a Profile for your pet',
                                  maxLines: null,
                                  style: ptBody().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(10).copyWith(top: 0),
                                child: Text(
                                  'Add your cute friend profile to PetLand',
                                  maxLines: null,
                                  style: ptTiny().copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: Container(
                                  height: 41,
                                  width: 41,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ptDarkColor(context)),
                                  child: Center(
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: ptDarkColor(context),
                                          size: 27,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    onTap: () {
                      PickMyPetListpage.navigate();
                    },
                  );
                }),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ExpandBtn(
                  text: 'Logout',
                  onPress: () {},
                  color: ptGreyColor(context).withOpacity(0.6),
                  height: 45,
                  textColor: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'v1.0.21',
                style: ptSmall().copyWith(color: Colors.black54),
              ),
              SizedBox(height: 70),
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
              SizedBox(
                width: deviceWidth(context) / 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15).copyWith(bottom: 5),
                      child: SizedBox(
                        width: deviceWidth(context) / 7,
                        child: Image.asset(
                          image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    title,
                    maxLines: null,
                    style: ptTitle().copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
