import 'package:petland/modules/my_pet/pet_race.dart';
import 'package:petland/modules/my_pet/records/birthday_page.dart';
import 'package:petland/modules/my_pet/records/vaccine_page.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/image_view.dart';

class OwnerProfilePage extends StatefulWidget {
  final DateTime birthdate;
  final String gender;
  final String imgUrl;
  final String bgUrl;
  final String name;
  final String nickName;
  final String country;
  final String description;
  final String email;

  const OwnerProfilePage(
      {Key key,
      this.birthdate,
      this.gender,
      this.bgUrl,
      this.imgUrl,
      this.name,
      this.nickName,
      this.description,
      this.country,
      this.email})
      : super(key: key);

  static navigate(
      {DateTime birthdate,
      String gender,
      String imgUrl,
      String bgUrl,
      String name,
      String nickName,
      String country,
      String description,
      String email}) {
    navigatorKey.currentState.push(
      pageBuilder(
        OwnerProfilePage(
          birthdate: birthdate,
          gender: gender,
          imgUrl: imgUrl,
          bgUrl: bgUrl,
          name: name,
          nickName: nickName,
          description: description,
          country: country,
          email: email,
        ),
      ),
    );
  }

  @override
  _OwnerProfilePageState createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage>
    with SingleTickerProviderStateMixin {
  DateTime _birthdate;
  String _gender;
  String _imgUrl;
  String _bgUrl;
  String _name;
  String _description;
  String _nickName;
  String _country;
  String _email;
  TabController _tabController;

  @override
  void initState() {
    _birthdate = widget.birthdate;
    _gender = widget.gender;
    _imgUrl = widget.imgUrl;
    _bgUrl = widget.bgUrl;
    _name = widget.name;
    _description = widget.description;
    _nickName = widget.nickName;
    _country = widget.country;
    _tabController = TabController(length: 3, vsync: this);
    _email = widget.email;
    super.initState();
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
            imgUrl: _imgUrl,
            imageCover: _bgUrl,
            name: _name,
            description: _description),
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
                  nickName: _nickName,
                  birthdate: _birthdate,
                  gender: _gender,
                  country: _country,
                  email: _email,
                ),
                Container(),
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
                  name,
                  style: ptBigTitle().copyWith(fontSize: 19.5),
                ),
                Text(
                  description,
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
  final DateTime birthdate;
  final String gender;
  final String country;
  final String email;

  const OwnerDataWidget(
      {Key key,
      this.nickName,
      this.birthdate,
      this.gender,
      this.country,
      this.email})
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

class OwnerPictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = [
      'https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697',
      'https://c.files.bbci.co.uk/106B9/production/_114675276_catindex.jpg',
      'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg',
      'https://ebahana.com/wp-content/uploads/2019/02/maxresdefault-1-1.jpg',
      'https://i.pinimg.com/564x/0d/0a/65/0d0a65ab7a9935b9635684fb80836e4e.jpg',
      'https://i.pinimg.com/564x/0d/0a/65/0d0a65ab7a9935b9635684fb80836e4e.jpg',
      'https://www.iflr.com/Media/images/iflr/1-abstract/AdobeStock_324008934.jpeg',
      'https://ichef.bbci.co.uk/news/1024/cpsprodpb/151AB/production/_111434468_gettyimages-1143489763.jpg',
      'https://static01.nyt.com/images/2020/04/22/science/22VIRUS-PETCATS1/22VIRUS-PETCATS1-mediumSquareAt3X.jpg',
      'https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/cat-410261.jpg?h=191a1c11&itok=c4ksCwxz',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLkK5QsywkQyr89y6adF2dgs96uAbsWHD_fg&usqp=CAU'
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          staggeredTiles: list.map((_) => StaggeredTile.fit(1)).toList(),
          children: List.generate(list.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: ImageViewNetwork(url: list[index]),
            );
          }),
        ),
      ),
    );
  }
}

class OwnerVideoWidget extends StatelessWidget {
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
                  'Mick does not have any videos yet',
                  style: ptBigBody(),
                  textAlign: TextAlign.center,
                ),
              ),
              SpacingBox(h: 5),
            ],
          );
  }
}

class OwnerRecordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            height: 3,
          ),
          _buildRecordTile(context, 'VACCINES', () {
            VaccinePage.navigate();
          }),
          Divider(
            height: 3,
          ),
          _buildRecordTile(context, 'BIRTHDAYS', () {
            BirthdayPage.navigate();
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
