import 'package:flutter/material.dart';
import 'package:petland/modules/inbox/inbox_list.dart';
import 'package:petland/modules/my_pet/pick_my_pet_list.dart';
import 'package:petland/modules/my_pet/pick_pet.dart';
import 'package:petland/modules/profile/about.dart';
import 'package:petland/modules/profile/policy.dart';
import 'package:petland/modules/profile/profile_owner.dart';
import 'package:petland/share/import.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "name": "My Pets",
        "img": "assets/image/my_pet_icon.png",
        "action": () {
          PickMyPetListpage.navigate();
        }
      },
      {
        "name": "Invite Friends",
        "img": "assets/image/invite_friend.jpg",
        "action": () {}
      },
      {
        "name": "Save Images",
        "img": "assets/image/save_post.png",
        "action": () {}
      },
      {"name": "Language", "img": "assets/image/language.png", "action": () {}},
      {
        "name": "Night Mode",
        "img": "assets/image/night_mode.png",
        "action": () {}
      },
      {
        "name": "Terms & Policy",
        "img": "assets/image/policy.png",
        "action": () {
          PolicyPage.navigate();
        }
      },
      {
        "name": "About Petland",
        "img": "assets/image/logo.png",
        "action": () {
          AboutPage.navigate();
        }
      },
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
                        GestureDetector(
                          onTap: () {
                            OwnerProfilePage.navigate(
                                birthdate: DateTime.now(),
                                gender: 'male',
                                characters: ['cute', 'overweight', 'fat'],
                                bgUrl:
                                    'https://www.coversden.com/images/covers/1/690.jpg',
                                imgUrl:
                                    'https://ca-times.brightspotcdn.com/dims4/default/33c083b/2147483647/strip/true/crop/1611x906+0+0/resize/840x472!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2Fef%2F05c1aab3e76c3d902aa0548c0046%2Fla-la-hm-pet-issue-18-jpg-20150615',
                                name: 'John Carlar',
                                nickName: 'Brocat',
                                country: 'Viet Nam',
                                description: 'I love cats a lot');
                          },
                          child: Text(
                            'Change profile infomation',
                            style: ptSmall().copyWith(color: Colors.black54),
                          ),
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
                    onTap: list[index]['action'],
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
