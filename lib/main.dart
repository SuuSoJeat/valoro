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
          primarySwatch: Colors.red,
        ),
        initialRoute: RoutePaths.Home,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
