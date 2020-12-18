import 'package:petland/modules/my_pet/pet_profile.dart';
import 'package:petland/modules/my_pet/pick_pet.dart';
import 'package:petland/share/import.dart';

class MyPetWidget extends StatelessWidget {
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
            Petcard(
              image: 'assets/image/cat1.png',
              name: 'Mick',
            ),
            SizedBox(width: 6),
            Petcard(
              image: 'assets/image/cat2.png',
              name: 'Tô',
            ),
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
  final String image;
  final String name;

  const Petcard({Key key, this.image, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PetProfilePage.navigate(
            race: 'Bristish short-hair',
            birthdate: DateTime.now(),
            gender: 'male',
            characters: ['cute', 'overweight', 'fat'],
            bgUrl: 'https://www.coversden.com/images/covers/1/690.jpg',
            imgUrl: 'https://ca-times.brightspotcdn.com/dims4/default/33c083b/2147483647/strip/true/crop/1611x906+0+0/resize/840x472!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Ffd%2Fef%2F05c1aab3e76c3d902aa0548c0046%2Fla-la-hm-pet-issue-18-jpg-20150615',
            petName: 'Mick'
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
              Image.asset(
                image,
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
                      name,
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
