import 'package:valoro/core/services/authentication_service.dart';
import 'package:valoro/core/services/dialog_service.dart';
import 'package:valoro/core/services/navigation_service.dart';
import 'package:valoro/core/viewmodels/base_model.dart';
import 'package:valoro/locator.dart';

class HomeViewModel extends BaseModel {
  
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  

  Future signOut() async {
    setBusy(true);
    var result = await _authenticationService.handleSignOut();
    setBusy(false);
    print('logging out from $result');
  }
}
