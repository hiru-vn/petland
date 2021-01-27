import 'package:petland/bloc/wiki_bloc.dart';
import 'package:petland/main.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/authentication/welcome.dart';
import 'package:petland/modules/home_page.dart';
import 'package:petland/share/import.dart';

class SplashPage extends StatefulWidget {
  static navigate() {
    navigatorKey.currentState.pushReplacement(pageBuilder(SplashPage()));
  }

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_authBloc == null) {
      _authBloc = Provider.of<AuthBloc>(context);
      Future.delayed(
        Duration(milliseconds: 500),
        () async {
          final isLog = await _authBloc.checkToken();
          if (!isLog)
            WelcomePage.navigate();
          else {
            final res = await _authBloc.getUserInfo();
            if (res.isSuccess) {
              HomePage.navigate();
              WikiBloc.instance.init();
            }
            else
              WelcomePage.navigate();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: splash,
      ),
    );
  }
}
