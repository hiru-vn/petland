import 'package:petland/modules/my_pet/pet_race.dart';
import 'package:petland/share/import.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PetInfoPage extends StatefulWidget {
  static navigate() {
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
          SpacingBox(h: 3),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ExpandBtn(
                text: 'Save',
                onPress: () {
                  navigatorKey.currentState.maybePop();
                }),
          )
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
          onTap: () {
            PetRacePage.navigate();
          },
          child: ListTile(
            title: Text(
              'RACE',
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
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now(),
            );
          },
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
          onTap: () {
            navigatorKey.currentState
                .push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PickerPage(
                  list: [
                    PickerPageModel(
                      Icon(
                        MdiIcons.genderMale,
                        color: ptPrimaryColor(context),
                      ),
                      'Male',
                      'male',
                    ),
                    PickerPageModel(
                      Icon(
                        MdiIcons.genderFemale,
                        color: Colors.pink,
                      ),
                      'Female',
                      'female',
                    ),
                  ],
                  
                  title: 'Pet gender',
                ),
                transitionsBuilder: transitionUpBuilder,
              ),
            )
                .then((value) {
              setState(() {});
            });
          },
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
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: TextFieldTags(
            onTag: (val) {},
            onDelete: (val) {},
            textFieldStyler: TextFieldStyler(
              hintText: 'CHARACTER',
              textStyle: ptTitle(),
              helperText: null,
              textFieldBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              textFieldEnabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              textFieldFocusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
            ),
            tagsStyler: TagsStyler(
              tagTextStyle: ptTitle(),
              tagDecoration: BoxDecoration(
                color: ptPrimaryColor(context),
                borderRadius: BorderRadius.circular(4),
              ),
              tagCancelIcon: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.cancel, size: 18.0, color: Colors.pink),
              ),
              tagPadding: const EdgeInsets.all(8),
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
      ],
    );
  }
}
