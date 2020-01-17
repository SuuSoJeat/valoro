import 'package:firebase_auth/firebase_auth.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/authentication_service.dart';
import 'package:valoro/core/services/dialog_service.dart';
import 'package:valoro/core/services/navigation_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';
import 'package:valoro/locator.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future signInWithGoogle() async {
    setBusy(true);
    var result = await _authenticationService.signInWithGoogle();
    setBusy(false);

    if (result != null && result is FirebaseUser) {
      print('successfully login as ${result.uid}');
      _navigationService.nagivateTo(RoutePaths.Home);
    } else {
      await _dialogService.showDialog(
        title: 'Sign In Failure!',
        description: result,
      );
    }
  }

  
}
