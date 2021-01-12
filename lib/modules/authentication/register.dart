import 'package:flutter/material.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/home_page.dart';
import 'package:petland/navigator.dart';
import 'package:petland/share/widgets/appbar.dart';
import 'package:petland/share/widgets/back_btn.dart';
import 'package:petland/share/widgets/expand_btn.dart';
import 'package:petland/share/widgets/input.dart';
import 'package:petland/share/widgets/page_builder.dart';
import 'package:petland/share/widgets/spacing_box.dart';
import 'package:petland/share/import.dart';

class RegisterPage extends StatefulWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(RegisterPage()));
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc _authBloc;
  TextEditingController _nameC = TextEditingController();
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passC = TextEditingController();
  TextEditingController _repassC = TextEditingController();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    _authBloc = Provider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  _register() async {
    if (_passC.text.length < 6) {
      showToast('Mật khẩu phải nhiều hơn 6 kí tự', context);
      return;
    }
    if (_passC.text != _repassC.text) {
      showToast('Mật khẩu không trùng khớp', context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    final res = await _authBloc.registerWithEmailAndPassword(
        _emailC.text, _passC.text, _nameC.text);
    setState(() {
      isLoading = false;
    });
    if (!res.isSuccess) {
      showToast(res.errMessage, context);
      return;
    }
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
                      'Create your account',
                      style: ptHeadLineSmall().copyWith(color: Colors.white),
                    ),
                    SpacingBox(h: 5),
                    InputWithLeading(
                      icon: Icons.pets,
                      hint: 'Full name',
                      textStyle: ptTitle().copyWith(color: Colors.white70),
                      controller: _nameC,
                    ),
                    SpacingBox(h: 5),
                    InputWithLeading(
                      icon: Icons.mail,
                      hint: 'Email',
                      textStyle: ptTitle().copyWith(color: Colors.white70),
                      controller: _emailC,
                    ),
                    SpacingBox(h: 5),
                    InputWithLeading(
                      icon: Icons.lock,
                      hint: 'Password',
                      textStyle: ptTitle().copyWith(color: Colors.white70),
                      controller: _passC,
                    ),
                    SpacingBox(h: 5),
                    InputWithLeading(
                      icon: Icons.lock,
                      hint: 'Password Confirm',
                      textStyle: ptTitle().copyWith(color: Colors.white70),
                      controller: _repassC,
                    ),
                    SpacingBox(h: 8),
                    ExpandBtn(text: 'Let\'s get started', onPress: _register),
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
