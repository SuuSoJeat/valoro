import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/authentication_service.dart';
import 'package:valoro/core/services/dialog_service.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/core/services/navigation_service.dart';
import 'package:valoro/locator.dart';
import 'package:valoro/managers/dialog_manager.dart';
import 'package:valoro/ui/router.dart';

void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: FirestoreService()),
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        title: 'Valoro',
        builder: (context, child) => Navigator(
          key: locator<DialogService>().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)
          ),
        ),
        navigatorKey: locator<NavigationService>().nagivationKey,
        theme: ThemeData(
            primaryColor: Colors.blueAccent[700],
            accentColor: Colors.redAccent[700],
            fontFamily: 'Roboto',
            textTheme:
                TextTheme(display1: TextStyle(fontFamily: 'RobotoSlab'))),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
