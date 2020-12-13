import 'package:petland/share/import.dart';

class MyPetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: () {},
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
    );
  }
}

class Petcard extends StatelessWidget {
  final String image;
  final String name;

  const Petcard({Key key, this.image, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }
}
