import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/my_pet/pet_race.dart';
import 'package:petland/share/import.dart';

class PetDataUpdatePage extends StatefulWidget {
  final String petId;

  const PetDataUpdatePage({
    Key key,
    this.petId,
  }) : super(key: key);

  static navigate({
    String petId,
  }) {
    navigatorKey.currentState.push(pageBuilder(PetDataUpdatePage(
      petId: petId,
    )));
  }

  @override
  _PetDataUpdatePageState createState() => _PetDataUpdatePageState();
}

class _PetDataUpdatePageState extends State<PetDataUpdatePage> {
  bool _isUpdate = false;
  PetBloc _petBloc;
  PetModel _pet;

  @override
  void initState() {
    if (widget.petId != null) _isUpdate = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_petBloc == null) {
      _petBloc = Provider.of<PetBloc>(context);
      _pet = _petBloc.pets.firstWhere((element) => element.id == widget.petId);
    }
    super.didChangeDependencies();
  }

  Future _save() {
    if (_isUpdate) {}
    navigatorKey.currentState.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Update Pet\'s data', actions: [
        if (_isUpdate)
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ))
      ]),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildHead(
              imgUrl: _pet.avatar,
              imageCover: _pet.coverImage,
              petName: _pet.name),
          SpacingBox(h: 3),
          _buildForm(),
          SpacingBox(h: 3),
          Padding(
              padding: const EdgeInsets.all(15),
              child: ExpandBtn(
                text: 'Save',
                onPress: _save,
              ))
        ]),
      ),
    );
  }

  _buildHead({String imageCover, String imgUrl, String petName}) {
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
            left: deviceWidth(context) / 10 + 125,
            bottom: 10,
            child: TextFormField(
              initialValue: petName,
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_pet.race != null) ...[
                  Text(
                    _pet.race.name ?? '',
                  ),
                  SizedBox(width: 10),
                ],
                Icon(
                  MdiIcons.arrowRightCircle,
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_pet.birthday != null) ...[
                  Text(Formart.formatToDate(DateTime.tryParse(_pet.birthday))),
                  SizedBox(width: 10),
                ],
                Icon(
                  MdiIcons.calendar,
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
                if (_pet.gender == 'female' || _pet.gender == null)
                  Icon(
                    MdiIcons.genderFemale,
                    size: 20,
                    color: Colors.pink,
                  ),
                if (_pet.gender != 'female')
                  SizedBox(
                    width: 10,
                  ),
                if (_pet.gender == 'male' || _pet.gender == null)
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
            initialTags: _pet.character,
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
              tagTextStyle: ptTitle().copyWith(color: Colors.white),
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
