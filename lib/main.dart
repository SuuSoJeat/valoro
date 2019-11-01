import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/constants/app_constants.dart';
import 'package:valoro/provider_setup.dart';
import 'package:valoro/ui/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Valoro',
        theme: ThemeData(
          primaryColor: Colors.blueAccent[700],
          accentColor: Colors.redAccent[700],
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            display1: TextStyle(
              fontFamily: 'RobotoSlab'
            )
          )
        ),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
