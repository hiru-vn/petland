import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/my_pet/pet_data_update.dart';
import 'package:petland/modules/my_pet/records/birthday_page.dart';
import 'package:petland/modules/my_pet/records/vaccine_page.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/image_view.dart';

class PetProfilePage extends StatefulWidget {
  final String petId;

  const PetProfilePage({
    Key key,
    this.petId,
  }) : super(key: key);

  static navigate({
    String petId,
  }) {
    navigatorKey.currentState.push(
      pageBuilder(
        PetProfilePage(
          petId: petId,
        ),
      ),
    );
  }

  @override
  _PetProfilePageState createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PetBloc _petBloc;
  PetModel _pet;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Pet\'s profile', actions: [
        IconButton(
            onPressed: () {
              PetDataUpdatePage.navigate(petId: _pet.id)
                  .then((value) => setState(() {}));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ]),
      body: Column(children: [
        PetProfileHeader(
            imgUrl: _pet.avatar,
            imageCover: _pet.coverImage,
            petName: _pet.name,
            petRace: _pet.race.name),
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
                Tab(text: '  Data  '),
                Tab(text: 'Pictures'),
                Tab(text: ' Videos '),
                Tab(text: 'Records '),
              ]),
        ),
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            child: TabBarView(
              controller: _tabController,
              children: [
                PetDataWidget(
                  gender: _pet.gender.toLowerCase(),
                  race: _pet.race.name,
                  birthdate: DateTime.tryParse(_pet.birthday),
                  characters: _pet.character,
                ),
                PetPictureWidget(_pet),
                PetVideoWidget(_pet),
                PetRecordWidget(_pet),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class PetProfileHeader extends StatelessWidget {
  final String imageCover;
  final String imgUrl;
  final String petName;
  final String petRace;

  const PetProfileHeader(
      {Key key, this.imageCover, this.imgUrl, this.petName, this.petRace})
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
                      child: ImageViewNetwork(url: imageCover)),
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
                      child: ImageViewNetwork(url: imgUrl))
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
}

class PetDataWidget extends StatelessWidget {
  final String race;
  final DateTime birthdate;
  final String gender;
  final List<String> characters;

  const PetDataWidget(
      {Key key, this.race, this.birthdate, this.gender, this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'BASIC DATA',
            style: ptBigTitle(),
          ),
          SpacingBox(h: 3),
          Divider(
            height: 3,
          ),
          ListTile(
            title: Text(
              'RACE',
              style: ptTitle(),
            ),
            trailing: Text(
              race ?? '',
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
            trailing: Text(Formart.formatToDate(birthdate) ?? ''),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: TextFieldTags(
              onTag: (val) {
                // characters.add(val);
              },
              onDelete: (val) {
                // characters.remove(val);
              },
              initialTags: characters,
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
                tagTextStyle: ptTitle().copyWith(color: Colors.white),
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
      ),
    );
  }
}

class PetPictureWidget extends StatelessWidget {
  final PetModel pet;
  PetPictureWidget(this.pet);
  @override
  Widget build(BuildContext context) {
    // final list = [
    //   'https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697',
    //   'https://c.files.bbci.co.uk/106B9/production/_114675276_catindex.jpg',
    //   'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg',
    //   'https://ebahana.com/wp-content/uploads/2019/02/maxresdefault-1-1.jpg',
    //   'https://i.pinimg.com/564x/0d/0a/65/0d0a65ab7a9935b9635684fb80836e4e.jpg',
    //   'https://i.pinimg.com/564x/0d/0a/65/0d0a65ab7a9935b9635684fb80836e4e.jpg',
    //   'https://www.iflr.com/Media/images/iflr/1-abstract/AdobeStock_324008934.jpeg',
    //   'https://ichef.bbci.co.uk/news/1024/cpsprodpb/151AB/production/_111434468_gettyimages-1143489763.jpg',
    //   'https://static01.nyt.com/images/2020/04/22/science/22VIRUS-PETCATS1/22VIRUS-PETCATS1-mediumSquareAt3X.jpg',
    //   'https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/cat-410261.jpg?h=191a1c11&itok=c4ksCwxz',
    //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLkK5QsywkQyr89y6adF2dgs96uAbsWHD_fg&usqp=CAU'
    // ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          staggeredTiles: pet.images.map((_) => StaggeredTile.fit(1)).toList(),
          children: List.generate(pet.images.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: ImageViewNetwork(url: pet.images[index]),
            );
          }),
        ),
      ),
    );
  }
}

class PetVideoWidget extends StatelessWidget {
  final PetModel pet;
  PetVideoWidget(this.pet);
  @override
  Widget build(BuildContext context) {
    final list = [];
    return list.length != 0
        ? SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StaggeredGridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  staggeredTiles:
                      list.map((_) => StaggeredTile.fit(1)).toList(),
                  children: List.generate(list.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 4),
                      child: ImageViewNetwork(url: list[index]),
                    );
                  }),
                )),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: deviceWidth(context) / 4,
                  child: Image.asset('assets/image/logo.png')),
              SpacingBox(h: 2),
              SizedBox(
                width: deviceWidth(context) / 1.4,
                child: Text(
                  '${pet.name} does not have any videos yet',
                  style: ptBigBody(),
                  textAlign: TextAlign.center,
                ),
              ),
              SpacingBox(h: 5),
            ],
          );
  }
}

class PetRecordWidget extends StatelessWidget {
  final PetModel pet;
  PetRecordWidget(this.pet);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            height: 3,
          ),
          _buildRecordTile(context, 'VACCINES', () {
            VaccinePage.navigate(pet);
          }),
          Divider(
            height: 3,
          ),
          _buildRecordTile(context, 'BIRTHDAYS', () {
            BirthdayPage.navigate(pet);
          }),
          Divider(
            height: 3,
          ),
          _buildRecordTile(context, 'WEIGHTS', () {}),
          Divider(
            height: 3,
          ),
          _buildRecordTile(context, 'BATHS', () {}),
          Divider(
            height: 3,
          ),
        ],
      ),
    );
  }

  _buildRecordTile(BuildContext context, String title, Function onTap) {
    return InkWell(
      highlightColor: ptAccentColor(context),
      splashColor: ptPrimaryColor(context),
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: ptTitle().copyWith(
              fontWeight: FontWeight.w900, color: Colors.black54, fontSize: 14),
        ),
        trailing: Icon(
          MdiIcons.arrowRightCircle,
          size: 20,
          color: ptPrimaryColor(context),
        ),
      ),
    );
  }
}
