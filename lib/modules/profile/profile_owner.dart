import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/my_pet/pet_data_update.dart';
import 'package:petland/modules/my_pet/records/birthday_page.dart';
import 'package:petland/modules/my_pet/records/vaccine_page.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/image_view.dart';

class OwnerProfilePage extends StatefulWidget {
  const OwnerProfilePage({
    Key key,
  }) : super(key: key);

  static navigate() {
    navigatorKey.currentState.push(
      pageBuilder(
        OwnerProfilePage(),
      ),
    );
  }

  @override
  _OwnerProfilePageState createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage>
    with SingleTickerProviderStateMixin {
  UserModel _user;
  TabController _tabController;
  AuthBloc _authBloc;
  PetBloc _petBloc;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc == null) {
      _authBloc = Provider.of<AuthBloc>(context);
      _petBloc = Provider.of<PetBloc>(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'My profile', actions: [
        IconButton(
          onPressed: () {
            // OwnerDataUpdatePage.navigate(
            //     race: 'Bristish short-hair',
            //     birthdate: DateTime.now(),
            //     gender: 'male',
            //     bgUrl: 'https://www.coversden.com/images/covers/1/690.jpg',
            //     imgUrl:
            //         'https://ca-times.brightspotcdn.com/dims4/default/33c083b/2147483647/strip/true/crop/1611x906+0+0/resize/840x472!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2Fef%2F05c1aab3e76c3d902aa0548c0046%2Fla-la-hm-pet-issue-18-jpg-20150615',
            //     petName: 'Mick');
          },
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ]),
      body: Column(children: [
        OwnerProfileHeader(
            imgUrl: _authBloc.userModel?.avatar,
            imageCover: _authBloc.userModel?.backgroundimage,
            name: _authBloc.userModel?.name,
            description: _authBloc.userModel?.description),
        SpacingBox(h: 3),
        Align(
          alignment: Alignment.center,
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              indicatorColor: ptPrimaryColor(context),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black87,
              unselectedLabelStyle:
                  TextStyle(fontSize: 16, color: Colors.black54),
              labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
              tabs: [
                SizedBox(
                    width: deviceWidth(context) / 4.5,
                    child: Tab(text: 'Profile')),
                SizedBox(
                    width: deviceWidth(context) / 4.5,
                    child: Tab(text: 'Pets')),
                SizedBox(
                    width: deviceWidth(context) / 4.5,
                    child: Tab(text: 'Follow')),
              ]),
        ),
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            child: TabBarView(
              controller: _tabController,
              children: [
                OwnerDataWidget(
                  nickName: _authBloc.userModel?.nickName,
                  gender: 'MALE',
                  country: 'Viet nam',
                  email: _authBloc.userModel?.email,
                ),
                Container(
                    width: deviceWidth(context),
                    height: 500,
                    child: OwnerPetListWidget(
                      petBloc: _petBloc,
                    )),
                Container()
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class OwnerProfileHeader extends StatelessWidget {
  final String imageCover;
  final String imgUrl;
  final String name;
  final String description;

  const OwnerProfileHeader(
      {Key key, this.imageCover, this.imgUrl, this.name, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Stack(
        children: [
          Container(
            width: deviceWidth(context),
            height: 120,
            color: HexColor('#383838'),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.pets,
                    size: 100,
                    color: ptPrimaryColor(context),
                  ),
                ),
                Center(
                  child: Icon(
                    MdiIcons.camera,
                    size: 50,
                    color: Colors.white30,
                  ),
                ),
                if (imageCover != null)
                  SizedBox(
                      width: deviceWidth(context),
                      child: Image.network(imageCover, fit: BoxFit.cover)),
              ],
            ),
          ),
          Positioned(
            left: deviceWidth(context) / 10,
            top: 65,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ptPrimaryColor(context),
                border: Border.all(width: 2.5, color: Colors.white),
              ),
              child: imgUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: Image.network(imgUrl, fit: BoxFit.cover))
                  : Icon(
                      MdiIcons.camera,
                      size: 70,
                      color: Colors.white30,
                    ),
            ),
          ),
          Positioned(
            right: 15,
            left: deviceWidth(context) / 10 + 130,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: ptBigTitle().copyWith(fontSize: 19.5),
                ),
                Text(
                  description ?? "",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OwnerDataWidget extends StatelessWidget {
  final String nickName;
  final String gender;
  final String country;
  final String email;

  const OwnerDataWidget(
      {Key key, this.nickName, this.gender, this.country, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 3),
          InkWell(
            highlightColor: ptAccentColor(context),
            splashColor: ptPrimaryColor(context),
            onTap: () {},
            child: ListTile(
              title: Text(
                'NICK NAME',
                style: ptTitle(),
              ),
              trailing: Text(
                nickName ?? '',
              ),
            ),
          ),
          Divider(
            height: 3,
          ),
          ListTile(
            title: Text(
              'GENDER',
              style: ptTitle(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (gender == 'female' || gender == null)
                  Icon(
                    MdiIcons.genderFemale,
                    size: 20,
                    color: Colors.pink,
                  ),
                if (gender != 'female')
                  SizedBox(
                    width: 10,
                  ),
                if (gender == 'male' || gender == null)
                  Icon(
                    MdiIcons.genderMale,
                    size: 20,
                    color: ptPrimaryColor(context),
                  ),
              ],
            ),
          ),
          Divider(
            height: 3,
          ),
          InkWell(
            highlightColor: ptAccentColor(context),
            splashColor: ptPrimaryColor(context),
            onTap: () {},
            child: ListTile(
              title: Text(
                'COUNTRY',
                style: ptTitle(),
              ),
              trailing: Text(
                country ?? '',
              ),
            ),
          ),
          Divider(
            height: 3,
          ),
          InkWell(
            highlightColor: ptAccentColor(context),
            splashColor: ptPrimaryColor(context),
            onTap: () {},
            child: ListTile(
              title: Text(
                'EMAIL',
                style: ptTitle(),
              ),
              trailing: Text(
                email ?? '',
              ),
            ),
          ),
          Divider(
            height: 3,
          ),
        ],
      ),
    );
  }
}

class OwnerPetListWidget extends StatelessWidget {
  final PetBloc petBloc;

  const OwnerPetListWidget({Key key, this.petBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          staggeredTiles:
              petBloc.pets.map((_) => StaggeredTile.fit(1)).toList(),
          children: List.generate(petBloc.pets.length, (index) {
            return PetCard(
              pet: petBloc.pets[index],
              onTap: () => navigatorKey.currentState.maybePop(),
            );
          }),
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final PetModel pet;
  final Function onTap;

  const PetCard({Key key, this.pet, this.onTap}) : super(key: key);

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
                  child: Image.network(
                    pet.avatar,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10).copyWith(bottom: 5),
                child: Row(
                  children: [
                    Text(
                      pet.name,
                      maxLines: null,
                      style: ptTitle().copyWith(
                        color: ptPrimaryColor(context),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text('1 tuổi'),
                    Spacer(),
                    if (pet.gender == 'female'.toUpperCase() ||
                        pet.gender == null)
                      Icon(
                        MdiIcons.genderMale,
                        size: 14,
                        color: ptPrimaryColor(context),
                      ),
                    if (pet.gender == 'male'.toUpperCase() ||
                        pet.gender == null)
                      Icon(
                        MdiIcons.genderMale,
                        size: 14,
                        color: ptPrimaryColor(context),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10).copyWith(top: 0),
                child: Text(
                  pet.race.name,
                  maxLines: null,
                  style: ptSmall(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
