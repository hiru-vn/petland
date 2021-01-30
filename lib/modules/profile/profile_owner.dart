import 'dart:io';

import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/inbox/inbox_bloc.dart';
import 'package:petland/modules/my_pet/pet_profile.dart';
import 'package:petland/modules/profile/profile_owner_update.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/empty_widget.dart';
import 'package:petland/utils/file_util.dart';

class OwnerProfilePage extends StatefulWidget {
  final UserModel user;

  const OwnerProfilePage({Key key, this.user}) : super(key: key);

  static navigate(UserModel user) {
    navigatorKey.currentState.push(
      pageBuilder(
        OwnerProfilePage(
          user: user,
        ),
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
  List<PetModel> pets = [];
  bool isMe = true;

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
      _user = widget.user;
      if (_user.id == AuthBloc.instance.userModel.id)
        isMe = true;
      else
        isMe = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(
          context,
          widget.user.id == _authBloc.userModel.id
              ? 'My profile'
              : widget.user.name,
          actions: [
            if (widget.user.id == _authBloc.userModel.id)
              IconButton(
                onPressed: () {
                  OwnerProfileUpdatePage.navigate(_user)
                      .then((value) => setState(() {}));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
          ]),
      body: Column(children: [
        OwnerProfileHeader(
          user: _user,
          isMe: isMe,
        ),
        SpacingBox(h: isMe ? 3 : 0.6),
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
                  nickName: _user?.nickName,
                  gender: _user?.gender,
                  country: _user?.country,
                  email: _user?.email,
                ),
                Container(
                    width: deviceWidth(context),
                    height: 500,
                    child: OwnerPetListWidget(
                      user: _user,
                      isMe: isMe,
                    )),
                EmptyWidget(
                  assetImg: 'assets/image/no_user.png',
                  title: 'Chưa có người theo dõi nào',
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class OwnerProfileHeader extends StatefulWidget {
  final UserModel user;
  final bool isMe;

  const OwnerProfileHeader({Key key, this.user, this.isMe = true})
      : super(key: key);

  @override
  _OwnerProfileHeaderState createState() => _OwnerProfileHeaderState();
}

class _OwnerProfileHeaderState extends State<OwnerProfileHeader> {
  _updateAvatar(String filePath) async {
    setState(() {
      widget.user.avatar = loadingGif;
    });
    final url = await FileUtil.uploadFireStorage(File(filePath));
    setState(() {
      widget.user.avatar = url;
    });
  }

  _updateCoverImage(String filePath) async {
    setState(() {
      widget.user.backgroundimage = loadingGif;
    });
    final url = await FileUtil.uploadFireStorage(File(filePath));
    setState(() {
      widget.user.backgroundimage = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        PostBloc.instance.reload();
        return Future.value(true);
      },
      child: Column(
        children: [
          Container(
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
                      GestureDetector(
                        onLongPress: () {
                          imagePicker(context,
                              onCameraPick: _updateCoverImage,
                              onImagePick: _updateCoverImage);
                        },
                        child: Center(
                          child: Icon(
                            MdiIcons.camera,
                            size: 50,
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      if (widget.user.backgroundimage != null)
                        SizedBox(
                            width: deviceWidth(context),
                            child: Image.network(widget.user.backgroundimage,
                                fit: BoxFit.cover)),
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
                    child: widget.user.avatar != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.network(widget.user.avatar,
                                fit: BoxFit.cover))
                        : GestureDetector(
                            onLongPress: () {
                              imagePicker(context,
                                  onCameraPick: _updateAvatar,
                                  onImagePick: _updateAvatar);
                            },
                            child: Icon(
                              MdiIcons.camera,
                              size: 70,
                              color: Colors.white30,
                            ),
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
                        widget.user.name ?? '',
                        style: ptBigTitle().copyWith(fontSize: 19.5),
                      ),
                      Text(
                        widget.user.description ?? "",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (!widget.isMe)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {
                    if (AuthBloc.instance.userModel.follows
                        .contains(widget.user.id))
                      AuthBloc.instance.userModel.follows
                          .remove(widget.user.id);
                    else {
                      AuthBloc.instance.userModel.follows.add(widget.user.id);
                    }
                    PostBloc.instance.reload();
                    setState(() {});
                  },
                  child: Text(
                    AuthBloc.instance.userModel.follows.contains(widget.user.id)
                        ? 'Unfollow'
                        : 'Follow',
                    style: ptBody(),
                  ),
                  color: AuthBloc.instance.userModel.follows
                          .contains(widget.user.id)
                      ? Colors.pink
                      : ptPrimaryColor(context),
                ),
                SizedBox(width: 10),
                RaisedButton(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () async {
                    showSimpleLoadingDialog(context);
                    await InboxBloc.instance.navigateToChatWith(
                        widget.user.name,
                        widget.user.avatar,
                        DateTime.now(),
                        'Bạn và ${widget.user.name} đã trở thành bạn bè',
                        widget.user.avatar,
                        [AuthBloc.instance.userModel.id, widget.user.id]);
                    navigatorKey.currentState.maybePop();
                  },
                  child: Text(
                    'Nhắn tin',
                    style: ptBody(),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
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

class OwnerPetListWidget extends StatefulWidget {
  final UserModel user;
  final bool isMe;

  const OwnerPetListWidget({Key key, this.user, this.isMe = true})
      : super(key: key);

  @override
  _OwnerPetListWidgetState createState() => _OwnerPetListWidgetState();
}

class _OwnerPetListWidgetState extends State<OwnerPetListWidget> {
  List<PetModel> pets;
  PetBloc _petBloc;

  @override
  void initState() {
    if (widget.isMe)
      pets = _petBloc.pets;
    else {}
    super.initState();
  }

  didChangeDependencies() {
    if (_petBloc == null) {
      _petBloc = Provider.of<PetBloc>(context);
      _getListPet();
    }
    super.didChangeDependencies();
  }

  Future _getListPet() async {
    final res = await _petBloc.getAllPet(uid: widget.user.id);

    if (res.isSuccess) {
      pets = res.data;
    } else {
      showToast(res.errMessage, context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return pets != null
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                staggeredTiles: pets.map((_) => StaggeredTile.fit(1)).toList(),
                children: List.generate(pets.length, (index) {
                  return PetCard(
                    pet: pets[index],
                    onTap: () => PetProfilePage.navigate(petId: pets[index].id),
                  );
                }),
              ),
            ),
          )
        : kLoadingSpinner;
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
