import 'package:petland/modules/my_pet/pet_data_update.dart';
import 'package:petland/share/import.dart';

class PickPet extends StatelessWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(PickPet()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Pets', onSearch: (val) {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            PetCard(
              image: 'assets/image/dog_cover.jpg',
              title: 'DOG'.toUpperCase(),
            ),
            PetCard(
              image: 'assets/image/hamster_cover.jpg',
              title: 'HAMSTER'.toUpperCase(),
            ),
            PetCard(
              image: 'assets/image/cat_cover.webp',
              title: 'CAT'.toUpperCase(),
            ),
            PetCard(
              image: 'assets/image/parrot_cover.jpg',
              title: 'PARROT'.toUpperCase(),
            ),
          ]),
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final String image;
  final String title;

  const PetCard({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          PetDataUpdatePage.navigate();
        },
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: SizedBox(
                  height: 180,
                  width: deviceWidth(context),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  style: ptTitle().copyWith(
                    color: ptPrimaryColor(context),
                    letterSpacing: 1.3,
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
