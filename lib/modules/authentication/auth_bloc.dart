import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:petland/repo/user_repo.dart';
import 'dart:async';

import 'package:petland/share/import.dart';

class AuthBloc extends ChangeNotifier {
  AuthBloc._privateConstructor();
  static final AuthBloc instance = AuthBloc._privateConstructor();

  UserRepo _userRepo = UserRepo();
  UserModel userModel;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();

  //Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      String fbToken = await user.getIdToken();
      final res = await _userRepo.login(idToken: fbToken);
      await SPref.instance.set('token', res['token']);
      userModel = UserModel.fromJson(res['user']);
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      await _userRepo.register(
          name: name, email: email, password: password);
      await Future.delayed(Duration(seconds: 1));
      final loginRes = await signInWithEmailAndPassword(email, password);
      return loginRes;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signInWithGoogle() async {
    final googleSignInAccount = await googleSignIn.signIn();
    final googleSignInAuthentication = await googleSignInAccount.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    return true;
  }

  Future<bool> signInWithFacebook() async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // _sendTokenToServer(result.accessToken.token);
        // _showLoggedInUI();
        return true;
        break;
      case FacebookLoginStatus.cancelledByUser:
        // _showCancelledMessage();
        return false;
        break;
      case FacebookLoginStatus.error:
        // _showErrorOnUI(result.errorMessage);
        return false;
        break;
    }
    return false;
  }

  void logout() async {
    await googleSignIn.signOut();
    print('User Sign Out');
  }
}
