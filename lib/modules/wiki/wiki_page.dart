import 'package:petland/share/import.dart';

class WikiPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(WikiPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(),
    );
  }
}
