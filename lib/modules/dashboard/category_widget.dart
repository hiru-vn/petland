import 'package:petland/modules/zoo/zoo_page.dart';
import 'package:petland/share/import.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Danh mục',
          style: ptBigTitle(),
        ),
        SpacingBox(h: 2),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CategoryItemWidget(
                image: 'assets/image/zoo.png',
                title: 'Pet zoo',
                onTap: () {
                  ZooPage.navigate();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: CategoryItemWidget(
                image: 'assets/image/tinder.png',
                title: 'Pet tinder',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: CategoryItemWidget(
                image: 'assets/image/wiki.png',
                title: 'Cẩm nang',
              ),
            ),
          ],
        ),
        SpacingBox(
          h: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  child: Image.asset('assets/image/sos.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  'Tìm thú cưng lạc & cứu trợ thú cưng',
                  style: ptTitle(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const CategoryItemWidget({Key key, this.image, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: deviceWidth(context) / 3 - 25,
            height: deviceWidth(context) / 3 - 25,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: ptTitle(),
          )
        ],
      ),
    );
  }
}
