import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/share/import.dart';

class PetRacePage extends StatefulWidget {
  final String type;

  const PetRacePage({Key key, this.type}) : super(key: key);
  static navigate(String type) {
    return navigatorKey.currentState.push(pageBuilder(PetRacePage(type: type)));
  }

  @override
  _PetRacePageState createState() => _PetRacePageState();
}

class _PetRacePageState extends State<PetRacePage> {
  PetBloc _petBloc;

  @override
  void didChangeDependencies() {
    if (_petBloc == null) {
      _petBloc = Provider.of<PetBloc>(context);
      _petBloc.getAllPetRace(widget.type);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Pet race'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            staggeredTiles:
                _petBloc.races.map((_) => StaggeredTile.fit(1)).toList(),
            children: List.generate(_petBloc.races.length, (index) {
              return PetRaceCard(
                title: _petBloc.races[index].name,
                image: _petBloc.races[index].image,
                onTap: () =>
                    navigatorKey.currentState.maybePop(_petBloc.races[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class PetRaceCard extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const PetRaceCard({Key key, this.image, this.title, this.onTap})
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
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: SizedBox(
                  width: deviceWidth(context) / 2,
                  child: image.contains('assets/image')
                      ? Image.asset(
                          image,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.network(
                          image,
                          fit: BoxFit.fitWidth,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  maxLines: null,
                  style: ptTitle().copyWith(
                    color: ptPrimaryColor(context),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
