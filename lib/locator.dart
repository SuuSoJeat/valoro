import 'package:get_it/get_it.dart';
import 'package:valoro/core/services/authentication_service.dart';
import 'package:valoro/core/services/dialog_service.dart';
import 'package:valoro/core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
}
