import 'package:petland/share/import.dart';

class ZooPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(ZooPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
    );
  }
}