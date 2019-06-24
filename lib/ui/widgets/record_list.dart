import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/record.dart';
import 'package:valoro/ui/widgets/record_item.dart';

class RecordList extends StatelessWidget {
  const RecordList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final records = Provider.of<List<Record>>(context);
    return (records == null)
        ? Container(
            child: Text("No Item."),
          )
        : ListView(
            padding: EdgeInsets.only(top: 20.0),
            children: <Widget>[
              ...records.map((record) => RecordItem(
                    record: record,
                    onTap: () {
//                      record.reference
//                          .updateData({'votes': FieldValue.increment(1)});
                    },
                  ))
            ],
          );
  }
}
