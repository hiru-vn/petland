import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/modules/authentication/register.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/home_page.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/spin_loader.dart';

class LoginPage extends StatefulWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(LoginPage()));
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc _authBloc;
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passC = TextEditingController();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    _authBloc = Provider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  _submit() async {
    setState(() {
      isLoading = true;
    });
    final res =
        await _authBloc.signInWithEmailAndPassword(_emailC.text, _passC.text);
    setState(() {
      isLoading = false;
    });
    if (!res.isSuccess) {
      showToast(res.errMessage, context);
      return;
    }
    await PetBloc.instance.getAllPet();
    HomePage.navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: MyAppBar(
            leading: BackBtn(),
            bgColor: HexColor('#21323A'),
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
                      onPress: () async {
                        final check = await _authBloc.signInWithFacebook();
                        if (check) HomePage.navigate();
                        return true;
                      },
                    ),
                    SpacingBox(h: 2),
                    GoogleBtn(
                      onPress: () async {
                        final check = await _authBloc.signInWithFacebook();
                        if (check) HomePage.navigate();
                        return true;
                      },
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
                      controller: _emailC,
                    ),
                    SpacingBox(h: 3),
                    InputWithLeading(
                      icon: Icons.lock,
                      hint: 'Password',
                      textStyle: ptTitle().copyWith(color: Colors.white70),
                      iconBgColor: HexColor('#623a42'),
                      iconColor: HexColor('#fb565e'),
                      controller: _passC,
                    ),
                    SpacingBox(h: 4),
                    ExpandBtn(
                      text: 'Đăng nhập',
                      onPress: _submit,
                    ),
                    SpacingBox(h: 2),
                    Center(
                      child: Text(
                        'Quên mật khẩu?',
                        style: ptTitle().copyWith(
                            color: Colors.white60, letterSpacing: 0.6),
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
        ),
        if (isLoading) kLoadingSpinner,
      ],
    );
  }
}
