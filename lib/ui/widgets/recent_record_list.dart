import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valoro/core/models/debt.dart';
import 'package:valoro/core/services/firestore_service.dart';
import 'package:valoro/ui/widgets/record_item.dart';

class RecentRecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Debt>>(
      stream: Provider.of<FirestoreService>(context)
          .getRecentDebts(Provider.of<FirebaseUser>(context).uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.data == null) {
          return Container();
        }
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Recent Records',
                      style: TextStyle(
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'VIEW ALL',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  )
                ],
              ),
              ...snapshot.data
                  .map((d) => RecordItem(
                        debt: d,
                        onTap: () {},
                      ))
                  .toList(),
              SizedBox(
                height: 16,
              )
            ],
          ),
        );
      },
    );
  }
}
