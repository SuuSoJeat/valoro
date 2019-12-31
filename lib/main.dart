import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/core/services/auth_service.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/ui/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: FirestoreService()),
        Provider.value(value: AuthService()),
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        title: 'Valoro',
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
