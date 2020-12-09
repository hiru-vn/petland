import 'package:petland/main.dart';
import 'package:petland/modules/authentication/welcome.dart';
import 'package:petland/share/import.dart';


class SplashPage extends StatelessWidget {
  static navigate(BuildContext context) {
    navigatorKey.currentState.pushReplacement(pageBuilder(SplashPage()));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      () => WelcomePage.navigate(context),
    );
    return Scaffold(
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: splash,
      ),
    );
  }
}
