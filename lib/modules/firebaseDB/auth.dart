import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

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

void signOutGoogle() async {
  await googleSignIn.signOut();
  print('User Sign Out');
}
