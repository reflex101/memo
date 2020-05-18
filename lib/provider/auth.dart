import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:memo/models/httpException.dart';

// import '../models/httpException.dart';

class Auth with ChangeNotifier {
  final GoogleSignIn googleAuth = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleAuth.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();

      assert(user.uid == currentUser.uid);

      return 'Sign in succesful';
    } catch (e) {
      throw e;
    }
  }

  Future<FirebaseUser> getDisplay() {
    return _auth.currentUser();
  }

  void signOutGoogle() async {
    await googleAuth.signOut();
  }
}
