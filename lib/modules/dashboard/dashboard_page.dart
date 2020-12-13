import 'package:petland/modules/dashboard/category_widget.dart';
import 'package:petland/modules/dashboard/my_pet_widget.dart';
import 'package:petland/share/import.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: deviceWidth(context),
                child: Image.asset(
                  'assets/image/banner.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SpacingBox(h: 4),
                    MyPetWidget(),
                    SpacingBox(h: 3),
                    CategoryWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
