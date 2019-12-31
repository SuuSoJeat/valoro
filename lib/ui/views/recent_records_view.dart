import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/viewmodels/widgets/recent_record_model.dart';
import 'package:valoro/ui/views/base_widget.dart';
import 'package:valoro/ui/widgets/record_item.dart';
import 'package:valoro/ui/widgets/record_list.dart';

class RecentRecordsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Records',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          )
        ],
      ),
      body: BaseWidget<RecentRecordModel>(
        model: RecentRecordModel(
          firestoreService: Provider.of(context),
          uid: Provider.of<FirebaseUser>(context).uid,
        ),
        onModelReady: (model) => model.getRecords(),
        builder: (context, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.records.isEmpty
                ? Center(
                    child: Text('No Item.'),
                  )
                : ListView.builder(
                    itemCount: model.records.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(model.records[index].id),
                    ),
                  ),
      ),
    );
  }
}
