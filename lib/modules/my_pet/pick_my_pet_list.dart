import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/modules/my_pet/pet_profile.dart';
import 'package:petland/share/import.dart';

class PickMyPetListpage extends StatefulWidget {
  final bool isPick;

  const PickMyPetListpage({Key key, this.isPick}) : super(key: key);
  static Future navigate({bool isPick = true}) {
    return navigatorKey.currentState.push(pageBuilder(PickMyPetListpage(
      isPick: isPick,
    )));
  }

  @override
  _PickMyPetListpageState createState() => _PickMyPetListpageState();
}

class _PickMyPetListpageState extends State<PickMyPetListpage> {
  PetBloc _petBloc;

  @override
  void didChangeDependencies() {
    if (_petBloc == null) {
      _petBloc = Provider.of<PetBloc>(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'My pets'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            staggeredTiles:
                _petBloc.pets.map((_) => StaggeredTile.fit(1)).toList(),
            children: List.generate(_petBloc.pets.length, (index) {
              return PetCard(
                title: _petBloc.pets[index].name,
                image: _petBloc.pets[index].avatar,
                onTap: () => (!widget.isPick)
                    ? PetProfilePage.navigate(petId: _petBloc.pets[index].id)
                    : navigatorKey.currentState.maybePop(_petBloc.pets[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const PetCard({Key key, this.image, this.title, this.onTap})
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
                  height: deviceWidth(context) / 2 - 20,
                  child: Image.network(
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
