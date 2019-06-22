import 'package:flutter/material.dart';
import 'package:valoro/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valoro',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeView(),
    );
  }
}

