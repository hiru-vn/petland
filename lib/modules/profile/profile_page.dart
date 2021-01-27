import 'package:flutter/material.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/authentication/welcome.dart';
import 'package:petland/modules/inbox/inbox_list.dart';
import 'package:petland/modules/my_pet/pick_my_pet_list.dart';
import 'package:petland/modules/my_pet/pick_pet.dart';
import 'package:petland/modules/profile/about_page.dart';
import 'package:petland/modules/profile/feedback_page.dart';
import 'package:petland/modules/profile/policy_page.dart';
import 'package:petland/modules/profile/profile_owner.dart';
import 'package:petland/modules/profile/theme_page.dart';
import 'package:petland/share/import.dart';
import 'package:open_appstore/open_appstore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    _authBloc = Provider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

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
      {
        "name": "Language",
        "img": "assets/image/language.png",
        "action": () {
          pickList(context,
              title: 'Chọn ngôn ngữ',
              onPicked: (value) {},
              options: ['Tiếng Việt', 'English'],
              closeText: 'Xong');
        }
      },
      {
        "name": "Night Mode",
        "img": "assets/image/night_mode.png",
        "action": () {
          ThemePage.navigate();
        }
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
      {
        "name": "Feedback",
        "img": "assets/image/feedback.png",
        "action": () {
          FeedbackPage.navigate();
        }
      },
      {
        "name": "Rate Petland",
        "img": "assets/image/rate_us.png",
        "action": () {
          OpenAppstore.launch(
              androidAppId: "io.payvin.ex", iOSAppId: "284882215");
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
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1.3, color: ptDarkColor(context)),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: _authBloc.userModel.avatar != null
                              ? NetworkImage(_authBloc.userModel.avatar)
                              : AssetImage('assets/image/avatar.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _authBloc.userModel.name,
                          style:
                              ptTitle().copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 3),
                        GestureDetector(
                          onTap: () {
                            OwnerProfilePage.navigate(_authBloc.userModel);
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
                                  'Add your cute friend profile to Petland',
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
                                    color: ptDarkColor(context),
                                  ),
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
                  onPress: () {
                    WelcomePage.navigate();
                  },
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
