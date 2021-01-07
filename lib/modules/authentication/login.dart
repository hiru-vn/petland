import 'package:petland/modules/authentication/register.dart';
import 'package:petland/modules/home_page.dart';
import 'package:petland/share/import.dart';

class LoginPage extends StatelessWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        leading: BackBtn(),
        bgColor: ptDarkColor(context),
      ),
      backgroundColor: HexColor('#21323A'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            height: deviceHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight + 65),
                Text(
                  'Wellcome Back!',
                  style: ptHeadLine().copyWith(color: Colors.white),
                ),
                SpacingBox(h: 3),
                FacebookBtn(
                  onPress: () {},
                ),
                SpacingBox(h: 2),
                GoogleBtn(
                  onPress: () {},
                ),
                SpacingBox(h: 4),
                Center(
                  child: Text(
                    'OR LOGIN WITH EMAIL',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        letterSpacing: 0.6),
                  ),
                ),
                SpacingBox(h: 4),
                InputWithLeading(
                  icon: Icons.pets,
                  hint: 'Email',
                  textStyle: ptTitle().copyWith(color: Colors.white70),
                ),
                SpacingBox(h: 3),
                InputWithLeading(
                  icon: Icons.lock,
                  hint: 'Password',
                  textStyle: ptTitle().copyWith(color: Colors.white70),
                  iconBgColor: HexColor('#623a42'),
                  iconColor: HexColor('#fb565e'),
                ),
                SpacingBox(h: 4),
                ExpandBtn(
                    text: 'Đăng nhập',
                    onPress: () {
                      HomePage.navigate();
                    }),
                SpacingBox(h: 2),
                Center(
                  child: Text(
                    'Quên mật khẩu?',
                    style: ptTitle()
                        .copyWith(color: Colors.white60, letterSpacing: 0.6),
                  ),
                ),
                Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'DON\'T HAVE ACCOUNT?',
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () => RegisterPage.navigate(),
                    child: Text(
                      ' SIGN UP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
                SpacingBox(h: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
