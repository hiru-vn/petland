import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/my_pet/pet_profile.dart';
import 'package:petland/modules/my_pet/pick_pet.dart';
import 'package:petland/share/import.dart';

class MyPetWidget extends StatefulWidget {
  @override
  _MyPetWidgetState createState() => _MyPetWidgetState();
}

class _MyPetWidgetState extends State<MyPetWidget> {
  PetBloc _petBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_petBloc == null) {
      _petBloc = Provider.of<PetBloc>(context);
      _petBloc.getAllPet();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My pets',
          style: ptBigTitle(),
        ),
        SpacingBox(h: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._petBloc.pets
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Petcard(pet: e),
                  ),
                )
                .toList(),
            Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                PickPet.navigate();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orange.withOpacity(0.1),
                ),
                width: 44,
                height: 35,
                child: Icon(
                  Icons.add,
                  color: Colors.orange,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class Petcard extends StatelessWidget {
  final PetModel pet;

  const Petcard({Key key, this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PetProfilePage.navigate(
          petId: pet.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 110,
          height: 90,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                pet.avatar,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 25,
                  color: ptPrimaryColor(context).withOpacity(0.5),
                  child: Center(
                    child: Text(
                      pet.name,
                      style: ptTitle().copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
