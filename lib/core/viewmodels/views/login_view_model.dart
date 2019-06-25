import 'package:firebase_auth/firebase_auth.dart';
import 'package:valoro/core/services/auth_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthService _authService;

  LoginViewModel({AuthService authService}) : _authService = authService;

  Future<FirebaseUser> handleSignIn() async {
    setBusy(true);
    FirebaseUser firebaseUser = await _authService.handleSignIn();
    setBusy(false);
    return firebaseUser;
  }
}
