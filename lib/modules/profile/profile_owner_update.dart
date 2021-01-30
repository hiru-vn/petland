import 'dart:io';

import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/inbox/inbox_bloc.dart';
import 'package:petland/modules/my_pet/pet_profile.dart';
import 'package:petland/share/import.dart';
import 'package:petland/utils/file_util.dart';

class OwnerProfileUpdatePage extends StatefulWidget {
  final UserModel user;

  const OwnerProfileUpdatePage({Key key, this.user}) : super(key: key);

  static Future navigate(UserModel user) {
    return navigatorKey.currentState.push(
      pageBuilder(
        OwnerProfileUpdatePage(
          user: user,
        ),
      ),
    );
  }

  @override
  _OwnerProfileUpdatePageState createState() => _OwnerProfileUpdatePageState();
}

class _OwnerProfileUpdatePageState extends State<OwnerProfileUpdatePage> {
  UserModel _user;
  AuthBloc _authBloc;
  PetBloc _petBloc;
  List<PetModel> pets = [];
  bool isMe = true;

  @override
  void initState() {
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

  Future _save() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(
        context,
        widget.user.id == _authBloc.userModel.id
            ? 'My profile'
            : widget.user.name,
      ),
      body: Column(children: [
        _buildHead(),
        SpacingBox(h: 2),
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            child:_buildForm(),
          ),
        ),
      ]),
    );
  }

  _buildHead() {
    return   Column(
      children: [
        Container(
          height: 210,
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
                    if (_user.backgroundimage != null)
                      SizedBox(
                          width: deviceWidth(context),
                          child: Image.network(_user.backgroundimage,
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
                  child: _user.avatar != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: Image.network(_user.avatar,
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
                    
                    TextFormField(
                      initialValue: _user.name,
                      style: ptBigTitle().copyWith(fontSize: 19.5),
                      decoration: InputDecoration(
                        hintText: 'User name',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      initialValue: _user.description,
                      style: ptBody().copyWith(fontSize: 14.5),
                      decoration: InputDecoration(
                        hintText: 'description',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildForm() {
    return Column(
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
              widget.user.nickName ?? '',
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
              if (_user.gender == 'female' || _user.gender == null)
                Icon(
                  MdiIcons.genderFemale,
                  size: 20,
                  color: Colors.pink,
                ),
              if (_user.gender != 'female')
                SizedBox(
                  width: 10,
                ),
              if (_user.gender == 'male' || _user.gender == null)
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
              _user.country ?? '',
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
              _user.email ?? '',
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        SpacingBox(h: 3),
            Padding(
                padding: const EdgeInsets.all(15),
                child: ExpandBtn(
                  text: 'Save',
                  onPress: _save,
                ))
      ],
    );
  }
}