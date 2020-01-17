import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithGoogle() async {
    try {
      var googleUser = await _googleSignIn.signIn();
      var googleAuth = await googleUser.authentication;
      var credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      var authResult = await _auth.signInWithCredential(credential);
      var user = authResult.user;
      return user;
    } catch (e) {
      return e.message;
    }
  }

  Future handleSignOut() {
    _googleSignIn.signOut();
    return _auth.signOut();
  }
}
