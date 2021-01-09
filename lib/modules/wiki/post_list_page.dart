import 'package:petland/share/import.dart';

class PostListPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(PostListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Bệnh thường gặp',
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
    );
  }
}
