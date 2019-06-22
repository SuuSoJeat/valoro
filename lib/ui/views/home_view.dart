import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/record.dart';

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
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final records = Provider.of<List<Record>>(context);
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: <Widget>[
        ...records.map((data) => _buildListItem(context, data)).toList()
      ],
    );
  }

  Widget _buildListItem(BuildContext context, Record data) {
//    final record = Record.fromSnapshot(data);
    final record = data;
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () {
            record.reference.updateData({'votes': FieldValue.increment(1)});
          },
        ),
      ),
    );
  }
}
