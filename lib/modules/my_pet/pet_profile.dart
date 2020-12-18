import 'package:petland/modules/my_pet/pet_race.dart';
import 'package:petland/share/import.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PetProfilePage extends StatefulWidget {
  final String race;
  final DateTime birthdate;
  final String gender;
  final List<String> characters;
  final String imgUrl;
  final String bgUrl;
  final String petName;

  const PetProfilePage(
      {Key key,
      this.race,
      this.birthdate,
      this.gender,
      this.characters,
      this.bgUrl,
      this.imgUrl,
      this.petName})
      : super(key: key);

  static navigate(
      {String race,
      DateTime birthdate,
      String gender,
      List<String> characters,
      String imgUrl,
      String bgUrl,
      String petName}) {
    navigatorKey.currentState.push(pageBuilder(PetProfilePage(
      race: race,
      birthdate: birthdate,
      gender: gender,
      characters: characters,
      imgUrl: imgUrl,
      bgUrl: bgUrl,
      petName: petName,
    )));
  }

  @override
  _PetProfilePageState createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage>
    with SingleTickerProviderStateMixin {
  String _race;
  DateTime _birthdate;
  String _gender;
  List<String> _characters;
  String _imgUrl;
  String _bgUrl;
  String _petName;
  TabController _tabController;

  @override
  void initState() {
    _race = widget.race;
    _birthdate = widget.birthdate;
    _gender = widget.gender;
    _characters = widget.characters ?? <String>[];
    _imgUrl = widget.imgUrl;
    _bgUrl = widget.bgUrl;
    _petName = widget.petName;
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Pet\'s profile'),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildHead(
              imgUrl: _imgUrl,
              imageCover: _bgUrl,
              petName: _petName,
              petRace: _race),
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
                      width: deviceWidth(context) / 3,
                      child: Tab(text: 'Chuyên viên')),
                  SizedBox(
                    width: deviceWidth(context) / 3,
                    child: Tab(text: 'Quản trị viên'),
                  ),
                ]),
          ),
          Expanded(
            flex: 9,
            child: Material(
              elevation: 5,
              child: Container(
                color: Colors.grey[100],
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ),
          ),
          _buildForm(),
        ]),
      ),
    );
  }

  _buildHead(
      {String imageCover, String imgUrl, String petName, String petRace}) {
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
                  petName,
                  style: ptBigTitle().copyWith(fontSize: 19.5),
                ),
                Text(
                  petRace,
                ),
              ],
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
            trailing: Text(
              _race ?? '',
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        ListTile(
          title: Text(
            'BIRTHDAY',
            style: ptTitle(),
          ),
          trailing: Text(Formart.formatToDate(_birthdate) ?? ''),
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
              if (_gender == 'female' || _gender == null)
                Icon(
                  MdiIcons.genderFemale,
                  size: 20,
                  color: Colors.pink,
                ),
              if (_gender != 'female')
                SizedBox(
                  width: 10,
                ),
              if (_gender == 'male' || _gender == null)
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: TextFieldTags(
            onTag: (val) {},
            onDelete: (val) {},
            initialTags: _characters,
            textFieldStyler: TextFieldStyler(
              textFieldEnabled: false,
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
              textFieldDisabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
            ),
            tagsStyler: TagsStyler(
              tagTextStyle: ptTitle(),
              tagDecoration: BoxDecoration(
                color: ptPrimaryColor(context),
                borderRadius: BorderRadius.circular(4),
              ),
              tagCancelIcon: SizedBox.shrink(),
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
