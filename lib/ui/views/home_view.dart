import 'package:flutter/material.dart';
import 'package:valoro/ui/widgets/record_list.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Valoro"),
      ),
      body: RecordList(),
    );
  }
}
