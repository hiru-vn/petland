import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class PetInfoPage extends StatefulWidget {
  static navigate(BuildContext context) {
    navigatorKey.currentState.push(pageBuilder(PetInfoPage()));
  }

  @override
  _PetInfoPageState createState() => _PetInfoPageState();
}

class _PetInfoPageState extends State<PetInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Update Pet\'s info'),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildHead(),
          SpacingBox(h: 3),
          _buildForm(),
        ]),
      ),
    );
  }

  _buildHead({String imageCover}) {
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
                  Image.network(imageCover, fit: BoxFit.cover),
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
              child: Icon(
                MdiIcons.camera,
                size: 70,
                color: Colors.white30,
              ),
            ),
          ),
          Positioned(
            right: 15,
            left: deviceWidth(context) / 10 + 125,
            bottom: 10,
            child: TextFormField(
              style: ptBigTitle().copyWith(fontSize: 19.5),
              decoration: InputDecoration(
                hintText: 'Pet name',
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildForm() {
    return Column(
      children: [
        Text(
          'BASIC DATA',
          style: ptBigTitle(),
        ),
        SpacingBox(h: 3),
        Divider(
          height: 3,
        ),
        InkWell(
          highlightColor: ptAccentColor(context),
          splashColor: ptPrimaryColor(context),
          onTap: () {},
          child: ListTile(
            title: Text(
              'BREED',
              style: ptTitle(),
            ),
            trailing: Icon(
              MdiIcons.arrowRightCircle,
              size: 20,
              color: ptPrimaryColor(context),
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
              'BIRTHDAY',
              style: ptTitle(),
            ),
            trailing: Icon(
              MdiIcons.calendar,
              size: 20,
              color: ptPrimaryColor(context),
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
              'GENDER',
              style: ptTitle(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  MdiIcons.genderFemale,
                  size: 20,
                  color: Colors.pink,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  MdiIcons.genderMale,
                  size: 20,
                  color: ptPrimaryColor(context),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            style: ptBigTitle(),
            decoration: InputDecoration(
              hintText: 'Pet name',
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
